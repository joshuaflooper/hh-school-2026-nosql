-- Схема таблицы для ClickHouse

CREATE TABLE IF NOT EXISTS server_logs (
    timestamp DateTime,
    user_id UInt32,
    endpoint String,
    response_time_ms UInt32,
    status_code UInt16
) ENGINE = MergeTree()
ORDER BY (timestamp, endpoint);
