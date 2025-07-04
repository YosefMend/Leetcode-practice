# 626. Exchange Seats

**LeetCode URL:** https://leetcode.com/problems/exchange-seats/  
**Difficulty:** Medium  
**Topics:** SQL, CASE, modulo arithmetic, Window Function (LEAD/LAG)

---

## Problem  
Given a `Seat(id, student)` table where `id` starts at 1 and increments continuously, swap the student names of every two consecutive seats. If there’s an odd student out at the end, leave them in place. Return the result ordered by `id` ascending.

---

## Approach  

### 1. Modulo + CASE (ANSI‐SQL compatible)  
1. Compute a **new `id`** for each row:  
   - If `id % 2 = 1` and there *is* a next row, set `new_id = id + 1`.  
   - If `id % 2 = 0`, set `new_id = id - 1`.  
   - Else (last odd), set `new_id = id`.  
2. **SELECT** `new_id` and `student` from `Seat`, then **ORDER BY** `new_id`.

### 2. Window Function (LEAD/LAG)  
1. Use `LEAD(student) OVER (ORDER BY id)` to peek at the next student and  
   `LAG(student) OVER (ORDER BY id)` to peek at the previous.  
2. In a `CASE` expression:  
   - **Odd `id`**: if `LEAD(...)` is non-NULL, use `LEAD(student)`.  
   - **Even `id`**: use `LAG(student)`.  
   - **Else**: use original `student`.  
3. **ORDER BY** `id`.

---

## Edge Cases  
- **Odd total count** → last student’s seat remains unchanged.  
- **Only one row** → no swap, returns the same row.  
- **Two rows** → they simply swap places.

---

## Solution  
In `solution.sql`, implemented both approaches (one with `CASE+modulo` and one with `LEAD/LAG`).  
See [`solution.sql`](./solution,sql) for the full queries.

---

## Tests  
See [`tests.sql`](./tests.sql) for sample DDL/DML setups and expected outputs covering odd and even counts.  
