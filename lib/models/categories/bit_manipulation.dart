import '../leetcode_question.dart';

// NeetCode 150 - Bit Manipulation Category
// 7 questions with complete solutions

final List<LeetCodeQuestion> bitManipulationQuestions = [

  LeetCodeQuestion(
    id: 136,
    title: "Single Number",
    difficulty: Difficulty.easy,
    category: "Bit Manipulation",
    question: """Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.

You must implement a solution with a linear runtime complexity and use only constant extra space.

Example 1:
Input: nums = [2,2,1]
Output: 1

Example 2:
Input: nums = [4,1,2,1,2]
Output: 4

Example 3:
Input: nums = [1]
Output: 1

Constraints:
• 1 <= nums.length <= 3 * 10⁴
• -3 * 10⁴ <= nums[i] <= 3 * 10⁴
• Each element in the array appears twice except for one element which appears only once.""",
    bruteForce: Solution(
      code: """def singleNumber(nums):
    from collections import Counter
    count = Counter(nums)

    for num, freq in count.items():
        if freq == 1:
            return num""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Use Counter to track frequency of each number, then find the one with frequency 1. Uses extra space.",
      steps: [
        "Create Counter of all numbers",
        "Iterate through counter entries",
        "Find number with frequency 1",
        "Return that number",
        "Note: O(n) space for counter"
      ],
    ),
    optimized: Solution(
      code: """def singleNumber(nums):
    result = 0

    for num in nums:
        result ^= num

    return result""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "XOR all numbers together. Key properties: a ^ a = 0, a ^ 0 = a. All pairs cancel out (XOR to 0), leaving only the single number.",
      steps: [
        "Initialize result to 0",
        "XOR all numbers together",
        "Key insight:",
        "  - a ^ a = 0 (any number XOR itself is 0)",
        "  - a ^ 0 = a (any number XOR 0 is itself)",
        "  - XOR is commutative and associative",
        "All pairs cancel to 0, single number remains",
        "Return result",
        "Key: Bit manipulation trick, O(1) space"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 191,
    title: "Number of 1 Bits",
    difficulty: Difficulty.easy,
    category: "Bit Manipulation",
    question: """Write a function that takes the binary representation of an unsigned integer and returns the number of '1' bits it has (also known as the Hamming weight).

Example 1:
Input: n = 00000000000000000000000000001011
Output: 3
Explanation: The input binary string 00000000000000000000000000001011 has a total of three '1' bits.

Example 2:
Input: n = 00000000000000000000000010000000
Output: 1
Explanation: The input binary string 00000000000000000000000010000000 has a total of one '1' bit.

Example 3:
Input: n = 11111111111111111111111111111101
Output: 31
Explanation: The input binary string 11111111111111111111111111111101 has a total of thirty one '1' bits.

Constraints:
• The input must be a binary string of length 32.

Follow up: If this function is called many times, how would you optimize it?""",
    bruteForce: Solution(
      code: """def hammingWeight(n):
    count = 0

    while n:
        if n % 2 == 1:
            count += 1
        n //= 2

    return count""",
      timeComplexity: "O(log n) = O(32) = O(1)",
      spaceComplexity: "O(1)",
      explanation: "Repeatedly check last bit using modulo, then divide by 2 to shift right. Count all 1 bits.",
      steps: [
        "Initialize count to 0",
        "While n > 0:",
        "  - Check if last bit is 1 (n % 2 == 1)",
        "  - If yes, increment count",
        "  - Divide n by 2 (shift right)",
        "Return count",
        "Note: Checks all 32 bits"
      ],
    ),
    optimized: Solution(
      code: """def hammingWeight(n):
    count = 0

    while n:
        n &= (n - 1)  # Clear rightmost 1 bit
        count += 1

    return count""",
      timeComplexity: "O(k) where k = number of 1 bits",
      spaceComplexity: "O(1)",
      explanation: "Brian Kernighan's Algorithm. n & (n-1) clears the rightmost 1 bit. Loop only runs once per 1 bit, not for all 32 bits.",
      steps: [
        "Initialize count to 0",
        "While n > 0:",
        "  - Clear rightmost 1 bit: n &= (n - 1)",
        "  - Increment count",
        "Return count",
        "Key insight: n & (n-1) removes rightmost 1",
        "Example: 1100 & 1011 = 1000",
        "Loop runs only k times (k = number of 1s)",
        "Faster than checking all bits"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 338,
    title: "Counting Bits",
    difficulty: Difficulty.easy,
    category: "Bit Manipulation",
    question: """Given an integer n, return an array ans of length n + 1 such that for each i (0 <= i <= n), ans[i] is the number of 1's in the binary representation of i.

Example 1:
Input: n = 2
Output: [0,1,1]
Explanation:
0 --> 0
1 --> 1
2 --> 10

Example 2:
Input: n = 5
Output: [0,1,1,2,1,2]
Explanation:
0 --> 0
1 --> 1
2 --> 10
3 --> 11
4 --> 100
5 --> 101

Constraints:
• 0 <= n <= 10⁵

Follow up:
• It is very easy to come up with a solution with a runtime of O(n log n). Can you do it in linear time O(n) in a single pass?
• Can you do it without using any built-in function (i.e., like __builtin_popcount in C++)?""",
    bruteForce: Solution(
      code: """def countBits(n):
    def countOnes(num):
        count = 0
        while num:
            count += num & 1
            num >>= 1
        return count

    result = []
    for i in range(n + 1):
        result.append(countOnes(i))

    return result""",
      timeComplexity: "O(n log n)",
      spaceComplexity: "O(1) - excluding output",
      explanation: "For each number from 0 to n, count its 1 bits individually. Each count operation is O(log n).",
      steps: [
        "Helper function to count 1 bits in a number",
        "For each i from 0 to n:",
        "  - Count 1 bits in i",
        "  - Add to result",
        "Return result",
        "Note: O(log n) per number, O(n log n) total"
      ],
    ),
    optimized: Solution(
      code: """def countBits(n):
    ans = [0] * (n + 1)

    for i in range(1, n + 1):
        # ans[i] = ans[i // 2] + (i % 2)
        ans[i] = ans[i >> 1] + (i & 1)

    return ans""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1) - excluding output",
      explanation: "Dynamic programming with bit manipulation. Key insight: count(i) = count(i//2) + (i%2). Shifting right removes last bit, last bit tells if we add 1.",
      steps: [
        "Create result array of size n+1",
        "ans[0] = 0 (0 has no 1 bits)",
        "For i from 1 to n:",
        "  - i >> 1 is i with last bit removed",
        "  - We already computed ans[i >> 1]",
        "  - i & 1 is the last bit (0 or 1)",
        "  - ans[i] = ans[i >> 1] + (i & 1)",
        "Return ans",
        "Key: Use previously computed values, O(n) single pass",
        "Example: count(6) = count(3) + 0, because 6=110, 3=11"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 190,
    title: "Reverse Bits",
    difficulty: Difficulty.easy,
    category: "Bit Manipulation",
    question: """Reverse bits of a given 32 bits unsigned integer.

Note:
• Note that in some languages, such as Java, there is no unsigned integer type. In this case, both input and output will be given as a signed integer type. They should not affect your implementation, as the integer's internal binary representation is the same, whether it is signed or unsigned.
• In Java, the compiler represents the signed integers using 2's complement notation. Therefore, in Example 2 above, the input represents the signed integer -3 and the output represents the signed integer -1073741824.

Example 1:
Input: n = 00000010100101000001111010011100
Output:    964176192 (00111001011110000010100101000000)
Explanation: The input binary string 00000010100101000001111010011100 represents the unsigned integer 43261596, so return 964176192 which its binary representation is 00111001011110000010100101000000.

Example 2:
Input: n = 11111111111111111111111111111101
Output:   3221225471 (10111111111111111111111111111111)
Explanation: The input binary string 11111111111111111111111111111101 represents the unsigned integer 4294967293, so return 3221225471 which its binary representation is 10111111111111111111111111111111.

Constraints:
• The input must be a binary string of length 32

Follow up: If this function is called many times, how would you optimize it?""",
    bruteForce: Solution(
      code: """def reverseBits(n):
    # Convert to binary string, reverse, convert back
    binary = bin(n)[2:]  # Remove '0b' prefix
    binary = binary.zfill(32)  # Pad to 32 bits
    reversed_binary = binary[::-1]
    return int(reversed_binary, 2)""",
      timeComplexity: "O(1) - always 32 bits",
      spaceComplexity: "O(1)",
      explanation: "Convert to binary string, reverse string, convert back to integer. Simple but involves string operations.",
      steps: [
        "Convert n to binary string",
        "Pad to 32 bits with leading zeros",
        "Reverse the string",
        "Convert back to integer",
        "Note: String operations are slower than bit ops"
      ],
    ),
    optimized: Solution(
      code: """def reverseBits(n):
    result = 0

    for i in range(32):
        # Get the last bit of n
        bit = n & 1

        # Shift result left and add the bit
        result = (result << 1) | bit

        # Shift n right to process next bit
        n >>= 1

    return result""",
      timeComplexity: "O(1)",
      spaceComplexity: "O(1)",
      explanation: "Process bits one by one. Extract last bit from n, add to result (shifted left). Repeat 32 times. Pure bit manipulation.",
      steps: [
        "Initialize result to 0",
        "For each of 32 bits:",
        "  - Extract last bit of n: bit = n & 1",
        "  - Shift result left: result <<= 1",
        "  - Add bit to result: result |= bit",
        "  - Shift n right: n >>= 1",
        "Return result",
        "Key: Build reversed number bit by bit",
        "No string operations, pure bit manipulation"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 268,
    title: "Missing Number",
    difficulty: Difficulty.easy,
    category: "Bit Manipulation",
    question: """Given an array nums containing n distinct numbers in the range [0, n], return the only number in the range that is missing from the array.

Example 1:
Input: nums = [3,0,1]
Output: 2
Explanation: n = 3 since there are 3 numbers, so all numbers are in the range [0,3]. 2 is the missing number in the range since it does not appear in nums.

Example 2:
Input: nums = [0,1]
Output: 2
Explanation: n = 2 since there are 2 numbers, so all numbers are in the range [0,2]. 2 is the missing number in the range since it does not appear in nums.

Example 3:
Input: nums = [9,6,4,2,3,5,7,0,1]
Output: 8
Explanation: n = 9 since there are 9 numbers, so all numbers are in the range [0,9]. 8 is the missing number in the range since it does not appear in nums.

Constraints:
• n == nums.length
• 1 <= n <= 10⁴
• 0 <= nums[i] <= n
• All the numbers of nums are unique.

Follow up: Could you implement a solution using only O(1) extra space complexity and O(n) runtime complexity?""",
    bruteForce: Solution(
      code: """def missingNumber(nums):
    n = len(nums)
    num_set = set(nums)

    for i in range(n + 1):
        if i not in num_set:
            return i""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Create set of all numbers in array, then check which number from 0 to n is missing. Uses extra space.",
      steps: [
        "Create set from nums array",
        "For i from 0 to n:",
        "  - Check if i in set",
        "  - If not, return i",
        "Note: O(n) extra space for set"
      ],
    ),
    optimized: Solution(
      code: """def missingNumber(nums):
    result = len(nums)

    for i, num in enumerate(nums):
        result ^= i ^ num

    return result""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "XOR approach. XOR all indices (0 to n-1) with all array values. Since all present numbers cancel out (XOR with themselves), only missing number remains.",
      steps: [
        "Initialize result to n (the last index)",
        "For each index i and value num:",
        "  - XOR result with both i and num",
        "  - result ^= i ^ num",
        "All present numbers cancel out (appear in both index and array)",
        "Missing number appears only in indices, doesn't cancel",
        "Return result",
        "Key: XOR properties, O(1) space",
        "Alternative: sum formula: n*(n+1)/2 - sum(nums)"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 371,
    title: "Sum of Two Integers",
    difficulty: Difficulty.medium,
    category: "Bit Manipulation",
    question: """Given two integers a and b, return the sum of the two integers without using the operators + and -.

Example 1:
Input: a = 1, b = 2
Output: 3

Example 2:
Input: a = 2, b = 3
Output: 5

Constraints:
• -1000 <= a, b <= 1000""",
    bruteForce: Solution(
      code: """def getSum(a, b):
    # Simulate addition with loops
    if b > 0:
        for _ in range(b):
            a += 1
    else:
        for _ in range(-b):
            a -= 1

    return a""",
      timeComplexity: "O(b)",
      spaceComplexity: "O(1)",
      explanation: "Increment/decrement a by 1, b times. But this uses + and - operators, violating the constraint. Not a valid solution.",
      steps: [
        "Not a valid solution - uses + operator",
        "This is just for comparison",
        "Don't use this approach"
      ],
    ),
    optimized: Solution(
      code: """def getSum(a, b):
    # Mask to handle 32-bit integers
    mask = 0xFFFFFFFF

    while b != 0:
        # XOR gives sum without carry
        sum_without_carry = (a ^ b) & mask

        # AND and shift gives carry
        carry = ((a & b) << 1) & mask

        a = sum_without_carry
        b = carry

    # Handle negative numbers in Python
    if a > 0x7FFFFFFF:
        return ~(a ^ mask)

    return a""",
      timeComplexity: "O(1) - at most 32 iterations",
      spaceComplexity: "O(1)",
      explanation: "Bit manipulation approach. XOR for sum without carry, AND+shift for carry. Repeat until no carry. Handle Python's arbitrary precision with masking.",
      steps: [
        "Key insights:",
        "  - XOR gives sum without considering carry",
        "  - AND gives positions where carry occurs",
        "  - Left shift AND to get carry value",
        "While carry exists:",
        "  - sum_without_carry = a ^ b",
        "  - carry = (a & b) << 1",
        "  - Update a and b, repeat",
        "Handle Python's unbounded integers with mask",
        "Handle negative result (for Python)",
        "Return final sum",
        "Key: Simulate binary addition with XOR and AND"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 7,
    title: "Reverse Integer",
    difficulty: Difficulty.medium,
    category: "Bit Manipulation",
    question: """Given a signed 32-bit integer x, return x with its digits reversed. If reversing x causes the value to go outside the signed 32-bit integer range [-2³¹, 2³¹ - 1], then return 0.

Assume the environment does not allow you to store 64-bit integers (signed or unsigned).

Example 1:
Input: x = 123
Output: 321

Example 2:
Input: x = -123
Output: -321

Example 3:
Input: x = 120
Output: 21

Constraints:
• -2³¹ <= x <= 2³¹ - 1""",
    bruteForce: Solution(
      code: """def reverse(x):
    # Convert to string, reverse, convert back
    sign = -1 if x < 0 else 1
    x = abs(x)

    reversed_str = str(x)[::-1]
    result = sign * int(reversed_str)

    # Check overflow
    if result < -2**31 or result > 2**31 - 1:
        return 0

    return result""",
      timeComplexity: "O(log x) - number of digits",
      spaceComplexity: "O(log x)",
      explanation: "Convert to string, reverse string, convert back. Simple but uses string operations and extra space.",
      steps: [
        "Store sign of x",
        "Take absolute value",
        "Convert to string and reverse",
        "Convert back to integer",
        "Apply sign",
        "Check for 32-bit overflow",
        "Return result or 0 if overflow",
        "Note: String operations are slower"
      ],
    ),
    optimized: Solution(
      code: """def reverse(x):
    sign = -1 if x < 0 else 1
    x = abs(x)
    result = 0

    while x:
        digit = x % 10
        x //= 10

        # Check overflow before updating result
        if result > (2**31 - 1) // 10:
            return 0

        result = result * 10 + digit

    return sign * result""",
      timeComplexity: "O(log x)",
      spaceComplexity: "O(1)",
      explanation: "Mathematical approach. Extract digits one by one from end, build reversed number. Check overflow before each operation.",
      steps: [
        "Store sign, work with absolute value",
        "Initialize result to 0",
        "While x > 0:",
        "  - Extract last digit: x % 10",
        "  - Remove last digit: x //= 10",
        "  - Check if adding digit causes overflow",
        "  - Update result: result * 10 + digit",
        "Apply sign to result",
        "Return result",
        "Key: Build reversed number mathematically",
        "Check overflow before it happens, O(1) space"
      ],
    ),
  ),

];
