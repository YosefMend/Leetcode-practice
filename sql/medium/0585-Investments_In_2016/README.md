# 585. Investments in 2016

**LeetCode URL:** https://leetcode.com/problems/investments-in-2016/  
**Difficulty:** Medium  
**Topics:** SQL, GROUP BY, HAVING, JOIN, CTE

---

## Problem  
Given the `Insurance(pid, tiv_2015, tiv_2016, lat, lon)` table, return the **sum of all** `tiv_2016` values for policyholders who:  
1. Share their `tiv_2015` value with at least one other record.  
2. Live in a unique city (their `(lat, lon)` pair appears exactly once in the table).  

Round the result to two decimal places.

---

## Approach

1. **Identify unique locations**  
   - Group by `(lat, lon)` and keep only those pairs that appear exactly once.

2. **Identify duplicated 2015 values**  
   - Group by `tiv_2015` and keep only those values that occur two or more times.

3. **Select qualifying policies**  
   - From the original table, retain only rows whose `(lat, lon)` is in the unique‐locations set **and** whose `tiv_2015` is in the duplicated‐values set.

4. **Aggregate the 2016 values**  
   - Sum the remaining `tiv_2016` values and round the result to two decimal places.

---

## Edge Cases  
- No `tiv_2015` value occurs more than once → returns `NULL`.  
- No `(lat, lon)` pair is unique → returns `NULL`.  
- Some `tiv_2015` values are duplicated but none of those policies live in a unique city → returns `NULL`.

---

## Solution  
In `solution.sql`, round the sum to two decimal places and alias the result column as `tiv_2016`.  
See [`solution.sql`](./solution.sql) for the full query.

---

## Tests  
See [`tests.sql`](./tests.sql) for sample DDL/DML setup and expected outputs.  
