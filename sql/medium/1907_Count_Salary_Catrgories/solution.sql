-- LeetCode 1907: Count Salary Categories
-- URL: https://leetcode.com/problems/count-salary-categories/

-- Approach:
-- 1) Aggregate counts for each bucket in one pass using SUM(CASE WHEN … THEN 1 ELSE 0 END)
-- 2) Wrap those tallies in a CTE for clarity
-- 3) Unpivot the three aggregated values into rows with UNION ALL

WITH Counts AS (
  SELECT
    SUM(CASE WHEN income < 20000                THEN 1 ELSE 0 END) AS low_cnt,
    SUM(CASE WHEN income BETWEEN 20000 AND 50000 THEN 1 ELSE 0 END) AS avg_cnt,
    SUM(CASE WHEN income > 50000                THEN 1 ELSE 0 END) AS high_cnt
  FROM Accounts
)
SELECT 'Low Salary'     AS category, low_cnt  AS accounts_count FROM Counts
UNION ALL
SELECT 'Average Salary' AS category, avg_cnt  AS accounts_count FROM Counts
UNION ALL
SELECT 'High Salary'    AS category, high_cnt AS accounts_count FROM Counts;
