-- Создаем логические слои медальонной архитектуры в Iceberg
CREATE SCHEMA IF NOT EXISTS iceberg.bronze;
CREATE SCHEMA IF NOT EXISTS iceberg.silver;
CREATE SCHEMA IF NOT EXISTS iceberg.gold;