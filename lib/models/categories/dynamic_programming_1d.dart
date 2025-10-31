import '../leetcode_question.dart';

// NeetCode 150 - 1-D Dynamic Programming Category
// 12 questions with complete solutions

final List<LeetCodeQuestion> dynamicProgramming1DQuestions = [

  LeetCodeQuestion(
    id: 70,
    title: "Climbing Stairs",
    difficulty: Difficulty.easy,
    category: "1-D DP",
    question: """You are climbing a staircase. It takes n steps to reach the top.

Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?

Example 1:
Input: n = 2
Output: 2
Explanation: There are two ways to climb to the top.
1. 1 step + 1 step
2. 2 steps

Example 2:
Input: n = 3
Output: 3
Explanation: There are three ways to climb to the top.
1. 1 step + 1 step + 1 step
2. 1 step + 2 steps
3. 2 steps + 1 step

Constraints:
• 1 <= n <= 45""",
    bruteForce: Solution(
      code: """def climbStairs(n):
    def climb(remaining):
        if remaining == 0:
            return 1
        if remaining < 0:
            return 0

        return climb(remaining - 1) + climb(remaining - 2)

    return climb(n)""",
      timeComplexity: "O(2^n)",
      spaceComplexity: "O(n) - recursion depth",
      explanation: "Recursive solution trying both 1-step and 2-step options at each level. Recalculates same subproblems many times, leading to exponential time.",
      steps: [
        "Define recursive function with remaining steps",
        "Base case: if remaining == 0, found one way (return 1)",
        "Base case: if remaining < 0, invalid path (return 0)",
        "Try taking 1 step: recurse with remaining - 1",
        "Try taking 2 steps: recurse with remaining - 2",
        "Return sum of both options",
        "Note: Exponential time due to overlapping subproblems"
      ],
    ),
    optimized: Solution(
      code: """def climbStairs(n):
    if n <= 2:
        return n

    prev2 = 1  # Ways to reach step 1
    prev1 = 2  # Ways to reach step 2

    for i in range(3, n + 1):
        current = prev1 + prev2
        prev2 = prev1
        prev1 = current

    return prev1""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Bottom-up DP with space optimization. Ways to reach step i = ways to reach (i-1) + ways to reach (i-2). Only need last two values.",
      steps: [
        "Handle base cases: n=1 returns 1, n=2 returns 2",
        "Initialize prev2 = 1 (ways to step 1), prev1 = 2 (ways to step 2)",
        "For each step from 3 to n:",
        "  - Current ways = prev1 + prev2 (Fibonacci pattern)",
        "  - Shift values: prev2 = prev1, prev1 = current",
        "Return prev1 (ways to reach step n)",
        "Key: Fibonacci sequence, O(1) space with two variables"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 746,
    title: "Min Cost Climbing Stairs",
    difficulty: Difficulty.easy,
    category: "1-D DP",
    question: """You are given an integer array cost where cost[i] is the cost of ith step on a staircase. Once you pay the cost, you can either climb one or two steps.

You can either start from the step with index 0, or the step with index 1.

Return the minimum cost to reach the top of the floor.

Example 1:
Input: cost = [10,15,20]
Output: 15
Explanation: You will start at index 1.
- Pay 15 and climb two steps to reach the top.
The total cost is 15.

Example 2:
Input: cost = [1,100,1,1,1,100,1,1,100,1]
Output: 6
Explanation: You will start at index 0.
- Pay 1 and climb two steps to reach index 2.
- Pay 1 and climb two steps to reach index 4.
- Pay 1 and climb two steps to reach index 6.
- Pay 1 and climb one step to reach index 7.
- Pay 1 and climb two steps to reach index 9.
- Pay 1 and climb one step to reach the top.
The total cost is 6.

Constraints:
• 2 <= cost.length <= 1000
• 0 <= cost[i] <= 999""",
    bruteForce: Solution(
      code: """def minCostClimbingStairs(cost):
    def minCost(i):
        if i >= len(cost):
            return 0

        return cost[i] + min(minCost(i + 1), minCost(i + 2))

    return min(minCost(0), minCost(1))""",
      timeComplexity: "O(2^n)",
      spaceComplexity: "O(n)",
      explanation: "Recursive solution calculating minimum cost from each step. Recalculates overlapping subproblems, leading to exponential time complexity.",
      steps: [
        "Define recursive function from step i",
        "Base case: if i >= len(cost), reached top (cost 0)",
        "Current step cost + min of (next step, skip one step)",
        "Start from both step 0 and step 1",
        "Return minimum of both starting points",
        "Note: Massive overlap in recursive calls"
      ],
    ),
    optimized: Solution(
      code: """def minCostClimbingStairs(cost):
    n = len(cost)

    prev2 = 0  # Min cost to reach step 0
    prev1 = 0  # Min cost to reach step 1

    for i in range(2, n + 1):
        current = min(prev1 + cost[i - 1], prev2 + cost[i - 2])
        prev2 = prev1
        prev1 = current

    return prev1""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Bottom-up DP. Min cost to reach step i is minimum of (cost from i-1) or (cost from i-2). Use two variables for space optimization.",
      steps: [
        "Initialize prev2 = 0 (cost to step 0), prev1 = 0 (cost to step 1)",
        "Can start from either without paying",
        "For each step from 2 to n (top):",
        "  - Option 1: come from prev step, pay cost[i-1]",
        "  - Option 2: come from two steps back, pay cost[i-2]",
        "  - Take minimum of both options",
        "  - Shift variables forward",
        "Return prev1 (min cost to reach top)",
        "Key: Only need last two values, O(1) space"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 198,
    title: "House Robber",
    difficulty: Difficulty.medium,
    category: "1-D DP",
    question: """You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security systems connected and it will automatically contact the police if two adjacent houses were broken into on the same night.

Given an integer array nums representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.

Example 1:
Input: nums = [1,2,3,1]
Output: 4
Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
Total amount you can rob = 1 + 3 = 4.

Example 2:
Input: nums = [2,7,9,3,1]
Output: 12
Explanation: Rob house 1 (money = 2), rob house 3 (money = 9) and rob house 5 (money = 1).
Total amount you can rob = 2 + 9 + 1 = 12.

Constraints:
• 1 <= nums.length <= 100
• 0 <= nums[i] <= 400""",
    bruteForce: Solution(
      code: """def rob(nums):
    def maxRob(i):
        if i >= len(nums):
            return 0

        # Rob current house + skip next
        rob_current = nums[i] + maxRob(i + 2)

        # Skip current house
        skip_current = maxRob(i + 1)

        return max(rob_current, skip_current)

    return maxRob(0)""",
      timeComplexity: "O(2^n)",
      spaceComplexity: "O(n)",
      explanation: "Recursive solution with two choices at each house: rob it or skip it. Overlapping subproblems cause exponential time.",
      steps: [
        "Define recursive function starting from house i",
        "Base case: if i >= length, no houses left (return 0)",
        "Option 1: rob current house, skip next, rob i+2",
        "Option 2: skip current house, try next house",
        "Return maximum of both options",
        "Start from house 0",
        "Note: Recalculates same indices many times"
      ],
    ),
    optimized: Solution(
      code: """def rob(nums):
    if not nums:
        return 0
    if len(nums) == 1:
        return nums[0]

    prev2 = 0  # Max money up to i-2
    prev1 = 0  # Max money up to i-1

    for num in nums:
        current = max(prev1, prev2 + num)
        prev2 = prev1
        prev1 = current

    return prev1""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Bottom-up DP with space optimization. At each house, choose max of (skip it and take prev max) or (rob it plus max from two houses back).",
      steps: [
        "Handle edge cases: empty array or single house",
        "Initialize prev2 = 0 (max before previous), prev1 = 0 (max at previous)",
        "For each house:",
        "  - Option 1: skip this house, keep prev1",
        "  - Option 2: rob this house, add to prev2",
        "  - Current max = max(prev1, prev2 + num)",
        "  - Shift values: prev2 = prev1, prev1 = current",
        "Return prev1 (maximum money robbed)",
        "Key: Only need last two maxes, O(1) space"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 213,
    title: "House Robber II",
    difficulty: Difficulty.medium,
    category: "1-D DP",
    question: """You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed. All houses at this place are arranged in a circle. That means the first house is the neighbor of the last one. Meanwhile, adjacent houses have the same security system connected, and it will automatically contact the police if two adjacent houses were broken into on the same night.

Given an integer array nums representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.

Example 1:
Input: nums = [2,3,2]
Output: 3
Explanation: You cannot rob house 1 (money = 2) and then rob house 3 (money = 2), because they are adjacent houses.

Example 2:
Input: nums = [1,2,3,1]
Output: 4
Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
Total amount you can rob = 1 + 3 = 4.

Example 3:
Input: nums = [1,2,3]
Output: 3

Constraints:
• 1 <= nums.length <= 100
• 0 <= nums[i] <= 1000""",
    bruteForce: Solution(
      code: """def rob(nums):
    if len(nums) == 1:
        return nums[0]

    def robLinear(houses):
        if not houses:
            return 0
        if len(houses) == 1:
            return houses[0]

        prev2, prev1 = 0, 0
        for num in houses:
            current = max(prev1, prev2 + num)
            prev2 = prev1
            prev1 = current
        return prev1

    # Try robbing houses 0 to n-2 (excluding last)
    # Try robbing houses 1 to n-1 (excluding first)
    return max(robLinear(nums[:-1]), robLinear(nums[1:]))""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n) - array slicing",
      explanation: "Since first and last houses are adjacent in circle, can't rob both. Run House Robber I twice: once excluding first house, once excluding last house.",
      steps: [
        "Handle edge case: single house, return its value",
        "Define robLinear function (House Robber I solution)",
        "Can't rob both first and last house",
        "Scenario 1: rob houses 0 to n-2 (exclude last)",
        "Scenario 2: rob houses 1 to n-1 (exclude first)",
        "Return maximum of both scenarios",
        "Note: Array slicing creates O(n) space"
      ],
    ),
    optimized: Solution(
      code: """def rob(nums):
    if len(nums) == 1:
        return nums[0]

    def robRange(start, end):
        prev2, prev1 = 0, 0
        for i in range(start, end):
            current = max(prev1, prev2 + nums[i])
            prev2 = prev1
            prev1 = current
        return prev1

    # Rob houses 0 to n-2, or houses 1 to n-1
    return max(robRange(0, len(nums) - 1), robRange(1, len(nums)))""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Same approach but use indices instead of array slicing to achieve O(1) space. Run linear rob algorithm on two ranges.",
      steps: [
        "Handle single house edge case",
        "Define robRange helper with start and end indices",
        "Uses same DP logic as House Robber I",
        "But operates on index range without creating new array",
        "Call robRange(0, n-1): exclude last house",
        "Call robRange(1, n): exclude first house",
        "Return maximum of both",
        "Key: Index-based ranges avoid O(n) space from slicing"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 5,
    title: "Longest Palindromic Substring",
    difficulty: Difficulty.medium,
    category: "1-D DP",
    question: """Given a string s, return the longest palindromic substring in s.

Example 1:
Input: s = "babad"
Output: "bab"
Explanation: "aba" is also a valid answer.

Example 2:
Input: s = "cbbd"
Output: "bb"

Constraints:
• 1 <= s.length <= 1000
• s consist of only digits and English letters.""",
    bruteForce: Solution(
      code: """def longestPalindrome(s):
    def isPalindrome(left, right):
        while left < right:
            if s[left] != s[right]:
                return False
            left += 1
            right -= 1
        return True

    longest = ""

    for i in range(len(s)):
        for j in range(i, len(s)):
            if isPalindrome(i, j):
                if j - i + 1 > len(longest):
                    longest = s[i:j+1]

    return longest""",
      timeComplexity: "O(n³)",
      spaceComplexity: "O(1)",
      explanation: "Check every substring using nested loops, verify palindrome with another loop. Three nested operations give cubic time.",
      steps: [
        "Define isPalindrome helper to check substring",
        "Initialize longest as empty string",
        "For each starting index i:",
        "  - For each ending index j from i onwards:",
        "    - Check if s[i:j+1] is palindrome",
        "    - If palindrome and longer than current longest, update",
        "Return longest palindrome found",
        "Note: O(n²) substrings × O(n) check = O(n³)"
      ],
    ),
    optimized: Solution(
      code: """def longestPalindrome(s):
    def expandAroundCenter(left, right):
        while left >= 0 and right < len(s) and s[left] == s[right]:
            left -= 1
            right += 1
        return right - left - 1

    start = 0
    max_len = 0

    for i in range(len(s)):
        # Odd length palindromes (center is single char)
        len1 = expandAroundCenter(i, i)
        # Even length palindromes (center is between chars)
        len2 = expandAroundCenter(i, i + 1)

        current_len = max(len1, len2)

        if current_len > max_len:
            max_len = current_len
            start = i - (current_len - 1) // 2

    return s[start:start + max_len]""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(1)",
      explanation: "Expand around each possible center. For each position, try expanding odd-length (single center) and even-length (double center) palindromes.",
      steps: [
        "Define expandAroundCenter to find palindrome length from center",
        "Initialize start index and max_len",
        "For each position i as potential center:",
        "  - Expand for odd-length palindrome (center at i)",
        "  - Expand for even-length palindrome (center between i and i+1)",
        "  - Take max of both lengths",
        "  - If longer than current max, update start and max_len",
        "Return substring using calculated start and length",
        "Key: O(n) positions × O(n) expand = O(n²), better than O(n³)"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 647,
    title: "Palindromic Substrings",
    difficulty: Difficulty.medium,
    category: "1-D DP",
    question: """Given a string s, return the number of palindromic substrings in it.

A string is a palindrome when it reads the same backward as forward.

A substring is a contiguous sequence of characters within the string.

Example 1:
Input: s = "abc"
Output: 3
Explanation: Three palindromic strings: "a", "b", "c".

Example 2:
Input: s = "aaa"
Output: 6
Explanation: Six palindromic strings: "a", "a", "a", "aa", "aa", "aaa".

Constraints:
• 1 <= s.length <= 1000
• s consists of lowercase English letters.""",
    bruteForce: Solution(
      code: """def countSubstrings(s):
    def isPalindrome(left, right):
        while left < right:
            if s[left] != s[right]:
                return False
            left += 1
            right -= 1
        return True

    count = 0

    for i in range(len(s)):
        for j in range(i, len(s)):
            if isPalindrome(i, j):
                count += 1

    return count""",
      timeComplexity: "O(n³)",
      spaceComplexity: "O(1)",
      explanation: "Check every substring for palindrome property. Generate O(n²) substrings and check each in O(n) time.",
      steps: [
        "Define isPalindrome helper function",
        "Initialize count to 0",
        "For each starting index i:",
        "  - For each ending index j:",
        "    - Check if s[i:j+1] is palindrome",
        "    - If yes, increment count",
        "Return total count",
        "Note: Cubic time complexity"
      ],
    ),
    optimized: Solution(
      code: """def countSubstrings(s):
    def expandAroundCenter(left, right):
        count = 0
        while left >= 0 and right < len(s) and s[left] == s[right]:
            count += 1
            left -= 1
            right += 1
        return count

    total = 0

    for i in range(len(s)):
        # Odd length palindromes
        total += expandAroundCenter(i, i)
        # Even length palindromes
        total += expandAroundCenter(i, i + 1)

    return total""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(1)",
      explanation: "Expand around each center, counting palindromes as we expand. Each position can be center of odd or even length palindrome.",
      steps: [
        "Define expandAroundCenter to count palindromes from center",
        "Initialize total count",
        "For each position:",
        "  - Expand for odd-length palindromes (single center)",
        "  - Expand for even-length palindromes (double center)",
        "  - Add counts from both expansions to total",
        "Return total count",
        "Key: Count while expanding, O(n²) overall"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 91,
    title: "Decode Ways",
    difficulty: Difficulty.medium,
    category: "1-D DP",
    question: """A message containing letters from A-Z can be encoded into numbers using the following mapping:

'A' -> "1"
'B' -> "2"
...
'Z' -> "26"

To decode an encoded message, all the digits must be grouped then mapped back into letters using the reverse of the mapping above (there may be multiple ways). For example, "11106" can be mapped into:
• "AAJF" with the grouping (1 1 10 6)
• "KJF" with the grouping (11 10 6)

Note that the grouping (1 11 06) is invalid because "06" cannot be mapped into 'F' since "6" is different from "06".

Given a string s containing only digits, return the number of ways to decode it.

Example 1:
Input: s = "12"
Output: 2
Explanation: "12" could be decoded as "AB" (1 2) or "L" (12).

Example 2:
Input: s = "226"
Output: 3
Explanation: "226" could be decoded as "BZ" (2 26), "VF" (22 6), or "BBF" (2 2 6).

Example 3:
Input: s = "06"
Output: 0
Explanation: "06" cannot be mapped to "F" because of the leading zero ("6" is different from "06").

Constraints:
• 1 <= s.length <= 100
• s contains only digits and may contain leading zero(s).""",
    bruteForce: Solution(
      code: """def numDecodings(s):
    def decode(index):
        if index == len(s):
            return 1

        if s[index] == '0':
            return 0

        ways = decode(index + 1)  # Take single digit

        if index + 1 < len(s):
            two_digit = int(s[index:index+2])
            if two_digit <= 26:
                ways += decode(index + 2)  # Take two digits

        return ways

    return decode(0)""",
      timeComplexity: "O(2^n)",
      spaceComplexity: "O(n)",
      explanation: "Recursive solution trying single-digit and two-digit decodings. Overlapping subproblems cause exponential time.",
      steps: [
        "Define recursive function starting at index",
        "Base case: reached end of string, found one way",
        "Invalid case: current digit is '0', return 0",
        "Try decoding single digit: recurse from index + 1",
        "Try decoding two digits if valid (10-26): recurse from index + 2",
        "Return sum of both options",
        "Note: Recalculates same positions many times"
      ],
    ),
    optimized: Solution(
      code: """def numDecodings(s):
    if not s or s[0] == '0':
        return 0

    n = len(s)
    prev2 = 1  # dp[i-2]
    prev1 = 1  # dp[i-1]

    for i in range(1, n):
        current = 0

        # Single digit decode
        if s[i] != '0':
            current += prev1

        # Two digit decode
        two_digit = int(s[i-1:i+1])
        if 10 <= two_digit <= 26:
            current += prev2

        prev2 = prev1
        prev1 = current

    return prev1""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Bottom-up DP with space optimization. Ways to decode up to position i depends on last one or two digits. Use two variables for O(1) space.",
      steps: [
        "Handle edge case: empty string or starts with '0'",
        "Initialize prev2 = 1 (base case), prev1 = 1 (first char)",
        "For each position from 1 to n-1:",
        "  - Current ways = 0",
        "  - If current digit not '0', can decode single: add prev1",
        "  - If last two digits form valid number (10-26), add prev2",
        "  - Shift values: prev2 = prev1, prev1 = current",
        "Return prev1 (ways to decode entire string)",
        "Key: Like Fibonacci but with conditions"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 322,
    title: "Coin Change",
    difficulty: Difficulty.medium,
    category: "1-D DP",
    question: """You are given an integer array coins representing coins of different denominations and an integer amount representing a total amount of money.

Return the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return -1.

You may assume that you have an infinite number of each kind of coin.

Example 1:
Input: coins = [1,2,5], amount = 11
Output: 3
Explanation: 11 = 5 + 5 + 1

Example 2:
Input: coins = [2], amount = 3
Output: -1

Example 3:
Input: coins = [1], amount = 0
Output: 0

Constraints:
• 1 <= coins.length <= 12
• 1 <= coins[i] <= 2³¹ - 1
• 0 <= amount <= 10⁴""",
    bruteForce: Solution(
      code: """def coinChange(coins, amount):
    def minCoins(remaining):
        if remaining == 0:
            return 0
        if remaining < 0:
            return float('inf')

        min_count = float('inf')
        for coin in coins:
            count = minCoins(remaining - coin)
            if count != float('inf'):
                min_count = min(min_count, count + 1)

        return min_count

    result = minCoins(amount)
    return result if result != float('inf') else -1""",
      timeComplexity: "O(amount^coins) - exponential",
      spaceComplexity: "O(amount)",
      explanation: "Recursive solution trying each coin at each step. Massive overlapping subproblems lead to exponential time complexity.",
      steps: [
        "Define recursive function with remaining amount",
        "Base case: remaining == 0, need 0 coins",
        "Base case: remaining < 0, invalid (return infinity)",
        "Try each coin denomination:",
        "  - Recurse with remaining - coin",
        "  - Track minimum coins needed",
        "Return min count + 1 (for current coin)",
        "If result is infinity, impossible to make amount",
        "Note: Recalculates same amounts repeatedly"
      ],
    ),
    optimized: Solution(
      code: """def coinChange(coins, amount):
    dp = [float('inf')] * (amount + 1)
    dp[0] = 0

    for i in range(1, amount + 1):
        for coin in coins:
            if coin <= i:
                dp[i] = min(dp[i], dp[i - coin] + 1)

    return dp[amount] if dp[amount] != float('inf') else -1""",
      timeComplexity: "O(amount * coins)",
      spaceComplexity: "O(amount)",
      explanation: "Bottom-up DP building solutions from 0 to amount. For each value, try all coins and take minimum. DP table stores min coins for each amount.",
      steps: [
        "Create DP array of size amount + 1, initialized to infinity",
        "Base case: dp[0] = 0 (0 coins for amount 0)",
        "For each amount from 1 to target:",
        "  - For each coin denomination:",
        "    - If coin <= current amount:",
        "      - Option: use this coin + solution for (amount - coin)",
        "      - Update dp[i] with minimum",
        "Return dp[amount] if valid, else -1",
        "Key: Build up solutions for all amounts 0 to target"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 152,
    title: "Maximum Product Subarray",
    difficulty: Difficulty.medium,
    category: "1-D DP",
    question: """Given an integer array nums, find a subarray that has the largest product, and return the product.

Example 1:
Input: nums = [2,3,-2,4]
Output: 6
Explanation: [2,3] has the largest product 6.

Example 2:
Input: nums = [-2,0,-1]
Output: 0
Explanation: The result cannot be 2, because [-2,-1] is not a subarray.

Constraints:
• 1 <= nums.length <= 2 * 10⁴
• -10 <= nums[i] <= 10
• The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.""",
    bruteForce: Solution(
      code: """def maxProduct(nums):
    max_prod = float('-inf')

    for i in range(len(nums)):
        product = 1
        for j in range(i, len(nums)):
            product *= nums[j]
            max_prod = max(max_prod, product)

    return max_prod""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(1)",
      explanation: "Check all possible subarrays by nested loops. Calculate product for each subarray and track maximum.",
      steps: [
        "Initialize max_prod to negative infinity",
        "For each starting index i:",
        "  - Initialize product to 1",
        "  - For each ending index j from i:",
        "    - Multiply product by nums[j]",
        "    - Update max_prod if larger",
        "Return maximum product found",
        "Note: O(n²) subarrays to check"
      ],
    ),
    optimized: Solution(
      code: """def maxProduct(nums):
    if not nums:
        return 0

    max_prod = nums[0]
    current_max = nums[0]
    current_min = nums[0]

    for i in range(1, len(nums)):
        num = nums[i]

        # Negative number can flip max and min
        if num < 0:
            current_max, current_min = current_min, current_max

        current_max = max(num, current_max * num)
        current_min = min(num, current_min * num)

        max_prod = max(max_prod, current_max)

    return max_prod""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Track both maximum and minimum products ending at current position. Negative numbers can turn minimum into maximum. Reset when starting new subarray is better.",
      steps: [
        "Initialize max_prod, current_max, current_min with first element",
        "For each element from index 1:",
        "  - If negative, swap current_max and current_min",
        "    (Negative × min becomes max)",
        "  - Update current_max: max of (num alone, current_max × num)",
        "  - Update current_min: min of (num alone, current_min × num)",
        "  - Update global max_prod",
        "Return max_prod",
        "Key: Track both max and min due to negative numbers"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 139,
    title: "Word Break",
    difficulty: Difficulty.medium,
    category: "1-D DP",
    question: """Given a string s and a dictionary of strings wordDict, return true if s can be segmented into a space-separated sequence of one or more dictionary words.

Note that the same word in the dictionary may be reused multiple times in the segmentation.

Example 1:
Input: s = "leetcode", wordDict = ["leet","code"]
Output: true
Explanation: Return true because "leetcode" can be segmented as "leet code".

Example 2:
Input: s = "applepenapple", wordDict = ["apple","pen"]
Output: true
Explanation: Return true because "applepenapple" can be segmented as "apple pen apple".
Note that you are allowed to reuse a dictionary word.

Example 3:
Input: s = "catsandog", wordDict = ["cats","dog","sand","and","cat"]
Output: false

Constraints:
• 1 <= s.length <= 300
• 1 <= wordDict.length <= 1000
• 1 <= wordDict[i].length <= 20
• s and wordDict[i] consist of only lowercase English letters.
• All the strings of wordDict are unique.""",
    bruteForce: Solution(
      code: """def wordBreak(s, wordDict):
    word_set = set(wordDict)

    def canBreak(start):
        if start == len(s):
            return True

        for end in range(start + 1, len(s) + 1):
            if s[start:end] in word_set:
                if canBreak(end):
                    return True

        return False

    return canBreak(0)""",
      timeComplexity: "O(2^n)",
      spaceComplexity: "O(n)",
      explanation: "Recursive solution trying all possible splits. Check if prefix is in dictionary, then recurse on remaining. Overlapping subproblems cause exponential time.",
      steps: [
        "Convert wordDict to set for O(1) lookup",
        "Define recursive function from start index",
        "Base case: reached end of string, return True",
        "Try all possible end positions:",
        "  - If s[start:end] is valid word:",
        "    - Recursively check if rest can be broken",
        "    - If yes, return True",
        "Return False if no valid split found",
        "Note: Rechecks same positions many times"
      ],
    ),
    optimized: Solution(
      code: """def wordBreak(s, wordDict):
    word_set = set(wordDict)
    n = len(s)
    dp = [False] * (n + 1)
    dp[0] = True  # Empty string

    for i in range(1, n + 1):
        for j in range(i):
            if dp[j] and s[j:i] in word_set:
                dp[i] = True
                break

    return dp[n]""",
      timeComplexity: "O(n² * m) - m is max word length",
      spaceComplexity: "O(n)",
      explanation: "Bottom-up DP. dp[i] = true if s[0:i] can be segmented. For each position, check all previous positions to see if valid word exists.",
      steps: [
        "Convert wordDict to set",
        "Create DP array, dp[i] = can segment s[0:i]",
        "Base case: dp[0] = True (empty string)",
        "For each position i from 1 to n:",
        "  - For each previous position j < i:",
        "    - If dp[j] is True (s[0:j] can be segmented)",
        "    - And s[j:i] is in dictionary",
        "    - Then dp[i] = True, break",
        "Return dp[n]",
        "Key: Build up solutions from empty to full string"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 300,
    title: "Longest Increasing Subsequence",
    difficulty: Difficulty.medium,
    category: "1-D DP",
    question: """Given an integer array nums, return the length of the longest strictly increasing subsequence.

Example 1:
Input: nums = [10,9,2,5,3,7,101,18]
Output: 4
Explanation: The longest increasing subsequence is [2,3,7,101], therefore the length is 4.

Example 2:
Input: nums = [0,1,0,3,2,3]
Output: 4

Example 3:
Input: nums = [7,7,7,7,7,7,7]
Output: 1

Constraints:
• 1 <= nums.length <= 2500
• -10⁴ <= nums[i] <= 10⁴

Follow up: Can you come up with an algorithm that runs in O(n log n) time complexity?""",
    bruteForce: Solution(
      code: """def lengthOfLIS(nums):
    n = len(nums)
    dp = [1] * n

    for i in range(n):
        for j in range(i):
            if nums[j] < nums[i]:
                dp[i] = max(dp[i], dp[j] + 1)

    return max(dp)""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(n)",
      explanation: "DP where dp[i] = length of longest increasing subsequence ending at i. For each position, check all previous positions to find longest subsequence to extend.",
      steps: [
        "Create DP array, dp[i] = LIS length ending at index i",
        "Initialize all to 1 (each element alone is length 1)",
        "For each position i:",
        "  - For each previous position j < i:",
        "    - If nums[j] < nums[i] (can extend):",
        "      - dp[i] = max(dp[i], dp[j] + 1)",
        "Return maximum value in dp array",
        "Note: O(n²) but straightforward DP approach"
      ],
    ),
    optimized: Solution(
      code: """def lengthOfLIS(nums):
    import bisect

    tails = []

    for num in nums:
        pos = bisect.bisect_left(tails, num)

        if pos == len(tails):
            tails.append(num)
        else:
            tails[pos] = num

    return len(tails)""",
      timeComplexity: "O(n log n)",
      spaceComplexity: "O(n)",
      explanation: "Maintain array of smallest tail values for increasing subsequences of each length. Use binary search to find position. Greedy approach with intelligent bookkeeping.",
      steps: [
        "Initialize empty tails array",
        "tails[i] = smallest ending value of increasing subsequence of length i+1",
        "For each number:",
        "  - Binary search for position in tails",
        "  - If pos == len(tails), number extends longest sequence",
        "  - Otherwise, replace tails[pos] with number (better tail)",
        "Length of tails is length of LIS",
        "Key: Binary search gives O(n log n) instead of O(n²)"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 416,
    title: "Partition Equal Subset Sum",
    difficulty: Difficulty.medium,
    category: "1-D DP",
    question: """Given an integer array nums, return true if you can partition the array into two subsets such that the sum of the elements in both subsets is equal.

Example 1:
Input: nums = [1,5,11,5]
Output: true
Explanation: The array can be partitioned as [1, 5, 5] and [11].

Example 2:
Input: nums = [1,2,3,5]
Output: false
Explanation: The array cannot be partitioned into equal sum subsets.

Constraints:
• 1 <= nums.length <= 200
• 1 <= nums[i] <= 100""",
    bruteForce: Solution(
      code: """def canPartition(nums):
    total = sum(nums)

    if total % 2 != 0:
        return False

    target = total // 2

    def canSum(index, current_sum):
        if current_sum == target:
            return True
        if index >= len(nums) or current_sum > target:
            return False

        # Include current number
        if canSum(index + 1, current_sum + nums[index]):
            return True

        # Exclude current number
        if canSum(index + 1, current_sum):
            return True

        return False

    return canSum(0, 0)""",
      timeComplexity: "O(2^n)",
      spaceComplexity: "O(n)",
      explanation: "Recursive solution trying to include or exclude each number. If sum is odd, impossible. Otherwise, find subset summing to half of total.",
      steps: [
        "Calculate total sum",
        "If odd, can't partition equally, return False",
        "Target is total / 2",
        "Define recursive function with index and current sum",
        "Base case: current sum == target, found it",
        "Base case: index out of bounds or sum exceeds target",
        "Try including current number",
        "Try excluding current number",
        "Return True if either works",
        "Note: Exponential due to overlapping subproblems"
      ],
    ),
    optimized: Solution(
      code: """def canPartition(nums):
    total = sum(nums)

    if total % 2 != 0:
        return False

    target = total // 2
    dp = [False] * (target + 1)
    dp[0] = True

    for num in nums:
        for j in range(target, num - 1, -1):
            dp[j] = dp[j] or dp[j - num]

    return dp[target]""",
      timeComplexity: "O(n * sum/2)",
      spaceComplexity: "O(sum/2)",
      explanation: "0/1 knapsack problem. dp[i] = can achieve sum i. Process numbers one by one, updating which sums are achievable. Iterate backwards to avoid using same number twice.",
      steps: [
        "Calculate total, if odd return False",
        "Target is total / 2",
        "Create DP array, dp[i] = can make sum i",
        "Base case: dp[0] = True (sum 0 with no numbers)",
        "For each number in nums:",
        "  - Iterate target down to num (backwards):",
        "    - dp[j] = can make j without this num OR (can make j-num and add this num)",
        "Return dp[target]",
        "Key: Backwards iteration ensures each number used once"
      ],
    ),
  ),

];
