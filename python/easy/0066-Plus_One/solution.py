# LeetCode 66: Plus One
# URL: https://leetcode.com/problems/plus-one/
#
# Approach:
# 1) Iterate digits from right to left.
# 2) If a digit < 9: increment it and return immediately (carry ends).
# 3) If digit == 9: set it to 0 and keep carrying left.
# 4) If loop finishes (all 9s): prepend 1 and return [1] + digits.
#
# Complexity:
# Time: O(n) in the worst case (all digits are 9).
# Space: O(1) extra space (modifies in-place, aside from required output).

from typing import List

class Solution:
    def plusOne(self, digits: List[int]) -> List[int]:
        # Start from the rightmost digit
        for i in range(len(digits) - 1, -1, -1):
            if digits[i] < 9:
                digits[i] += 1
                return digits  # carry resolved
            digits[i] = 0  # set to 0 and continue carry
        
        # If we get here, all digits were 9
        return [1] + digits
