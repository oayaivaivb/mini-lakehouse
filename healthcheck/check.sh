#!/bin/bash
echo "=== Проверка MinIO ==="
curl -I http://localhost:9000/minio/health/live

echo -e "\n=== Проверка Trino ==="
curl -I http://localhost:8080/v1/info

echo -e "\n=== Проверка контейнеров Docker ==="
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"