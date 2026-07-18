-- Gold-витрина: Подозрительные транзакции
SELECT 
    t.transaction_id,
    c.full_name,
    c.risk_level,
    t.amount,
    c.daily_limit,
    t.ip_address,
    t.transaction_time
FROM iceberg.silver.transactions t
JOIN pg.public.clients c ON t.client_id = c.client_id
WHERE c.risk_level = 'HIGH' 
  AND t.amount > (c.daily_limit * 0.8) -- Транзакция больше 80% суточного лимита
ORDER BY t.transaction_time DESC;