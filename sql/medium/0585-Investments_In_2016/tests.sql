-- tests.sql for LeetCode 585: Investments in 2016

-- =========================================
-- Example 1
-- Input:
--   Insurance:
--     (1, 10,  5, 10, 10),
--     (2, 20, 20, 20, 20),
--     (3, 10, 30, 20, 20),
--     (4, 10, 40, 40, 40)
-- Expected Output:
--   tiv_2016 = 45.00
-- =========================================

DROP TABLE IF EXISTS Insurance;
CREATE TABLE Insurance (
  pid      INT,
  tiv_2015 FLOAT,
  tiv_2016 FLOAT,
  lat      FLOAT,
  lon      FLOAT
);

INSERT INTO Insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES
  (1, 10,  5, 10, 10),
  (2, 20, 20, 20, 20),
  (3, 10, 30, 20, 20),
  (4, 10, 40, 40, 40);

WITH UniqueLocation AS (
  SELECT lat, lon
  FROM Insurance
  GROUP BY lat, lon
  HAVING COUNT(*) = 1
),
DuplicateTIV AS (
  SELECT tiv_2015
  FROM Insurance
  GROUP BY tiv_2015
  HAVING COUNT(*) >= 2
)
SELECT
  ROUND(SUM(i.tiv_2016), 2) AS tiv_2016
FROM Insurance AS i
JOIN UniqueLocation AS u
  ON i.lat = u.lat
 AND i.lon = u.lon
JOIN DuplicateTIV AS d
  ON i.tiv_2015 = d.tiv_2015;

-- =========================================
-- Example 2
-- Input:
--   Insurance:
--     (1, 50, 10, 10, 10),
--     (2, 60, 15, 10, 10),
--     (3, 70, 20, 20, 20)
-- Expected Output:
--   tiv_2016 = NULL
-- =========================================

TRUNCATE TABLE Insurance;

INSERT INTO Insurance (pid, tiv_2015, tiv_2016, lat, lon) VALUES
  (1, 50, 10, 10, 10),
  (2, 60, 15, 10, 10),
  (3, 70, 20, 20, 20);

WITH UniqueLocation AS (
  SELECT lat, lon
  FROM Insurance
  GROUP BY lat, lon
  HAVING COUNT(*) = 1
),
DuplicateTIV AS (
  SELECT tiv_2015
  FROM Insurance
  GROUP BY tiv_2015
  HAVING COUNT(*) >= 2
)
SELECT
  ROUND(SUM(i.tiv_2016), 2) AS tiv_2016
FROM Insurance AS i
JOIN UniqueLocation AS u
  ON i.lat = u.lat
 AND i.lon = u.lon
JOIN DuplicateTIV AS d
  ON i.tiv_2015 = d.tiv_2015;
