-- Схема таблицы для ClickHouse

CREATE TABLE IF NOT EXISTS server_logs (
    timestamp DateTime,
    user_id UInt16,
    endpoint String,
    response_time_ms UInt16,
    status_code UInt16
) ENGINE = MergeTree()
ORDER BY (endpoint);
