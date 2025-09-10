# 125. Valid Palindrome — O(n) Time, O(n) Space

**LeetCode URL:** https://leetcode.com/problems/valid-palindrome/  
**Difficulty:** Easy  
**Topics:** Two Pointers, String  

---

## Problem  
A string is a palindrome if, after converting all uppercase letters into lowercase and removing all non-alphanumeric characters, it reads the same forward and backward.  

Return `true` if the string is a palindrome, or `false` otherwise.  

---

## Approach  
1. Preprocess the input: keep only alphanumeric characters and convert them to lowercase.  
2. Use two pointers (`first`, `last`) starting from the beginning and end of the cleaned string.  
3. Compare characters at each step.  
   - If they mismatch, return `false`.  
   - If they match, move inward (`first += 1`, `last -= 1`).  
4. If the pointers meet or cross without mismatches, return `true`.  

---

## Edge Cases  
1. `" "` (only spaces) → true (empty string after cleaning).  
2. `"a"` → true (single char is always a palindrome).  
3. Strings with punctuation/capitalization → handled by preprocessing.  

---

## Complexity  
- **Time:** O(n) (must check every character).  
- **Space:** O(n) (for the cleaned string).  

---

## Solution  
See [`solution.py`](./solution.py) for the implementation.  

