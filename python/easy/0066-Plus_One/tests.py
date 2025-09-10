# tests.py
# LeetCode 66: Plus One
# URL: https://leetcode.com/problems/plus-one/
#
# Simple test harness for solution.py
# Run:  python tests.py
#
# Covers:
# - Provided examples
# - All-9s cases
# - Trailing-9s cases
# - Single-digit cases
# - Mixed digits

from typing import List
from solution import Solution

def run_tests():
    sol = Solution()

    cases: list[tuple[List[int], List[int]]] = [
        # --- Provided examples ---
        ([1, 2, 3], [1, 2, 4]),
        ([4, 3, 2, 1], [4, 3, 2, 2]),
        ([9], [1, 0]),
        # --- All 9s ---
        ([9, 9], [1, 0, 0]),
        ([9, 9, 9], [1, 0, 0, 0]),
        # --- Trailing 9s ---
        ([1, 2, 9], [1, 3, 0]),
        ([1, 2, 9, 9], [1, 3, 0, 0]),
        # --- Single digit (non-9) ---
        ([0], [1]),
        ([3], [4]),
        # --- Mixed ---
        ([2, 8, 9, 0], [2, 8, 9, 1]),
        ([8, 9, 9, 9], [9, 0, 0, 0]),
        ([1, 0, 0, 0], [1, 0, 0, 1]),
    ]

    for i, (inp, expected) in enumerate(cases, 1):
        got = sol.plusOne(inp.copy())  # copy to avoid mutating the test vector
        assert got == expected, f"[Case {i}] plusOne({inp}) -> {got}, expected {expected}"

    print(f"All {len(cases)} tests passed.")

if __name__ == "__main__":
    run_tests()
