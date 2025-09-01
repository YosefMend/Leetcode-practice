-- tests.sql for "Find sales in each product's first year"
-- Uses the CTE+JOIN approach from solution.sql

-- =========================================
-- Example 1 (from prompt)
-- Input:
--   Sales:
--     (1, 100, 2008, 10, 5000),
--     (2, 100, 2009, 12, 5000),
--     (7, 200, 2011, 15, 9000)
-- Expected Output (order may vary):
-- +------------+------------+----------+-------+
-- | product_id | first_year | quantity | price |
-- +------------+------------+----------+-------+
-- | 100        | 2008       | 10       | 5000  |
-- | 200        | 2011       | 15       | 9000  |
-- +------------+------------+----------+-------+
-- =========================================

CREATE TABLE Sales (
  sale_id    INT,
  product_id INT,
  year       INT,
  quantity   INT,
  price      INT
);

INSERT INTO Sales (sale_id, product_id, year, quantity, price) VALUES
  (1, 100, 2008, 10, 5000),
  (2, 100, 2009, 12, 5000),
  (7, 200, 2011, 15, 9000);

WITH EarliestYear AS (
  SELECT product_id, MIN(year) AS first_year
  FROM Sales
  GROUP BY product_id
)
SELECT
  s.product_id,
  ey.first_year,
  s.quantity,
  s.price
FROM Sales AS s
JOIN EarliestYear AS ey
  ON s.product_id = ey.product_id
 AND s.year = ey.first_year
ORDER BY s.product_id, s.sale_id;

-- =========================================
-- Example 2 (multiple sales in the first year)
-- Input:
--   Sales:
--     (1, 100, 2008, 10, 5000),
--     (2, 100, 2008,  5, 5200),
--     (3, 100, 2009, 12, 5000),
--     (4, 200, 2010,  7, 3000),
--     (5, 200, 2010,  3, 3000),
--     (6, 300, 2012, 20, 1500)
-- Expected Output:
-- +------------+------------+----------+-------+
-- | product_id | first_year | quantity | price |
-- +------------+------------+----------+-------+
-- | 100        | 2008       | 10       | 5000  |
-- | 100        | 2008       | 5        | 5200  |
-- | 200        | 2010       | 7        | 3000  |
-- | 200        | 2010       | 3        | 3000  |
-- | 300        | 2012       | 20       | 1500  |
-- +------------+------------+----------+-------+
-- =========================================

TRUNCATE TABLE Sales;

INSERT INTO Sales (sale_id, product_id, year, quantity, price) VALUES
  (1, 100, 2008, 10, 5000),
  (2, 100, 2008,  5, 5200),
  (3, 100, 2009, 12, 5000),
  (4, 200, 2010,  7, 3000),
  (5, 200, 2010,  3, 3000),
  (6, 300, 2012, 20, 1500);

WITH EarliestYear AS (
  SELECT product_id, MIN(year) AS first_year
  FROM Sales
  GROUP BY product_id
)
SELECT
  s.product_id,
  ey.first_year,
  s.quantity,
  s.price
FROM Sales AS s
JOIN EarliestYear AS ey
  ON s.product_id = ey.product_id
 AND s.year = ey.first_year
ORDER BY s.product_id, s.sale_id;
