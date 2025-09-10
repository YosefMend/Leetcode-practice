# LeetCode 058: Length of Last Word
# URL: https://leetcode.com/problems/length-of-last-word/
#
# Optimized approach: right-to-left scan
# - Skip trailing spaces
# - Count consecutive non-space characters moving left
#
# Time: O(n) where n = len(s)
# Space: O(1) extra

from typing import Optional


def length_of_last_word(s: str) -> int:
    """
    Return the length of the last word in the string s.

    This implementation scans from the end of the string:
      1. Skip trailing spaces.
      2. Count characters until a space or start of string is reached.

    Args:
        s: input string guaranteed to contain at least one word.

    Returns:
        int: length of the last word.
    """
    i = len(s) - 1

    # skip trailing spaces
    while i >= 0 and s[i] == " ":
        i -= 1

    # count characters of the last word
    count = 0
    while i >= 0 and s[i] != " ":
        count += 1
        i -= 1

    return count


# Optional concise variant (keeps memory allocation for split)
def length_of_last_word_split(s: str) -> int:
    """
    Concise variant using split(). This is idiomatic and easy to read.
    Note: split() builds a list of words (uses extra memory).
    """
    return len(s.split()[-1])


# Basic local tests - quick sanity checks before committing
if __name__ == "__main__":
    tests = [
        ("Hello World", 5),
        ("   fly me   to   the moon  ", 4),
        ("luffy is still joyboy", 6),
        ("a", 1),
        ("   a   ", 1),
        ("single", 6),
        ("two words", 5),
        (" trailing-space ", 6),
    ]

    for inp, expected in tests:
        out = length_of_last_word(inp)
        assert out == expected, f"length_of_last_word({inp!r}) -> {out}, expected {expected}"

        out2 = length_of_last_word_split(inp)
        assert out2 == expected, f"length_of_last_word_split({inp!r}) -> {out2}, expected {expected}"

    print("All tests passed.")
