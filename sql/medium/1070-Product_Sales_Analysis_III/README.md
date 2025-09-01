# Find sales in each product's first year

**LeetCode URL:** *(paste the problem URL here)*  
**Difficulty:** Medium  
**Topics:** SQL, CTE, JOIN, Window Function, Aggregation

---

## Problem  
Given a `Sales(sale_id, product_id, year, quantity, price)` table, for each `product_id` identify the earliest year it appears in the table and return **all sales entries that occurred in that earliest year**.  
Return columns: `product_id`, `first_year`, `quantity`, and `price`. Order does not matter.

---

## Intuition  
We only need the earliest year per product, then every sale row that matches that `(product_id, year)` pair. That naturally breaks the task into two phases: (A) compute the first year per product, and (B) filter the `Sales` rows to those first-year pairs.

---

## Approach
1. **Compute first year per product**  
   - Use `GROUP BY product_id` with `MIN(year)` to produce `(product_id, first_year)`.

2. **Join back to Sales**  
   - Join the aggregated result to the `Sales` table on `product_id` and `Sales.year = first_year` to retrieve every sale row that occurred in the product’s first year.

3. **Select required columns**  
   - Return `product_id`, `first_year`, `quantity`, and `price` from the joined rows (do **not** aggregate unless the problem explicitly asks for totals).

4. **Alternative (window function)**  
   - As a one-query variant, compute `MIN(year) OVER (PARTITION BY product_id)` on every row and filter `WHERE year = first_year`. This avoids an explicit CTE+join and is concise.

---

## Edge Cases
- **Multiple sales in the first year:** return all of them (one row per sale).  
- **Single-row product:** works the same — that row is returned.  
- **NULL years** (if possible): decide whether to exclude NULLs when computing `MIN(year)` (typically you’d exclude them).  
- **Large table**: an index on `(product_id, year)` makes grouping and joining much faster.

---

## Solution  
In `solution.sql` implement either the CTE+JOIN approach or the window-function variant. Alias the earliest year as `first_year` so the output columns match the prompt.  
See `solution.sql` for the full query.

---

## Tests  
See `tests.sql` for sample DDL/DML setups and expected outputs covering products with single/multiple sales in their first year.
