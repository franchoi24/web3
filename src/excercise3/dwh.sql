CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    registration_date_id BIGINT NOT NULL,
    FOREIGN KEY (registration_date_id) REFERENCES Time(date_id)
);

CREATE TABLE Time (
    date_id SERIAL PRIMARY KEY,
    year INT NOT NULL,
    quarter INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL,
    weekend BOOLEAN NOT NULL
);

CREATE TABLE Transactions ( 
    transaction_id SERIAL PRIMARY KEY,
    user_from_id BIGINT NOT NULL,
    user_to_id BIGINT NOT NULL,
    asset_name VARCHAR(255) NOT NULL,
    asset_symbol VARCHAR(255) NOT NULL,
    asset_type VARCHAR(255) NOT NULL,
    date_id BIGINT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    price_in_eth DECIMAL(10, 2) NOT NULL,
    price_in_usd DECIMAL(10, 2) NOT NULL,
    transaction_type VARCHAR(255) NOT NULL,
    transaction_description TEXT,
    protocol_name VARCHAR(255) NOT NULL,
    protocol_description TEXT,
    timestamp DATE NOT NULL,
    FOREIGN KEY (user_from_id) REFERENCES Users(user_id),
    FOREIGN KEY (user_to_id) REFERENCES Users(user_id),
    FOREIGN KEY (date_id) REFERENCES Time(date_id)
);


CREATE TABLE AssetHolding (
    holding_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    asset_name VARCHAR(255) NOT NULL,
    asset_symbol VARCHAR(255) NOT NULL,
    asset_type VARCHAR(255) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    value_in_eth DECIMAL(10, 2) NOT NULL,
    value_in_usd DECIMAL(10, 2) NOT NULL,
    holding_date_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (holding_date_id) REFERENCES Time(date_id)
);

CREATE TABLE ProtocolsPerformance (
    protocol_performance_id SERIAL PRIMARY KEY,
    protocol_name VARCHAR(255) NOT NULL,
    protocol_description TEXT,
    volume DECIMAL(30, 2) NOT NULL,
    value_in_eth DECIMAL(30, 2) NOT NULL,
    value_in_usd DECIMAL(30, 2) NOT NULL,
    protocol_date_id BIGINT NOT NULL,
    timestamp DATE NOT NULL,
    FOREIGN KEY (protocol_date_id) REFERENCES Time(date_id)
);

CREATE TABLE AssetPerformance (
    asset_performance_id SERIAL PRIMARY KEY,
    asset_name VARCHAR(255) NOT NULL,
    asset_symbol VARCHAR(255) NOT NULL,
    asset_type VARCHAR(255) NOT NULL,
    volume DECIMAL(30, 2) NOT NULL,
    value_in_eth DECIMAL(30, 2) NOT NULL,
    value_in_usd DECIMAL(30, 2) NOT NULL,
    price_in_eth DECIMAL(20, 2) NOT NULL,
    price_in_usd DECIMAL(20, 2) NOT NULL,
    asset_date_id BIGINT NOT NULL,
    timestamp DATE NOT NULL,
    FOREIGN KEY (asset_date_id) REFERENCES Time(date_id)
);

