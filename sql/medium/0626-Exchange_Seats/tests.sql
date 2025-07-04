-- tests.sql for LeetCode 626: Exchange Seats

-- =========================================
-- Example 1
-- Input:
--   Seat:
--     (1, 'Abbot'),
--     (2, 'Doris'),
--     (3, 'Emerson'),
--     (4, 'Green'),
--     (5, 'Jeames')
-- Expected Output:
-- +----+---------+
-- | id | student |
-- +----+---------+
-- |  1 | Doris   |
-- |  2 | Abbot   |
-- |  3 | Green   |
-- |  4 | Emerson |
-- |  5 | Jeames  |
-- +----+---------+
-- =========================================

DROP TABLE IF EXISTS Seat;
CREATE TABLE Seat (
  id       INT,
  student  VARCHAR(50)
);

INSERT INTO Seat (id, student) VALUES
  (1, 'Abbot'),
  (2, 'Doris'),
  (3, 'Emerson'),
  (4, 'Green'),
  (5, 'Jeames');

-- Query (use either approach from solution.sql)
SELECT
  id,
  CASE
    WHEN id % 2 = 1 AND LEAD(student) OVER (ORDER BY id) IS NOT NULL
      THEN LEAD(student) OVER (ORDER BY id)
    WHEN id % 2 = 0
      THEN LAG(student) OVER (ORDER BY id)
    ELSE
      student
  END AS student
FROM Seat
ORDER BY id;

-- =========================================
-- Example 2
-- Input:
--   Seat:
--     (1, 'Alice'),
--     (2, 'Bob'),
--     (3, 'Charlie'),
--     (4, 'Diana')
-- Expected Output:
-- +----+---------+
-- | id | student |
-- +----+---------+
-- |  1 | Bob     |
-- |  2 | Alice   |
-- |  3 | Diana   |
-- |  4 | Charlie |
-- +----+---------+
-- =========================================

TRUNCATE TABLE Seat;

INSERT INTO Seat (id, student) VALUES
  (1, 'Alice'),
  (2, 'Bob'),
  (3, 'Charlie'),
  (4, 'Diana');

SELECT
  id,
  CASE
    WHEN id % 2 = 1 AND LEAD(student) OVER (ORDER BY id) IS NOT NULL
      THEN LEAD(student) OVER (ORDER BY id)
    WHEN id % 2 = 0
      THEN LAG(student) OVER (ORDER BY id)
    ELSE
      student
  END AS student
FROM Seat
ORDER BY id;
