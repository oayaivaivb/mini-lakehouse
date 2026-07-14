CREATE TABLE IF NOT EXISTS iceberg.public.events (
    event_id BIGINT, user_id BIGINT, event_name VARCHAR
) WITH (format = 'PARQUET');

CREATE TABLE IF NOT EXISTS pg.public.users (
    user_id BIGINT, username VARCHAR
);