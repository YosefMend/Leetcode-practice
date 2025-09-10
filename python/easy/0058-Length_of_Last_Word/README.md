# 58. Length of Last Word

**LeetCode URL:** [https://leetcode.com/problems/length-of-last-word/  ](https://leetcode.com/problems/length-of-last-word/)
**Difficulty:** Easy  
**Topics:** String, Two Pointers

---

## Problem  
Given a string s consisting of words and spaces, return the length of the last word in the string.
A word is a maximal substring consisting of non-space characters only. The input is guaranteed to contain at least one word.

---

## Approach  
1. **Scan from the end (space-optimized)**  
   - Start with index `i = len(s) - 1`.
   - Move `i` left while `s[i] == ' '` to skip any trailing spaces.
   - Then count consecutive non-space characters while `i >= 0 and s[i] != ' '`. The counter is the length of the last word.

2. **Alternative (Concise)**  
   - Use `s.split()` which collapses whitespace and returns tokens; return `len(s.split()[-1])`. This is simpler, but allocates a list of words (uses extra space).

---

## Edge Cases  
1. **Trailing / leading spaces**  
   - e.g. `" a "` → last word length `1`. 
2. **Multiple spaces between words**  
   - e.g. `"a b c"` → last word length `1`.
3. **Single-character string**  
   - e.g. `"a"` → `1`. 
4. ** Guaranteed one word**
   - Problem promises at least one word, so no need to handle empty-string return cases.

---

## Solution  

In solution.py implement the function:

def length_of_last_word(s: str) -> int:
    ...

File: solution.py — optimized right-to-left scan (O(1) extra space) & concise split()-based variant.

See [`solution.py`](./solution.py) for the full implementation along with inputs and expected outputs.
