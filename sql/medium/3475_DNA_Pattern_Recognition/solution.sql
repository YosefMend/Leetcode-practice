-- LeetCode 3475: DNA Pattern Recognition
-- URL: https://leetcode.com/problems/dna-pattern-recognition/

-- Approach:
-- 1) Detect start codon with LIKE 'ATG%'
-- 2) Detect stop codon with LIKE '%TAA' OR '%TAG' OR '%TGA'
-- 3) Detect repeat motif with LIKE '%ATAT%'
-- 4) Detect G-run with LIKE '%GGG%'

SELECT
  sample_id,
  dna_sequence,
  species,
  CASE 
    WHEN dna_sequence LIKE 'ATG%' THEN 1  -- starts with ATG
    ELSE 0 
  END AS has_start,
  CASE 
    WHEN dna_sequence LIKE '%TAA' 
      OR dna_sequence LIKE '%TAG' 
      OR dna_sequence LIKE '%TGA'         -- ends with one of the stop codons
    THEN 1 
    ELSE 0 
  END AS has_stop,
  CASE 
    WHEN dna_sequence LIKE '%ATAT%' THEN 1  -- contains the motif ATAT
    ELSE 0 
  END AS has_atat,
  CASE 
    WHEN dna_sequence LIKE '%GGG%' THEN 1   -- contains three or more consecutive G’s
    ELSE 0 
  END AS has_ggg
FROM Samples
ORDER BY sample_id;
