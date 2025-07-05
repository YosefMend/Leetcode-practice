# 1907. Count Salary Categories

**LeetCode URL:** https://leetcode.com/problems/count-salary-categories/  
**Difficulty:** Medium  
**Topics:** SQL, Conditional Aggregation, CTE, CASE

---

## Problem  
Given an `Accounts(account_id, income)` table, categorize each account’s `income` into:  
- **Low Salary**: income < 20000  
- **Average Salary**: 20000 ≤ income ≤ 50000  
- **High Salary**: income > 50000  

Return one row per category with the count of accounts in that bucket. If a category has no accounts, its count should be 0.

---

## Approach  
1. **Aggregate in one pass**  
   - Use `SUM(CASE WHEN … THEN 1 ELSE 0 END)` to count rows in each salary range in a single scan.  
2. **Isolate the tallies**  
   - Place the three aggregated counts (`low_cnt`, `avg_cnt`, `high_cnt`) into a CTE or subquery.  
3. **Unpivot into rows**  
   - Emit three rows—one per salary category—by selecting each tally with its label and combining them via `UNION ALL`.  
4. **Finalize output**  
   - Ensure the final table has columns `category` and `accounts_count`, covering all three buckets.

---

## Edge Cases  
- No accounts in one or more categories → those categories still appear with count = 0.  
- All incomes fall into a single category → the other two should return 0.  
- Empty `Accounts` table → all three counts = 0.

---

## Solution  
In `solution.sql`, perform a single‐pass conditional aggregation and unpivot the results into three rows.  
See [`solution.sql`](./solution.sql) for the full query.

---

## Tests  
See [`tests.sql`](./tests.sql) for sample DDL/DML setup and expected outputs.  
