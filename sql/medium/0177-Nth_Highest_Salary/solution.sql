-- LeetCode 177: Nth Highest Salary
-- URL: https://leetcode.com/problems/nth-highest-salary/

-- Approach: 
-- 1) Collapse to distinct salaries  
-- 2) Number them descending with ROW_NUMBER()  
-- 3) Select the row where rn = n (returns NULL if not found) and alias it to match LeetCode's requires header

WITH DistinctSalary AS (
  SELECT DISTINCT salary
  FROM Employee
),
RankedSalary AS (
  SELECT salary, 
    -- Assign a rank 1 = highest salary, 2 = second highest, etc.
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
  FROM DistinctSalary
)

SELECT 
  (SELECT salary
  FROM RankedSalary
  WHERE rn = @n  -- LeetCode's input parameter
) AS 'getNthHighestSalary(@n)'; -- LeetCode requires use of specific header
