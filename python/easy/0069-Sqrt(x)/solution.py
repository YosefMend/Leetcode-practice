"""
LeetCode 69: Sqrt(x)
https://leetcode.com/problems/sqrtx/

Approaches:
1. Brute Force O(√n) time, O(1) space
2. Binary Search O(log n) time, O(1) space
"""

def sqrt_brute_force(x: int) -> int:
    """
    Compute floor(sqrt(x)) using brute force iteration.
    
    Args:
        x (int): Non-negative integer
    
    Returns:
        int: Floor of sqrt(x)
    """
    if x < 2:
        return x
    
    for i in range(1, (x // 2) + 1):
        if i * i == x:
            return i
        elif i * i > x:
            return i - 1
    return x // 2  # fallback for large perfect squares


def sqrt_binary_search(x: int) -> int:
    """
    Compute floor(sqrt(x)) using binary search.
    
    Args:
        x (int): Non-negative integer
    
    Returns:
        int: Floor of sqrt(x)
    """
    if x < 2:
        return x

    lo = 1 
    hi = x // 2
    ans = 0
    while lo <= hi:
        mid = (lo + hi) // 2
        square = mid * mid
        if square == x:
            return mid
        elif square < x:
            ans = mid
            lo = mid + 1
        else:
            hi = mid - 1
    return ans


# Quick manual check
if __name__ == "__main__":
    test_values = [0, 1, 4, 8, 15, 16, 27, 2147395599]
    print("Brute Force Results:")
    for val in test_values:
        print(f"x={val}, sqrt={sqrt_brute_force(val)}")

    print("\nBinary Search Results:")
    for val in test_values:
        print(f"x={val}, sqrt={sqrt_binary_search(val)}")
