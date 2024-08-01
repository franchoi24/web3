DROP TABLE IF EXISTS currency_stock;
CREATE TEMPORARY TABLE currency_stock (
    timestamp DATE,
    address VARCHAR(50),
    token VARCHAR(10),
    amount INT,
    price_in_eth DECIMAL(10, 2),
    row_number INT
);

INSERT INTO currency_stock (timestamp, address, token, amount, price_in_eth, row_number)
SELECT timestamp, address, token, amount, price_in_eth, ROW_NUMBER() OVER (PARTITION BY token, address ORDER BY timestamp) AS row_number
FROM transactions;


DROP FUNCTION sell_currency_stock(character varying,character varying,numeric);
CREATE OR REPLACE FUNCTION sell_currency_stock(
    requested_address VARCHAR,
    requested_token VARCHAR,
    requested_amount NUMERIC
)
RETURNS TABLE(ret_amount NUMERIC, price NUMERIC) 
AS
$$
DECLARE
    record RECORD;
    actual_amount NUMERIC;
BEGIN
    FOR record IN
        SELECT amount, price_in_eth, row_number, token, address, timestamp
        FROM currency_stock
        WHERE address = requested_address AND token = requested_token AND amount > 0
        ORDER BY timestamp
    LOOP
        IF requested_amount <= 0 THEN
            EXIT;
        END IF;

        IF requested_amount > record.amount THEN
            actual_amount := record.amount;
        ELSE
            actual_amount := requested_amount;
        END IF;

        RETURN QUERY SELECT actual_amount, record.price_in_eth;

        UPDATE currency_stock
        SET amount = amount - actual_amount
        WHERE token = record.token AND address = record.address AND row_number = record.row_number AND timestamp = record.timestamp;

        requested_amount := requested_amount - actual_amount;
    END LOOP;

    RETURN;
END;
$$
LANGUAGE plpgsql;

SELECT * FROM sell_currency_stock('a1', 't1', 13);




WITH DailyTransactions AS (
  SELECT
    timestamp,
    address,
    token,
    SUM(CASE WHEN action LIKE 'buy' THEN amount ELSE -amount END) AS net_amount,
    SUM(CASE WHEN action LIKE 'buy' THEN amount * price_in_eth ELSE -amount * price_in_eth END) AS net_priced_amount
  FROM transactions
  GROUP BY timestamp, address, token
),
CumulativeBalances AS (
  SELECT
    timestamp,
    address,
    token,
    SUM(net_amount) OVER (PARTITION BY address, token ORDER BY timestamp) AS cumulative_amount,
    SUM(net_priced_amount) OVER (PARTITION BY address, token ORDER BY timestamp) AS cumulative_priced_in_eth
  FROM DailyTransactions
)
SELECT *
FROM CumulativeBalances
ORDER BY timestamp, address;



