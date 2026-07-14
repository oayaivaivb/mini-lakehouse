-- Обновляем данные, чтобы создать новый снапшот
UPDATE iceberg.public.events SET event_name = 'logout' WHERE event_id = 1;