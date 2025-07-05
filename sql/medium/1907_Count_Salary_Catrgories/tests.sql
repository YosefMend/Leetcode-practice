-- tests.sql for LeetCode 1907: Count Salary Categories

-- =========================================
-- Example 1
-- Input:
--   Accounts:
--     (3, 108939),
--     (2, 12747),
--     (8, 87709),
--     (6, 91796)
-- Expected Output:
--   category        | accounts_count
--   --------------------------------
--   Low Salary      | 1
--   Average Salary  | 0
--   High Salary     | 3
-- =========================================

DROP TABLE IF EXISTS Accounts;
CREATE TABLE Accounts (
  account_id INT,
  income     INT
);

INSERT INTO Accounts (account_id, income) VALUES
  (3, 108939),
  (2, 12747),
  (8, 87709),
  (6, 91796);

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

-- =========================================
-- Example 2
-- Input:
--   Accounts:
--     (1, 15000),
--     (2, 30000),
--     (3, 60000),
--     (4, 25000),
--     (5, 5000)
-- Expected Output:
--   category        | accounts_count
--   --------------------------------
--   Low Salary      | 2
--   Average Salary  | 2
--   High Salary     | 1
-- =========================================

TRUNCATE TABLE Accounts;

INSERT INTO Accounts (account_id, income) VALUES
  (1, 15000),
  (2, 30000),
  (3, 60000),
  (4, 25000),
  (5,  5000);

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
