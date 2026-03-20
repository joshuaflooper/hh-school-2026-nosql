-- Для проверки пунктов 1-3

INSERT INTO users_posts(user_id, created_at, post_id, content, username) VALUES (1, '2026-03-08 14:23', 1, 'text of post', 'username');
INSERT INTO users_posts(user_id, created_at, post_id, content, username) VALUES (1, '2026-03-20 08:47', 5, 'text of post', 'username');
INSERT INTO users_posts(user_id, created_at, post_id, content, username) VALUES (1, '2026-03-14 16:12', 3, 'text of post', 'username');
INSERT INTO users_posts(user_id, created_at, post_id, content, username) VALUES (1, '2026-03-09 18:59', 2, 'text of post', 'username');
INSERT INTO users_posts(user_id, created_at, post_id, content, username) VALUES (1, '2026-03-17 23:27', 4, 'text of post', 'username');
INSERT INTO users_posts(user_id, created_at, post_id, content, username) VALUES (2, '2026-03-20 09:13', 6, 'text of post', 'username');
INSERT INTO users_posts(user_id, created_at, post_id, content, username) VALUES (2, '2026-03-20 17:26', 7, 'text of post', 'username');

-- Для проверки пункта 4

INSERT INTO topics_dates(topic_id, created_at, user_id, post_id, content, username) VALUES (1, '2026-03-08 14:23', 1, 4, 'text of post', 'username');
INSERT INTO topics_dates(topic_id, created_at, user_id, post_id, content, username) VALUES (1, '2026-03-08 08:47', 2, 3, 'text of post', 'username');
INSERT INTO topics_dates(topic_id, created_at, user_id, post_id, content, username) VALUES (1, '2026-03-08 16:12', 3, 5, 'text of post', 'username');
INSERT INTO topics_dates(topic_id, created_at, user_id, post_id, content, username) VALUES (2, '2026-03-07 18:59', 1, 1, 'text of post', 'username');
INSERT INTO topics_dates(topic_id, created_at, user_id, post_id, content, username) VALUES (2, '2026-03-07 23:27', 2, 2, 'text of post', 'username');