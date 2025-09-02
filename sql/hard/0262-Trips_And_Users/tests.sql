-- tests.sql for LeetCode 262: Trips and Users
-- Query computes daily cancellation rate for trips where BOTH client and driver are unbanned
-- between '2013-10-01' and '2013-10-03'. Uses AVG(CASE...) rounded to 2 decimals.

-- =========================================
-- Example 1 (Prompt)
-- Input:
--   Trips:
--     (1, 1, 10, 1, 'completed',           '2013-10-01'),
--     (2, 2, 11, 1, 'cancelled_by_driver', '2013-10-01'),
--     (3, 3, 12, 6, 'completed',           '2013-10-01'),
--     (4, 4, 13, 6, 'cancelled_by_client', '2013-10-01'),
--     (5, 1, 10, 1, 'completed',           '2013-10-02'),
--     (6, 2, 11, 6, 'completed',           '2013-10-02'),
--     (7, 3, 12, 6, 'completed',           '2013-10-02'),
--     (8, 2, 12, 12,'completed',           '2013-10-03'),
--     (9, 3, 10, 12,'completed',           '2013-10-03'),
--     (10,4, 13, 12,'cancelled_by_driver', '2013-10-03')
--
--   Users:
--     (1,  'No', 'client'),
--     (2,  'Yes','client'),
--     (3,  'No', 'client'),
--     (4,  'No', 'client'),
--     (10, 'No', 'driver'),
--     (11, 'No', 'driver'),
--     (12, 'No', 'driver'),
--     (13, 'No', 'driver')
--
-- Expected Output:
-- +------------+-------------------+
-- | Day        | Cancellation Rate |
-- +------------+-------------------+
-- | 2013-10-01 | 0.33              |
-- | 2013-10-02 | 0.00              |
-- | 2013-10-03 | 0.50              |
-- +------------+-------------------+
-- =========================================

CREATE TABLE Users (
  users_id INT,
  banned   VARCHAR(10),
  role     VARCHAR(20)
);

CREATE TABLE Trips (
  id         INT,
  client_id  INT,
  driver_id  INT,
  city_id    INT,
  status     VARCHAR(30),
  request_at VARCHAR(20)
);

INSERT INTO Users (users_id, banned, role) VALUES
  (1,  'No',  'client'),
  (2,  'Yes', 'client'),
  (3,  'No',  'client'),
  (4,  'No',  'client'),
  (10, 'No',  'driver'),
  (11, 'No',  'driver'),
  (12, 'No',  'driver'),
  (13, 'No',  'driver');

INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES
  (1,  1, 10, 1,  'completed',            '2013-10-01'),
  (2,  2, 11, 1,  'cancelled_by_driver',  '2013-10-01'),
  (3,  3, 12, 6,  'completed',            '2013-10-01'),
  (4,  4, 13, 6,  'cancelled_by_client',  '2013-10-01'),
  (5,  1, 10, 1,  'completed',            '2013-10-02'),
  (6,  2, 11, 6,  'completed',            '2013-10-02'),
  (7,  3, 12, 6,  'completed',            '2013-10-02'),
  (8,  2, 12, 12, 'completed',            '2013-10-03'),
  (9,  3, 10, 12, 'completed',            '2013-10-03'),
  (10, 4, 13, 12, 'cancelled_by_driver',  '2013-10-03');

-- Run the solution query (CTE-free, joins ensure both participants unbanned)
SELECT
  day,
  ROUND(SUM(is_cancelled) * 1.0 / COUNT(*), 2) AS `Cancellation Rate`
FROM (
  SELECT
    t.request_at AS day,
    (t.status IN ('cancelled_by_client','cancelled_by_driver')) + 0 AS is_cancelled
  FROM Trips t
  JOIN Users uc ON uc.users_id = t.client_id
  JOIN Users ud ON ud.users_id = t.driver_id
  WHERE uc.banned = 'No'
    AND ud.banned = 'No'
    AND t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
) sub
GROUP BY day
ORDER BY day;

-- =========================================
-- Example 2 (Edge cases)
-- Input:
--   Trips:
--     - some trips on 2013-10-01 but both participants banned -> excluded
--     - some trips on 2013-10-02 with mixed statuses
--     - no trips on 2013-10-03 (so should not appear)
--
-- Expected behavior:
--   - Days with zero unbanned trips do not appear in result.
--   - Only trips where both users are unbanned are counted.
-- =========================================

TRUNCATE TABLE Users;
TRUNCATE TABLE Trips;

INSERT INTO Users (users_id, banned, role) VALUES
  (1,  'Yes', 'client'),
  (2,  'No',  'client'),
  (10, 'Yes', 'driver'),
  (11, 'No',  'driver');

INSERT INTO Trips (id, client_id, driver_id, city_id, status, request_at) VALUES
  -- both banned or one banned on 2013-10-01 -> excluded entirely
  (1, 1, 10, 1, 'completed',           '2013-10-01'),
  (2, 1, 10, 1, 'cancelled_by_client', '2013-10-01'),
  -- 2013-10-02 has two valid trips (both users unbanned) one cancelled
  (3, 2, 11, 1, 'completed',           '2013-10-02'),
  (4, 2, 11, 1, 'cancelled_by_driver', '2013-10-02'),
  -- 2013-10-03 has no trips (should not appear)
  (5, 1, 11, 1, 'completed',           '2013-10-04'); -- outside target range

SELECT
  day,
  ROUND(SUM(is_cancelled) * 1.0 / COUNT(*), 2) AS `Cancellation Rate`
FROM (
  SELECT
    t.request_at AS day,
    (t.status IN ('cancelled_by_client','cancelled_by_driver')) + 0 AS is_cancelled
  FROM Trips t
  JOIN Users uc ON uc.users_id = t.client_id
  JOIN Users ud ON ud.users_id = t.driver_id
  WHERE uc.banned = 'No'
    AND ud.banned = 'No'
    AND t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
) sub
GROUP BY day
ORDER BY day;

-- Expected output for Example 2 (only 2013-10-02 should appear):
-- +------------+-------------------+
-- | Day        | Cancellation Rate |
-- +------------+-------------------+
-- | 2013-10-02 | 0.50              |
-- +------------+-------------------+
