# 177. Nth Highest Salary

**LeetCode URL:** https://leetcode.com/problems/nth-highest-salary/  
**Difficulty:** Medium  
**Topics:** SQL, Window Function, ROW_NUMBER(), DISTINCT

---

## Problem  
Given an `Employee` table with columns `id` and `salary`, write a query to find the nth highest **distinct** salary. If there are fewer than `n` distinct salaries, return `NULL`.

---

## Approach  
1. **Deduplicate salaries**  
   - Use `SELECT DISTINCT salary FROM Employee` to collapse any duplicate salary values into one row each.

2. **Rank the distinct salaries**  
   - Apply `ROW_NUMBER() OVER (ORDER BY salary DESC)` on the deduplicated set to assign 1 to the highest salary, 2 to the second-highest distinct salary, and so on.

3. **Filter by n**  
   - Wrap the above in a CTE or subquery, then select the row where `rn = n`.  
   - If no such row exists, the result comes back as `NULL`.

---

## Edge Cases  
1. **Fewer than n distinct salaries**  
   - e.g. salaries = `[300, 200, 200]`, n = 3 -> return `NULL`  
2. **All salaries identical**  
   - e.g. salaries = `[100, 100, 100]`; n = 1 -> return `100`; n = 2 → return `NULL`  
3. **n = 1**  
   - Always returns the maximum salary (the top distinct value)  

---

## Solution  

In `solution.sql`, alias the result column as `getNthHighestSalary(n)` (e.g. ``AS `getNthHighestSalary(2)` `` when n = 2).

See [`solution.sql`](./solution.sql) for the full query.


---

## Tests  
See [`tests.sql`](./tests.sql) for sample DDL/DML setup and expected outputs.  
