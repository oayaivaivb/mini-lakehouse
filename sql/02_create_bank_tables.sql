-- Горячие данные: Справочник клиентов в Postgres
CREATE TABLE IF NOT EXISTS pg.public.clients (
    client_id INT,
    full_name VARCHAR,
    status VARCHAR,
    daily_limit DECIMAL(15, 2),
    risk_level VARCHAR
);

-- Холодные данные: Транзакции в Iceberg (Silver слой) с партиционированием по дням
CREATE TABLE IF NOT EXISTS iceberg.silver.transactions (
    transaction_id BIGINT,
    client_id INT,
    amount DECIMAL(15, 2),
    transaction_time TIMESTAMP(6) WITH TIME ZONE,
    ip_address VARCHAR,
    terminal_id VARCHAR
) WITH (
    format = 'PARQUET',
    partitioning = ARRAY['day(transaction_time)']
);
