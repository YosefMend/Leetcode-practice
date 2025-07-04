-- LeetCode 626: Exchange Seats
-- URL: https://leetcode.com/problems/exchange-seats/
-- Approach:
-- 1) Standard‐SQL CASE+modulo: compute a “new_id” for each row (odd → +1, even → −1, final odd → itself) then reorder.
-- 2) Window‐function LEAD/LAG: peek at next/previous student names and swap via CASE.

-- Approach 1: CASE + modulo arithmetic
SELECT
  CASE
    WHEN id % 2 = 1 AND id + 1 <= (SELECT MAX(id) FROM Seat) THEN id + 1 -- Odd IDs swap with next if exists
    WHEN id % 2 = 0 THEN id - 1                                          -- Even IDs swap with previous
    ELSE id                                                              -- Last ID stays in place
  END AS id,
  student
FROM Seat
ORDER BY id;

-- Approach 2: Window functions
SELECT
  id, -- Keep original seat ordering for CASE evaluation 
  CASE
    WHEN id % 2 = 1 AND LEAD(student) OVER (ORDER BY id) IS NOT NULL -- Odd IDs swap with next student if exists
      THEN LEAD(student) OVER (ORDER BY id)                          -- Take the student from the next row
    WHEN id % 2 = 0
      THEN LAG(student) OVER (ORDER BY id)                           -- Even IDs swap with previous student
    ELSE
      student                                                        -- Last odd ID (no next row) keeps original student
  END AS student
FROM Seat
ORDER BY id;
