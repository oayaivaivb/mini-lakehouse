SELECT 
    e.event_id,
    u.username,
    e.event_name
FROM iceberg.public.events e
JOIN pg.public.users u ON e.user_id = u.user_id;