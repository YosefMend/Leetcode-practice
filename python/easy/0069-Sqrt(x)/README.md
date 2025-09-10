# 069. Sqrt(x) — Brute Force O(√n), Binary Search O(log n)

**LeetCode URL:** https://leetcode.com/problems/sqrtx/  
**Difficulty:** Easy  
**Topics:** Math, Binary Search  

---

## Problem  
Given a non-negative integer `x`, return the **square root of x rounded down to the nearest integer**.  
The returned integer should be the **floor** of the actual square root.  

Example:  
- Input: `x = 8` → Output: `2` (since √8 ≈ 2.828, floor is 2).  

---

## Approaches  

### 1. Brute Force (Linear Search)  
1. Loop from `i = 1` up to `x // 2`.  
2. For each `i`, check if `i * i` exceeds `x`.  
3. If it does, return `i - 1`.  

- **Time:** O(√n) (worst case, loop until √x).  
- **Space:** O(1).  

---

### 2. Binary Search  
1. Handle base case: if `x < 2`, return `x`.  
2. Search range: `lo = 1`, `hi = x // 2`.  
3. While `lo <= hi`:  
   - Take `mid = (lo + hi) // 2`.  
   - If `mid * mid == x`, return `mid`.  
   - If `mid * mid < x`, move right (`lo = mid + 1`) and track `ans = mid`.  
   - Otherwise, move left (`hi = mid - 1`).  
4. Return `ans`.  

- **Time:** O(log n).  
- **Space:** O(1).  

---

## Edge Cases  
1. `x = 0` → return 0.  
2. `x = 1` → return 1.  
3. Very large numbers (e.g., 2³¹-1) → binary search prevents overflow.  

---

## Complexity  
- **Brute Force:** O(√n) time, O(1) space.  
- **Binary Search:** O(log n) time, O(1) space.  

---

## Solutions  
See [`solution.py`](./solution.py) for both implementations.  

---

## Tests  
See [`tests.py`](./tests.py) for sample inputs and expected outputs.  
