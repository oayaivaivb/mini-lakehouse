#!/bin/bash
echo "=== 1. Проверка MinIO ==="
curl -I -s http://localhost:9000/minio/health/live | head -n 1

echo -e "\n=== 2. Проверка Trino (HTTP) ==="
curl -I -s http://localhost:8080/v1/info | head -n 1

echo -e "\n=== 3. Проверка PostgreSQL ==="
docker compose exec -T postgres pg_isready -U iceberg_user -d iceberg_catalog

echo -e "\n=== 4. Проверка Trino (SQL) ==="
cat healthcheck/check_trino.sql | docker compose exec -T trino trino