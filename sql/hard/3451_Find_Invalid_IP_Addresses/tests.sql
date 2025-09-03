-- tests.sql for LeetCode 3451: Find Invalid IP Addresses
-- Stepwise parsing solution (uses CTEs). Includes prompt example and extra edge cases.

CREATE TABLE logs (
  log_id      INT,
  ip          VARCHAR(100),
  status_code INT
);

-- =========================================
-- Example (from prompt)
-- Expected output:
-- +---------------+--------------+
-- | ip            | invalid_count|
-- +---------------+--------------+
-- | 256.1.2.3     | 2            |
-- | 192.168.001.1 | 2            |
-- | 192.168.1     | 1            |
-- +---------------+--------------+
-- =========================================
INSERT INTO logs (log_id, ip, status_code) VALUES
  (1, '192.168.1.1',   200),
  (2, '256.1.2.3',     404),
  (3, '192.168.001.1', 200),
  (4, '192.168.1.1',   200),
  (5, '192.168.1',     500),
  (6, '256.1.2.3',     404),
  (7, '192.168.001.1', 200);

-- Run solution query (stepwise CTE approach)
WITH parsed AS (
  SELECT
    TRIM(ip) AS ip_raw,
    (LENGTH(TRIM(ip)) - LENGTH(REPLACE(TRIM(ip), '.', ''))) AS dot_count,
    SUBSTRING_INDEX(TRIM(ip), '.', 1) AS oct1,
    SUBSTRING_INDEX(SUBSTRING_INDEX(TRIM(ip), '.', 2), '.', -1) AS oct2,
    SUBSTRING_INDEX(SUBSTRING_INDEX(TRIM(ip), '.', 3), '.', -1) AS oct3,
    SUBSTRING_INDEX(TRIM(ip), '.', -1) AS oct4
  FROM logs
),
flagged AS (
  SELECT
    ip_raw AS ip,
    CASE
      WHEN ip_raw IS NULL OR ip_raw = '' THEN 1
      WHEN dot_count <> 3 THEN 1
      WHEN NOT (
           oct1  REGEXP '^[0-9]+$'
        AND oct2  REGEXP '^[0-9]+$'
        AND oct3  REGEXP '^[0-9]+$'
        AND oct4  REGEXP '^[0-9]+$'
      ) THEN 1
      WHEN (CHAR_LENGTH(oct1) > 1 AND LEFT(oct1,1) = '0')
        OR (CHAR_LENGTH(oct2) > 1 AND LEFT(oct2,1) = '0')
        OR (CHAR_LENGTH(oct3) > 1 AND LEFT(oct3,1) = '0')
        OR (CHAR_LENGTH(oct4) > 1 AND LEFT(oct4,1) = '0') THEN 1
      WHEN CAST(oct1 AS SIGNED) > 255
        OR CAST(oct2 AS SIGNED) > 255
        OR CAST(oct3 AS SIGNED) > 255
        OR CAST(oct4 AS SIGNED) > 255 THEN 1
      ELSE 0
    END AS is_invalid
  FROM parsed
)
SELECT ip, SUM(is_invalid) AS invalid_count
FROM flagged
GROUP BY ip
HAVING invalid_count > 0
ORDER BY invalid_count DESC, ip DESC;

-- =========================================
-- Additional tests / edge cases
-- 1) Leading zeros, empty, null, non-digits, too many octets, double dots
-- Expected approximate output:
-- ip                    invalid_count
-- '01.2.3.4'             1   (leading zero)
-- '1..2.3'               1   (empty octet)
-- '300.1.2.3'            1   (>255)
-- ''                     1   (empty string)
-- NULL                   1   (null)
-- 'a.b.c.d'              1   (non-digits)
-- '1.2.3.4.5'            1   (too many octets -> dot_count <> 3)
-- =========================================

TRUNCATE TABLE logs;

INSERT INTO logs (log_id, ip, status_code) VALUES
  (1, '01.2.3.4',   200),   -- leading-zero invalid
  (2, '1..2.3',     200),   -- empty octet -> invalid
  (3, '300.1.2.3',  200),   -- >255 invalid
  (4, '',           200),   -- empty string -> invalid
  (5, NULL,         200),   -- null -> invalid
  (6, 'a.b.c.d',    200),   -- non-digits -> invalid
  (7, '1.2.3.4.5',  200),   -- too many octets -> invalid
  (8, '0.0.0.0',    200),   -- valid, should NOT appear
  (9, '192.168.1.1',200);   -- valid, should NOT appear

WITH parsed AS (
  SELECT
    TRIM(ip) AS ip_raw,
    (LENGTH(TRIM(ip)) - LENGTH(REPLACE(TRIM(ip), '.', ''))) AS dot_count,
    SUBSTRING_INDEX(TRIM(ip), '.', 1) AS oct1,
    SUBSTRING_INDEX(SUBSTRING_INDEX(TRIM(ip), '.', 2), '.', -1) AS oct2,
    SUBSTRING_INDEX(SUBSTRING_INDEX(TRIM(ip), '.', 3), '.', -1) AS oct3,
    SUBSTRING_INDEX(TRIM(ip), '.', -1) AS oct4
  FROM logs
),
flagged AS (
  SELECT
    ip_raw AS ip,
    CASE
      WHEN ip_raw IS NULL OR ip_raw = '' THEN 1
      WHEN dot_count <> 3 THEN 1
      WHEN NOT (
           oct1  REGEXP '^[0-9]+$'
        AND oct2  REGEXP '^[0-9]+$'
        AND oct3  REGEXP '^[0-9]+$'
        AND oct4  REGEXP '^[0-9]+$'
      ) THEN 1
      WHEN (CHAR_LENGTH(oct1) > 1 AND LEFT(oct1,1) = '0')
        OR (CHAR_LENGTH(oct2) > 1 AND LEFT(oct2,1) = '0')
        OR (CHAR_LENGTH(oct3) > 1 AND LEFT(oct3,1) = '0')
        OR (CHAR_LENGTH(oct4) > 1 AND LEFT(oct4,1) = '0') THEN 1
      WHEN CAST(oct1 AS SIGNED) > 255
        OR CAST(oct2 AS SIGNED) > 255
        OR CAST(oct3 AS SIGNED) > 255
        OR CAST(oct4 AS SIGNED) > 255 THEN 1
      ELSE 0
    END AS is_invalid
  FROM parsed
)
SELECT ip, SUM(is_invalid) AS invalid_count
FROM flagged
GROUP BY ip
HAVING invalid_count > 0
ORDER BY invalid_count DESC, ip DESC;
