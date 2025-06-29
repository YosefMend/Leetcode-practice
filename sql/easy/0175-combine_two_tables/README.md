# 175. Combine Two Tables

**LeetCode URL:** https://leetcode.com/problems/combine-two-tables/   

**Difficulty:** Easy  

**Topics:** SQL, JOIN  

---

## Problem
Given tables `Person` and `Address`, return each person’s `firstName`, `lastName`, `city`, and `state`.  
If a person has no address row, `city` and `state` should be `NULL`.

---

## Approach
- Perform a **LEFT JOIN** from `Person` to `Address` on `personId`.  
- Selecting `a.city` and `a.state` will naturally yield `NULL` for missing addresses.

---

## Edge Cases
1. **No rows in `Address`** -> all outputs for `city`/`state` are `NULL`.  
2. **Address rows exist for non-existent `personId`** -> ignored by LEFT JOIN.  
3. **`city` or `state` columns already `NULL`** in the DB -> remain `NULL` in results.

---

## Solution
See ['solution.sql'](./solution.sql) for the full query.

---

## Tests
See ['tests.sql'](./tests.sql) for sample DDL/DML and expected output
