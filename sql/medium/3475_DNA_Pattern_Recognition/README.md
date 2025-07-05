# 3475. DNA Pattern Recognition

**LeetCode URL:** https://leetcode.com/problems/dna-pattern-recognition/  
**Difficulty:** Medium  
**Topics:** SQL, String Functions, CASE, LIKE

---

## Problem  
Given a `Samples(sample_id, dna_sequence, species)` table, tag each row with four binary flags (`has_start`, `has_stop`, `has_atat`, `has_ggg`) indicating whether its `dna_sequence`:  
1. **Starts** with the start codon “ATG”  
2. **Ends** with one of the stop codons “TAA”, “TAG”, or “TGA”  
3. **Contains** the motif “ATAT” anywhere  
4. **Contains** at least three consecutive “G” characters  

Return all columns plus the four flags, ordered by `sample_id`.

---

## Approach  
1. **Check start codon**  
   - Use `CASE WHEN dna_sequence LIKE 'ATG%' THEN 1 ELSE 0 END` to detect sequences beginning with “ATG.”  
2. **Check stop codon**  
   - Use `CASE WHEN dna_sequence LIKE '%TAA' OR LIKE '%TAG' OR LIKE '%TGA' THEN 1 ELSE 0 END` for suffix matching.  
3. **Check repeat motif**  
   - Use `CASE WHEN dna_sequence LIKE '%ATAT%' THEN 1 ELSE 0 END` to find “ATAT.”  
4. **Check G-run**  
   - Use `CASE WHEN dna_sequence LIKE '%GGG%' THEN 1 ELSE 0 END` to catch any run of ≥3 G’s.  
5. **Combine in one pass**  
   - In a single `SELECT`, compute all four `CASE` expressions alongside the original columns.  
6. **Order results**  
   - Add `ORDER BY sample_id` to satisfy the output ordering requirement.

---

## Edge Cases  
- **Very short sequences** shorter than 3 or 4 characters → all flags = 0.  
- **Sequences matching multiple patterns** → each flag is independent.  
- **No matching patterns at all** → all flags = 0.

---

## Solution  
In `solution.sql`, implement each flag with `CASE WHEN … LIKE …` logic.  
See `solution.sql` for the full query.

---

## Tests  
See `tests.sql` for sample DDL/DML setup and expected outputs covering various pattern combinations.  
