"""
LeetCode 136: Single Number
https://leetcode.com/problems/single-number/

Approach:
- Use bitwise XOR to cancel out duplicate numbers.
- Properties:
  1. a ^ a = 0   (same numbers cancel out)
  2. a ^ 0 = a   (XOR with 0 leaves the number unchanged)
  3. XOR is commutative and associative (order and grouping don't matter)
- Therefore, XOR-ing all numbers in the array leaves only the single number.

Time Complexity: O(n)
Space Complexity: O(1)
"""

class Solution:
    def singleNumber(self, nums: list[int]) -> int:
        result = 0
        for num in nums:
            result ^= num   # XOR cancels duplicates
        return result


# Quick manual check
if __name__ == "__main__":
    sol = Solution()
    test_cases = [
        ([2, 2, 1], 1),
        ([4, 1, 2, 1, 2], 4),
        ([1], 1),
        ([7, 3, 5, 3, 7, 9, 5], 9),  # larger example
    ]

    for nums, expected in test_cases:
        result = sol.singleNumber(nums)
        print(f"nums={nums} -> {result} (expected {expected})")
