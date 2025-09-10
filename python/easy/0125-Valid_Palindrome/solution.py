"""
LeetCode 125: Valid Palindrome
https://leetcode.com/problems/valid-palindrome/

Approach:
- Preprocess the string by filtering to alphanumeric characters and converting to lowercase.
- Use two pointers to compare characters from both ends inward.

"""

class Solution:
    def isPalindrome(self, s: str) -> bool:
        # Step 1: Clean the string
        cleaned_s = "".join(c.lower() for c in s if c.isalnum())
        
        # Step 2: Two pointers
        first, last = 0, len(cleaned_s) - 1
        while first < last:
            if cleaned_s[first] != cleaned_s[last]:
                return False
            first += 1
            last -= 1
        return True


# Quick manual check
if __name__ == "__main__":
    sol = Solution()
    test_cases = [
        "A man, a plan, a canal: Panama",  # True
        "race a car",                      # False
        " ",                               # True
    ]

    for t in test_cases:
        print(f"{t!r} -> {sol.isPalindrome(t)}")
