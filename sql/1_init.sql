-- 1. Создаем схему в Iceberg (она замапится на S3)
CREATE SCHEMA IF NOT EXISTS iceberg.public;

-- 2. Создаем Iceberg таблицу
CREATE TABLE IF NOT EXISTS iceberg.public.events (
    event_id BIGINT,
    user_id BIGINT,
    event_name VARCHAR
) WITH (
    format = 'PARQUET'
);

-- 3. Вставляем данные (Iceberg)
INSERT INTO iceberg.public.events (event_id, user_id, event_name) 
VALUES (1, 101, 'login'), (2, 102, 'click');

-- 4. Создаем таблицу в PostgreSQL (метакаталог используется и как сервисная БД)
CREATE TABLE IF NOT EXISTS pg.public.users (
    user_id BIGINT,
    username VARCHAR
);

-- 5. Вставляем данные (Postgres)
INSERT INTO pg.public.users (user_id, username) 
VALUES (101, 'alex_dev'), (102, 'maria_data');