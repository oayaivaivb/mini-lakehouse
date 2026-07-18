-- Клиенты
INSERT INTO pg.public.clients VALUES 
(1, 'Иван Иванов', 'ACTIVE', 100000.00, 'LOW'),
(2, 'Анна Смирнова', 'ACTIVE', 50000.00, 'HIGH'), -- Клиент в зоне риска
(3, 'Олег Тиньков', 'ACTIVE', 500000.00, 'MEDIUM');

-- Транзакции (Iceberg)
-- Обычные транзакции
INSERT INTO iceberg.silver.transactions VALUES 
(1001, 1, 1500.00, current_timestamp - INTERVAL '2' HOUR, '192.168.1.1', 'WEB'),
(1002, 3, 45000.00, current_timestamp - INTERVAL '1' HOUR, '88.22.11.5', 'MOBILE');

-- ФРОД-ПАТТЕРН: Анна (HIGH риск) делает несколько крупных переводов подряд с подозрительного IP
INSERT INTO iceberg.silver.transactions VALUES 
(1003, 2, 45000.00, current_timestamp - INTERVAL '5' MINUTE, '45.133.2.1', 'UNKNOWN_API'),
(1004, 2, 48000.00, current_timestamp - INTERVAL '4' MINUTE, '45.133.2.1', 'UNKNOWN_API'),
(1005, 2, 49000.00, current_timestamp - INTERVAL '2' MINUTE, '45.133.2.1', 'UNKNOWN_API');
