# 3451. Find Invalid IP Addresses — Stepwise parsing (SUBSTRING_INDEX + REGEXP)

**LeetCode URL:** https://leetcode.com/problems/find-invalid-ip-addresses/  
**Difficulty:** Hard  
**Topics:** SQL, String functions, REGEXP, SUBSTRING_INDEX, CAST, Aggregation

---

## Problem  
Given a `logs(log_id, ip, status_code)` table, find all **invalid IPv4** addresses and count how many log rows contain each invalid IP. An IPv4 address is invalid if any of the following is true:

- any octet is > 255  
- any octet has a leading zero (e.g. `01`, `001`) — note that a single `"0"` is valid  
- the IP does not have exactly 4 octets (i.e. not exactly 3 `.` separators)

Return rows `(ip, invalid_count)` ordered by `invalid_count DESC, ip DESC`.

---

## Intuition  
Validate each log row independently. For each `ip` string: (1) cheaply reject malformed ones by checking dot-count, (2) extract the four octets with `SUBSTRING_INDEX`, (3) ensure each octet is digits, (4) disallow multi-digit octets that start with `0`, and (5) check numeric range (0–255). Flag rows that fail any check and then aggregate counts by `ip`.

---

## Approach (stepwise parsing using SUBSTRING_INDEX + REGEXP)
1. **Clean & quick reject**  
   - `TRIM(ip)` and compute `dot_count = LENGTH(ip) - LENGTH(REPLACE(ip, '.', ''))`. If `dot_count <> 3`, mark the row invalid (cheap and reliable).

2. **Extract octets**  
   - Use `SUBSTRING_INDEX` to pull parts:
     - `oct1 = SUBSTRING_INDEX(ip, '.', 1)`  
     - `oct2 = SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 2), '.', -1)`  
     - `oct3 = SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 3), '.', -1)`  
     - `oct4 = SUBSTRING_INDEX(ip, '.', -1)`

3. **Digit-only check**  
   - Ensure each octet is all digits: `octN REGEXP '^[0-9]+$'`. This protects numeric casts and catches empty octets.

4. **Leading-zero rule**  
   - Reject octets where `CHAR_LENGTH(octN) > 1 AND LEFT(octN,1) = '0'`. This allows the single-character `"0"` but rejects `"01"` or `"001"`.

5. **Numeric range check**  
   - After the digit check, cast and reject if `CAST(octN AS UNSIGNED) > 255`.

6. **Per-row flag and aggregate**  
   - Combine the tests into `is_invalid` (1/0) via `CASE`. Then `SELECT ip, SUM(is_invalid) AS invalid_count FROM (...) GROUP BY ip HAVING invalid_count > 0 ORDER BY invalid_count DESC, ip DESC`.

---

## Edge cases
- `NULL` or empty `ip` values — treat as invalid (or document another policy).  
- Whitespace around IPs — `TRIM` them first.  
- Inputs like `1..2.3` (empty octet) or `192.168.1` (too few octets) — caught by dot-count / digit checks.  
- Strings containing letters or symbols — rejected by digit `REGEXP`.  
- Octets such as `001` — digits pass, but leading-zero test rejects them.  
- Large log tables: string parsing is CPU-heavy; consider pre-processing if you must run this on huge datasets frequently.

---

## Solution  
See [`solution.sql`](solution.sql) for the full stepwise query that extracts octets with `SUBSTRING_INDEX`, validates with `REGEXP` and `CHAR_LENGTH`/`LEFT`, casts for numeric checks, flags invalid rows, and aggregates counts.

---

## Tests  
See [`tests.sql`](tests.sql) for DDL/DML examples (including the prompt example and additional edge cases) and expected outputs.
