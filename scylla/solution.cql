CREATE keyspace test_ks
    WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

USE test_ks;

-- Таблица для пунктов 1-3

CREATE table users_posts (
    user_id int,
    created_at timestamp,
    post_id int,
    content text,
    username text,
    PRIMARY KEY (user_id, created_at, post_id)
) WITH CLUSTERING ORDER BY (created_at DESC);

SELECT post_id, content, created_at
FROM users_posts
WHERE user_id = 1;

SELECT post_id, content, created_at, username
FROM users_posts
WHERE user_id = 1
LIMIT 1;

SELECT post_id, content, created_at, username
FROM users_posts
WHERE user_id = 1 AND created_at > '2026-03-12';

-- Таблица для пункта 4

CREATE table topics_dates (
    topic_id int,
    created_at timestamp,
    user_id int,
    post_id int,
    content text,
    username text,
    PRIMARY KEY (topic_id, created_at, post_id)
) WITH CLUSTERING ORDER BY (created_at DESC);

SELECT user_id, username, post_id, created_at
FROM topics_dates
WHERE topic_id = 1
AND created_at >= '2026-03-08' 
AND created_at < '2026-03-09';
