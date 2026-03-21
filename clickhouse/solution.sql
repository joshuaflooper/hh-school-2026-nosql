-- Решение заданий по ClickHouse

CREATE TABLE IF NOT EXISTS server_logs (
    timestamp DateTime,
    user_id UInt16,
    endpoint String,
    response_time_ms UInt16,
    status_code UInt16
) ENGINE = MergeTree()
ORDER BY (endpoint);


-- Выполнил следующую команду, чтобы вставить данные:
-- cat server_logs.csv | docker exec -i clickhouse clickhouse-client --query="INSERT INTO server_logs FORMAT CSVWithNames"


-- 3. Запрос: Топ-5 самых медленных endpoint'ов (по среднему времени ответа)
SELECT endpoint, avg(response_time_ms) as avg_response_time_ms
FROM server_logs
GROUP BY endpoint
ORDER BY avg_response_time_ms DESC
LIMIT 5;


-- 4. Запрос: Количество запросов по часам за весь период в логах
SELECT toStartOfHour(timestamp) AS hour, count(*) AS count
FROM server_logs
GROUP BY hour
ORDER BY hour DESC;


-- 5. Запрос: Процент ошибок (status_code >= 400) для каждого endpoint'а
SELECT 
    endpoint, 
    countIf(status_code >= 400) / count(*) * 100 AS errors_percentage
FROM server_logs
GROUP BY endpoint;