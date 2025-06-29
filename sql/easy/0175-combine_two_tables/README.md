# 175. Combine Two Tables

**Difficulty:** Easy  
**Topic:** SQL JOIN

## Problem  
Given two tables, `Person` and `Address`, return each person’s `firstName`, `lastName`, `city`, and `state`.  
If a person has no matching `Address` row, `city` and `state` should be `NULL`.

## Approach  
- Use a **LEFT JOIN** from `Person` to `Address` on `personId`.  
- SELECT the four columns, relying on the fact that missing `Address` rows yield `NULL` for `city`/`state`.

## SQL  
```sql
SELECT
  p.firstName, p.lastName, a.city, a.state
FROM Person AS p
LEFT JOIN Address AS a
  ON p.personId = a.personId;
