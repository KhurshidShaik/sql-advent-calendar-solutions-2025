-- SQL Advent Calendar - Day 24
-- Title: New Year Goals - User Type Analysis
-- Difficulty: hard
--
-- Question:
-- As the New Year begins, the goals tracker team wants to understand how user types differ. How many completed goals does the average user have in each user_type?
--
-- As the New Year begins, the goals tracker team wants to understand how user types differ. How many completed goals does the average user have in each user_type?
--

-- Table Schema:
-- Table: user_goals
--   user_id: INT
--   user_type: VARCHAR
--   goal_id: INT
--   goal_status: VARCHAR
--

-- My Solution:

WITH goal_counts AS (
  SELECT 
    user_id, 
    user_type,
    CASE 
      WHEN goal_status = 'completed' THEN 1 
      ELSE 0 
    END AS is_completed
  FROM user_goals
)

SELECT 
  user_type,
  AVG(completed_count) AS avg_completed_goals
FROM (
  SELECT 
    user_id, 
    user_type, 
    SUM(is_completed) AS completed_count
  FROM goal_counts
  GROUP BY user_id, user_type
) AS user_summaries
GROUP BY user_type;
