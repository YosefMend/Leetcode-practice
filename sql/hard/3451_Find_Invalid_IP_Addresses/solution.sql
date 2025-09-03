-- LeetCode 3451: Find Invalid IP Addresses
-- Stepwise parsing using SUBSTRING_INDEX + REGEXP + safe casts
-- Returns: ip, invalid_count ordered by invalid_count DESC, ip DESC

WITH parsed AS (
  SELECT
    TRIM(ip) AS ip_raw,
    -- quick dot count (must be exactly 3 for 4 octets)
    (LENGTH(TRIM(ip)) - LENGTH(REPLACE(TRIM(ip), '.', ''))) AS dot_count,
    -- extract octets (oct4 uses -1 for clarity)
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
      -- empty / null ip -> invalid
      WHEN ip_raw IS NULL OR ip_raw = '' THEN 1

      -- wrong number of dots -> not 4 octets
      WHEN dot_count <> 3 THEN 1

      -- require each octet to be digits (prevents unsafe casts)
      WHEN NOT (
           oct1  REGEXP '^[0-9]+$'
        AND oct2  REGEXP '^[0-9]+$'
        AND oct3  REGEXP '^[0-9]+$'
        AND oct4  REGEXP '^[0-9]+$'
      ) THEN 1

      -- leading zero in multi-digit octet (allow single "0" only)
      WHEN (CHAR_LENGTH(oct1) > 1 AND LEFT(oct1,1) = '0')
        OR (CHAR_LENGTH(oct2) > 1 AND LEFT(oct2,1) = '0')
        OR (CHAR_LENGTH(oct3) > 1 AND LEFT(oct3,1) = '0')
        OR (CHAR_LENGTH(oct4) > 1 AND LEFT(oct4,1) = '0') THEN 1

      -- numeric range > 255 (safe because octets are digits)
      WHEN CAST(oct1 AS SIGNED) > 255
        OR CAST(oct2 AS SIGNED) > 255
        OR CAST(oct3 AS SIGNED) > 255
        OR CAST(oct4 AS SIGNED) > 255 THEN 1

      ELSE 0
    END AS is_invalid
  FROM parsed
)

SELECT
  ip,
  SUM(is_invalid) AS invalid_count
FROM flagged
GROUP BY ip
HAVING invalid_count > 0
ORDER BY invalid_count DESC, ip DESC;
