"""
LeetCode 7: Reverse Integer
https://leetcode.com/problems/reverse-integer/

Approaches:
1. String Method (initial idea)
   - Convert number to string, reverse, convert back to int.
   - Handle sign separately and check 32-bit range.
   - Time: O(n), Space: O(n)

2. Math Method (modulo + integer division)
   - Pop digits with % 10 and push into result with *10 + digit.
   - Handle sign separately and check 32-bit range.
   - Time: O(n), Space: O(1)

Constraints:
- Input is a signed 32-bit integer.
- Must return 0 if reversed integer overflows 32-bit range.
"""

class Solution:
    def reverse_string(self, x: int) -> int:
        # Reverse integer using string manipulation.

        sign = -1 if x < 0 else 1 # Store integer sign
        x_str = str(abs(x))
        reversed_str = x_str[::-1] # Reverse string using slicing
        result = sign * int(reversed_str) # Redistribute sign to integer (When converting back to integer, gets rid of leading zeros)

        if result < -2**31 or result > 2**31 - 1:
            return 0
        return result

    def reverse_math(self, x: int) -> int:
        # Reverse integer using modulo and integer division.

        sign = -1 if x < 0 else 1 # Store integer sign
        x = abs(x)
        result = 0

        while x != 0:
            digit = x % 10 # Get last digit
            result = result * 10 + digit # Store last digit into new result
            x //= 10 # Remove last digit from x

        result *= sign
        if result < -2**31 or result > 2**31 - 1:
            return 0
        return result


# Quick manual check
if __name__ == "__main__":
    sol = Solution()
    test_cases = [
        (123, 321),
        (-123, -321),
        (120, 21),
        (0, 0),
        (1534236469, 0),  # overflow case
    ]

    print("Testing string method:")
    for x, expected in test_cases:
        print(f"x={x}, reversed={sol.reverse_string(x)}, expected={expected}")

    print("\nTesting math method:")
    for x, expected in test_cases:
        print(f"x={x}, reversed={sol.reverse_math(x)}, expected={expected}")
