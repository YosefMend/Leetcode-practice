# 007. Reverse Integer

**LeetCode URL:** https://leetcode.com/problems/reverse-integer/  
**Difficulty:** Medium  
**Topics:** Math  

---

## Problem  
Given a signed 32-bit integer `x`, return `x` with its digits reversed.  
If reversing `x` causes the value to go outside the 32-bit signed integer range  
`[-2^31, 2^31 - 1]`, return `0`.  

---

## Intuition  
My first thought was to use a **string-based method**:  
1. Convert the integer to a string.  
2. Reverse the string.  
3. Convert back to integer.  
4. Reapply the sign and check the 32-bit range.  

This works fine, but I wanted to dig deeper into other techniques, especially ones that don’t rely on type conversion. That led me to the **math-based method**, which uses modulo and integer division to reorient digits one by one.  

This method feels more “low-level” and really shows how the number is rebuilt digit by digit. It was also a chance to understand the modulo operator (`%`) better: `% 10` gives the last digit, and `// 10` removes the last digit.  

---

## Approaches  

### Method 1: String Method  
1. Handle the sign separately.  
2. Convert absolute value to a string.  
3. Reverse the string with slicing.  
4. Convert back to integer, reapply sign.  
5. Check 32-bit range.  

- **Time:** O(n)  
- **Space:** O(n) (because of string storage)  

---

### Method 2: Math Method (Modulo & Division)  
1. Extract sign, take absolute value of input.  
2. Initialize `result = 0`.  
3. While the number isn’t zero:  
   - Get last digit with `x % 10`.  
   - Build reversed number with `result = result * 10 + digit`.  
   - Chop off last digit with `x //= 10`.  
4. Reapply sign.  
5. Check 32-bit range.  

- **Time:** O(n) (n = number of digits)  
- **Space:** O(1)  

---

## Edge Cases  
1. Input with trailing zeros → `120 → 21`.  
2. Negative numbers → `-123 → -321`.  
3. Single digit → returns itself.  
4. Overflow beyond `[-2^31, 2^31 - 1]` → return 0.  

---

## Complexity  
- **String method:** O(n) time, O(n) space.  
- **Math method:** O(n) time, O(1) space.  

---

## Solution  
See [`solution.py`](./solution.py) for both implementations.  
