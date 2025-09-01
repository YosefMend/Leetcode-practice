-- Find sales in each product's first year
-- Approach:
-- 1) Compute first_year per product using MIN(year) grouped by product_id.
-- 2) Join that result back to Sales on product_id and year = first_year to return every sale row from that earliest year.
-- 3) Select product_id, first_year, quantity, and price.
-- (Optional) A window-function variant is shown below as a commented alternative.

WITH EarliestYear AS (
  SELECT
    product_id,
    MIN(year) AS first_year
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
ORDER BY s.product_id;

-- -----------------------------------------------------------
-- Alternative single-query window-function variant
-- Uncomment to use:
--
-- SELECT
--   product_id,
--   year AS first_year,
--   quantity,
--   price
-- FROM (
--   SELECT
--     s.*,
--     MIN(year) OVER (PARTITION BY product_id) AS first_year_for_product
--   FROM Sales s
-- ) t
-- WHERE t.year = t.first_year_for_product
-- ORDER BY product_id;
