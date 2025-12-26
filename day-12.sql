-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

WITH DailyMessageCounts AS (
    SELECT
        T1.user_id,
        T1.user_name,
        DATE(T2.sent_at) AS activity_day,
        COUNT(T2.message_id) AS message_count
    FROM
        npn_users AS T1
    JOIN
        npn_messages AS T2 ON T1.user_id = T2.sender_id
    GROUP BY
        T1.user_id,
        T1.user_name,
        activity_day
),
RankedUsers AS (
    SELECT
        user_id,
        user_name,
        activity_day,
        message_count,
        DENSE_RANK() OVER (
            PARTITION BY activity_day
            ORDER BY message_count DESC
        ) AS activity_rank
    FROM
        DailyMessageCounts
)
SELECT
    user_id,
    user_name,
    activity_day,
    message_count
FROM
    RankedUsers
WHERE
    activity_rank = 1
ORDER BY
    activity_day,
    user_id;
