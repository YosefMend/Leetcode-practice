# 066. Plus One — O(n) Time, O(1) Space (Right-to-Left Carry)

**LeetCode URL:** https://leetcode.com/problems/plus-one/  
**Difficulty:** Easy  
**Topics:** Array, Simulation, Math  

---

## Problem  
You are given a large integer represented as an integer array `digits`, where each `digits[i]` is the i-th digit of the integer. The digits are ordered from most significant to least significant in left-to-right order. The large integer does not contain any leading `0`s.  

Increment the large integer by one and return the resulting array of digits.  

**Examples**
- Input: `digits = [1,2,3]` → Output: `[1,2,4]`  
- Input: `digits = [4,3,2,1]` → Output: `[4,3,2,2]`  
- Input: `digits = [9]` → Output: `[1,0]`  

---

## Approach  
1. **Iterate from right to left**  
   - Start at the last digit (`len(digits) - 1`) and move leftwards.  

2. **Increment logic**  
   - If the current digit is `< 9`: increment it by 1 and return immediately (no carry needed).  
   - If the current digit is `9`: set it to `0` and continue to the next digit on the left (carry).  

3. **All 9s case**  
   - If the loop finishes without returning, all digits were 9s.  
   - Prepend `1` and return `[1] + digits`.  

---

## Edge Cases  
1. **All digits are 9**  
   - `[9,9,9]` → `[1,0,0,0]`  
2. **Single digit**  
   - `[9]` → `[1,0]`  
   - `[3]` → `[4]`  
3. **Trailing 9s**  
   - `[1,2,9,9]` → `[1,3,0,0]`  
4. **Maximum allowed length**  
   - Handles up to `digits.length = 100` per problem constraints.  

---

## Solution  
See [`solution.py`](./solution.py) for the implementation.  

---

## Tests  
See [`tests.py`](./tests.py) for sample inputs and expected outputs.  
Covers the given examples plus additional edge cases (all 9s, single digit, trailing 9s).  
