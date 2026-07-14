-- Обновляем данные, чтобы создать новый снапшот
UPDATE iceberg.public.events SET event_name = 'logout' WHERE event_id = 1;

-- Просмотр истории снапшотов (опционально, для дебага)
-- SELECT snapshot_id, committed_at FROM iceberg.public."events$snapshots";

-- Time Travel запрос (в Trino используется FOR TIMESTAMP AS OF или FOR VERSION AS OF)
-- Примечание: вместо <ВРЕМЯ> подставишь реальный timestamp (см. инструкцию ниже)
-- SELECT * FROM iceberg.public.events FOR TIMESTAMP AS OF TIMESTAMP '2026-07-14 12:00:00 UTC';