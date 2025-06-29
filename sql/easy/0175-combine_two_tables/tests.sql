-- Setup sample tables & data
CREATE TABLE Person (personId INT, lastName VARCHAR(50), firstName VARCHAR(50));
INSERT INTO Person VALUES (1, 'Wang', 'Allen'), (2, 'Alice', 'Bob');

CREATE TABLE Address (addressId INT, personId INT, city VARCHAR(50), state VARCHAR(50));
INSERT INTO Address VALUES
  (1, 2, 'New York City', 'New York'),
  (2, 3, 'Leetcode',    'California');

-- Run the solution
SELECT
  p.firstName,
  p.lastName,
  a.city,
  a.state
FROM Person AS p
LEFT JOIN Address AS a
  ON p.personId = a.personId;

-- Expected:
-- Allen | Wang  | NULL           | NULL
-- Bob   | Alice | New York City  | New York
