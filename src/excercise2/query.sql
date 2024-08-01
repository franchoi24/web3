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