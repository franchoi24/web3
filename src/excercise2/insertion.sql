CREATE TABLE transactions (
    timestamp DATE,
    address VARCHAR(50),
    action VARCHAR(4),
    token VARCHAR(10),
    amount INT,
    price_in_eth DECIMAL(10, 2)
);

INSERT INTO transactions (timestamp, address, action, token, amount, price_in_eth) VALUES
('2020-01-01', 'a1', 'buy', 't1', 10, 340),
('2020-01-02', 'a1', 'buy', 't1', 5, 300),
('2020-01-03', 'a1', 'sell', 't1', 4, 350),
('2020-01-04', 'a1', 'buy', 't2', 2, 320),
('2020-01-06', 'a1', 'sell', 't1', 6, 310),
('2020-01-07', 'a1', 'sell', 't1', 1, 310),
('2020-01-08', 'a1', 'buy', 't2', 2, 305),
('2020-01-01', 'a2', 'buy', 't3', 2, 340),
('2020-01-09', 'a1', 'buy', 't3', 3, 300),
('2020-01-10', 'a1', 'sell', 't2', 2, 380),
('2020-01-01', 'a3', 'buy', 't4', 5, 310),
('2020-01-03', 'a3', 'sell', 't4', 1, 320),
('2020-01-05', 'a3', 'buy', 't5', 4, 330),
('2020-01-08', 'a3', 'sell', 't5', 2, 340),
('2020-01-09', 'a2', 'buy', 't6', 6, 350),
('2020-01-10', 'a2', 'sell', 't6', 3, 360);