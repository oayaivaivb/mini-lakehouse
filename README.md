# Mini-Lakehouse Project

## Архитектура
* **Trino** — SQL-движок (порт 8080)
* **PostgreSQL** — метакаталог Iceberg и сервисная БД (порт 5432)
* **MinIO** — S3-хранилище (порт 9000, UI — 9001)

## Инструкция по запуску
1. Склонировать репозиторий.
2. Запустить сервисы: `docker-compose up -d`
3. Дождаться перехода сервисов в статус `healthy` (проверить можно скриптом `./healthcheck/check.sh`).
4. Подключиться к Trino по адресу `jdbc:trino://localhost:8080` (пользователь любой, например `admin`) через DBeaver или Trino CLI.
5. Выполнить скрипты из папки `/sql/` по порядку.

## Доступ к UI
* **MinIO UI:** http://localhost:9001 (admin / password)
* **Trino UI:** http://localhost:8080 (логин любой)