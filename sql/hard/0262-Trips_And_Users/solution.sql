-- LeetCode 262: Trips and Users
-- URL: https://leetcode.com/problems/trips-and-users/
-- Approach:
-- 1) Filter trips to the 3-day window and ensure both client and driver are unbanned by joining Users twice.
-- 2) Group the filtered rows by request_at (the day).
-- 3) Compute the cancellation fraction per day using AVG over a 0/1 expression (AVG(CASE ...)) and ROUND to 2 decimals.
--    Using AVG(CASE ...) avoids integer-division issues and keeps the expression concise.
-- 4) Return request_at AS Day and the rounded Cancellation Rate. Order by Day for readability.

SELECT
  t.request_at AS Day,
  ROUND(
    AVG(
      CASE WHEN t.status IN ('cancelled_by_client','cancelled_by_driver') THEN 1 ELSE 0 END
    )
  , 2) AS `Cancellation Rate`
FROM Trips AS t
  JOIN Users AS uc
    ON uc.users_id = t.client_id
   AND uc.banned = 'No'
  JOIN Users AS ud
    ON ud.users_id = t.driver_id
   AND ud.banned = 'No'
WHERE t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY t.request_at
ORDER BY Day;

-- -------------------------------------------------------
-- Alternative (CTE + explicit counts) — equivalent logic:
-- WITH UnbannedTrips AS (
--   SELECT t.request_at, t.status
--   FROM Trips t
--   JOIN Users uc ON uc.users_id = t.client_id AND uc.banned = 'No'
--   JOIN Users ud ON ud.users_id = t.driver_id AND ud.banned = 'No'
--   WHERE t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
-- )
-- SELECT
--   request_at AS Day,
--   ROUND(
--     SUM(CASE WHEN status IN ('cancelled_by_client','cancelled_by_driver') THEN 1 ELSE 0 END) * 1.0
--     / COUNT(*)
--   , 2) AS `Cancellation Rate`
-- FROM UnbannedTrips
-- GROUP BY request_at
-- ORDER BY Day;
