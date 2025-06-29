-- tests.sql for LeetCode 177: Nth Highest Salary

-- =========================================
-- Example 1
-- Input:
--   Employee: (1,100), (2,200), (3,300)
--   n = 2
-- Expected Output:
--   getNthHighestSalary(2) = 200
-- =========================================

DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
  id INT,
  salary INT
);

INSERT INTO Employee (id, salary) VALUES
  (1, 100),
  (2, 200),
  (3, 300);

-- set test parameter
SET @n := 2;

WITH DistinctSalary AS (
  SELECT DISTINCT salary
  FROM Employee
),
RankedSalary AS (
  SELECT
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
  FROM DistinctSalary
)
SELECT
  (
    SELECT salary
      FROM RankedSalary
     WHERE rn = @n
  ) AS `getNthHighestSalary(2)`;
  
  
  
-- =========================================
-- Example 2
-- Input:
--   Employee: (1,100)
--   n = 2
-- Expected Output:
--   getNthHighestSalary(2) = NULL
-- =========================================

DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee (
  id INT,
  salary INT
);

INSERT INTO Employee (id, salary) VALUES
  (1, 100);

-- set test parameter
SET @n := 2;

WITH DistinctSalary AS (
  SELECT DISTINCT salary
  FROM Employee
),
RankedSalary AS (
  SELECT
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
  FROM DistinctSalary
)
SELECT
  (
    SELECT salary
      FROM RankedSalary
     WHERE rn = @n
     LIMIT 1
  ) AS `getNthHighestSalary(2)`;
