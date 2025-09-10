# 136. Single Number — O(n) Time, O(1) Space

**LeetCode URL:** https://leetcode.com/problems/single-number/  
**Difficulty:** Easy  
**Topics:** Bit Manipulation  

---

## Problem  
Given a non-empty array of integers `nums`, every element appears **twice** except for one. Find that single one.  

Constraints:  
- You must implement a solution with **linear runtime complexity** and **constant extra space**.  

---

## Intuition  
At first, this seems like a “find the number without a pair” problem, which suggests:  
- **Brute force:** check each number against every other → O(n²). Too slow.  
- **Sorting:** put duplicates next to each other → O(n log n), breaks the linear-time constraint.  

The challenge is clear: we need **O(n) time and O(1) space**.  

That requirement pushed me into new territory: I had to research **bit operations**. Specifically, I learned about **XOR (^)** and its properties:  
1. `a ^ a = 0` (any number XOR itself cancels out)  
2. `a ^ 0 = a` (XOR with 0 changes nothing)  
3. XOR is commutative and associative (order and grouping don’t matter).  

This means if you XOR all the numbers in the list together, every duplicate cancels itself out, and only the unique number remains.  

---

## Approach  
1. Initialize a variable `result = 0`.  
2. For each number in `nums`, compute `result ^= num`.  
3. After the loop, `result` will hold the single number.  

---

## Edge Cases  
1. Single element list: `[1] → 1`.  
2. Negative numbers still work, since XOR operates bitwise.  
3. Large arrays are safe because we only use one accumulator variable.  

---

## Complexity  
- **Time:** O(n) (we loop once).  
- **Space:** O(1) (only one integer stored).  

---

## Personal Note  
This problem pushed me to study **binary representation and bitwise operators** more deeply. At first, the idea of “cancellation” using XOR felt abstract. But after working through binary examples (e.g., `5 ^ 6 = 3`), I saw how pairs vanish (`a ^ a = 0`) and why the unpaired number survives.  

It reminded me of an earlier idea I had — subtracting a copied list from itself so only the unmatched number survives. XOR does exactly that, but in a mathematically efficient way.  

---

## Solution  
See [`solution.py`](./solution.py) for the implementation.  

