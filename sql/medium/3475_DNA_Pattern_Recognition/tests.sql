-- tests.sql for LeetCode 3475: DNA Pattern Recognition

-- =========================================
-- Example 1
-- Input:
--   Samples:
--     (1, 'ATGCTAGCTAGCTAA', 'Human'),
--     (2, 'GGGTCAATCATC',     'Human'),
--     (3, 'ATATATCGTAGCTA',   'Human'),
--     (4, 'ATGGGGTCATCATAA',  'Mouse'),
--     (5, 'TCAGTCAGTCAG',     'Mouse'),
--     (6, 'ATATCGCGCTAG',     'Zebrafish'),
--     (7, 'CGTATGCGTCGTA',    'Zebrafish')
-- Expected Output:
-- +-----------+------------------+-----------+-----------+---------+---------+---------+
-- | sample_id | dna_sequence     | species   | has_start | has_stop| has_atat| has_ggg |
-- +-----------+------------------+-----------+-----------+---------+---------+---------+
-- | 1         | ATGCTAGCTAGCTAA  | Human     | 1         | 1       | 0       | 0       |
-- | 2         | GGGTCAATCATC     | Human     | 0         | 0       | 0       | 1       |
-- | 3         | ATATATCGTAGCTA   | Human     | 0         | 0       | 1       | 0       |
-- | 4         | ATGGGGTCATCATAA  | Mouse     | 1         | 1       | 0       | 1       |
-- | 5         | TCAGTCAGTCAG     | Mouse     | 0         | 0       | 0       | 0       |
-- | 6         | ATATCGCGCTAG     | Zebrafish | 0         | 1       | 1       | 0       |
-- | 7         | CGTATGCGTCGTA    | Zebrafish | 0         | 0       | 0       | 0       |
-- +-----------+------------------+-----------+-----------+---------+---------+---------+
-- =========================================

DROP TABLE IF EXISTS Samples;
CREATE TABLE Samples (
  sample_id    INT,
  dna_sequence VARCHAR(255),
  species      VARCHAR(50)
);

INSERT INTO Samples (sample_id, dna_sequence, species) VALUES
  (1, 'ATGCTAGCTAGCTAA',  'Human'),
  (2, 'GGGTCAATCATC',      'Human'),
  (3, 'ATATATCGTAGCTA',    'Human'),
  (4, 'ATGGGGTCATCATAA',   'Mouse'),
  (5, 'TCAGTCAGTCAG',      'Mouse'),
  (6, 'ATATCGCGCTAG',      'Zebrafish'),
  (7, 'CGTATGCGTCGTA',     'Zebrafish');

SELECT
  sample_id,
  dna_sequence,
  species,
  CASE WHEN dna_sequence LIKE 'ATG%'     THEN 1 ELSE 0 END AS has_start,
  CASE WHEN dna_sequence LIKE '%TAA' 
         OR dna_sequence LIKE '%TAG' 
         OR dna_sequence LIKE '%TGA'      THEN 1 ELSE 0 END AS has_stop,
  CASE WHEN dna_sequence LIKE '%ATAT%'   THEN 1 ELSE 0 END AS has_atat,
  CASE WHEN dna_sequence LIKE '%GGG%'    THEN 1 ELSE 0 END AS has_ggg
FROM Samples
ORDER BY sample_id;
