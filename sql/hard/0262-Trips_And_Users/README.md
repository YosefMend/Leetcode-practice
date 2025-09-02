# 262. Trips and Users

**LeetCode URL:** https://leetcode.com/problems/trips-and-users/  
**Difficulty:** Hard  
**Topics:** SQL, JOIN, Aggregation, Conditional Aggregation, Date Filtering

---

## Problem  
Given `Trips(id, client_id, driver_id, city_id, status, request_at)` and `Users(users_id, banned, role)`, compute the daily **cancellation rate** for trips where **both** client and driver are unbanned. The cancellation rate for a day is:

> (number of canceled requests with unbanned users on that day) / (total requests with unbanned users on that day)

Calculate this for each day between `2013-10-01` and `2013-10-03` that has at least one trip, and round the rate to two decimal places. Return columns `Day` and `Cancellation Rate`.

---

## Intuition  
We only care about trips where *both* participants are unbanned and only within a 3-day window. After filtering that clean set, the daily cancellation rate is simply the fraction of those trips whose `status` is a cancellation. So: filter first, then aggregate per day.

---

## Approach  
1. **Filter to unbanned participants**  
   - Join `Trips` to `Users` twice (as `uc` for client and `ud` for driver) and require `uc.banned = 'No' AND ud.banned = 'No'` to ensure both parties are unbanned.

2. **Restrict date range**  
   - Keep only rows with `request_at BETWEEN '2013-10-01' AND '2013-10-03'`. (Because `request_at` is `YYYY-MM-DD` text, `BETWEEN` on the string works; you can `CAST` if you prefer.)

3. **Aggregate per day**  
   - `GROUP BY request_at` and compute:
     - `canceled_count = SUM(CASE WHEN status IN ('cancelled_by_client','cancelled_by_driver') THEN 1 ELSE 0 END)`
     - `total_count = COUNT(*)`

4. **Compute & round rate**  
   - `Cancellation Rate = ROUND(canceled_count * 1.0 / total_count, 2)` (or `ROUND(AVG(CASE WHEN ... THEN 1 ELSE 0 END), 2)`).

5. **Subquery / CTE**  
   - You can pre-filter the unbanned trips with a CTE and aggregate on top of that (the solution uses a subquery).

---

## Edge Cases  
- **Trips where either participant is banned** — these are excluded entirely.  
- **Days with zero unbanned trips** — do not appear in the result (we only return days with at least one trip).  
- **`request_at` format / NULLs** — if malformed or `NULL`, filter those out before grouping.  
- **`banned` NULLs** — decide whether NULL means banned; the solution assumes `'No'` is required to include a user.  
- **Integer division** — ensure floating-point division (e.g. multiply numerator by `1.0`) before rounding.  
- **Performance** — with large tables, indexes on `request_at` and `users_id` (or appropriate composite indexes) speed the joins and filtering.

---

## Solution  
In `solution.sql`, pre-filter trips to unbanned client+driver within the date range, aggregate by `request_at`, compute canceled and total counts, and return `request_at AS Day` along with `ROUND(..., 2)` for `Cancellation Rate`. The provided `solution.sql` uses a derived-table/subquery approach (no CTE required).  
See [`solution.sql`](solution.sql) for the full query.

---

## Tests  
See [`tests.sql`](tests.sql) for DDL/DML and sample cases (including the example from the prompt and additional edge cases).
