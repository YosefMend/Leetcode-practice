-- LeetCode 585: Investments in 2016
-- URL: https://leetcode.com/problems/investments-in-2016/

-- Approach:
-- 1) Identify unique locations by grouping on (lat, lon) and keeping only those with COUNT = 1
-- 2) Identify duplicated 2015 values by grouping on tiv_2015 and keeping only those with COUNT ≥ 2
-- 3) Join Insurance back to both CTEs to enforce both criteria
-- 4) Sum the selected tiv_2016 values and ROUND to two decimal places, aliasing as tiv_2016

WITH UniqueLocation AS (
  SELECT lat, lon
  FROM Insurance
  GROUP BY lat, lon
  HAVING COUNT(*) = 1
), -- Only truly unique locations
  
DuplicateTIV AS (
  SELECT tiv_2015
  FROM Insurance
  GROUP BY tiv_2015
  HAVING COUNT(*) >= 2
) -- only values shared by >= 2 policies
  
SELECT ROUND(SUM(i.tiv_2016), 2) AS tiv_2016 -- Final rounded sum
FROM Insurance AS i
JOIN UniqueLocation AS u
  ON i.lat = u.lat
 AND i.lon = u.lon -- Enforce unique city filter
JOIN DuplicateTIV AS d
  ON i.tiv_2015 = d.tiv_2015; -- Enforce duplicate 2015 filter
