import '../leetcode_question.dart';

// NeetCode 150 - 2-D Dynamic Programming Category
// 11 questions with complete solutions

final List<LeetCodeQuestion> dynamicProgramming2DQuestions = [

  LeetCodeQuestion(
    id: 62,
    title: "Unique Paths",
    difficulty: Difficulty.medium,
    category: "2-D DP",
    question: """There is a robot on an m x n grid. The robot is initially located at the top-left corner (i.e., grid[0][0]). The robot tries to move to the bottom-right corner (i.e., grid[m - 1][n - 1]). The robot can only move either down or right at any point in time.

Given the two integers m and n, return the number of possible unique paths that the robot can take to reach the bottom-right corner.

Example 1:
Input: m = 3, n = 7
Output: 28

Example 2:
Input: m = 3, n = 2
Output: 3
Explanation: From the top-left corner, there are a total of 3 ways to reach the bottom-right corner:
1. Right -> Down -> Down
2. Down -> Down -> Right
3. Down -> Right -> Down

Constraints:
• 1 <= m, n <= 100""",
    bruteForce: Solution(
      code: """def uniquePaths(m, n):
    def countPaths(row, col):
        if row == m - 1 and col == n - 1:
            return 1
        if row >= m or col >= n:
            return 0

        return countPaths(row + 1, col) + countPaths(row, col + 1)

    return countPaths(0, 0)""",
      timeComplexity: "O(2^(m+n))",
      spaceComplexity: "O(m + n)",
      explanation: "Recursive solution trying both down and right moves from each cell. Massive overlapping subproblems cause exponential time.",
      steps: [
        "Define recursive function from position (row, col)",
        "Base case: reached destination (m-1, n-1), return 1",
        "Base case: out of bounds, return 0",
        "Try moving down: countPaths(row + 1, col)",
        "Try moving right: countPaths(row, col + 1)",
        "Return sum of both paths",
        "Note: Recalculates same cells exponentially many times"
      ],
    ),
    optimized: Solution(
      code: """def uniquePaths(m, n):
    dp = [[1] * n for _ in range(m)]

    for i in range(1, m):
        for j in range(1, n):
            dp[i][j] = dp[i-1][j] + dp[i][j-1]

    return dp[m-1][n-1]""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(m * n)",
      explanation: "Bottom-up DP. Paths to cell (i,j) = paths to cell above + paths to cell left. First row and column all have 1 path.",
      steps: [
        "Create m x n DP table, initialize all to 1",
        "First row and first column all have 1 path (only one direction)",
        "For each cell (i, j) starting from (1, 1):",
        "  - Paths = paths from above + paths from left",
        "  - dp[i][j] = dp[i-1][j] + dp[i][j-1]",
        "Return dp[m-1][n-1]",
        "Key: Build up from top-left to bottom-right"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 1143,
    title: "Longest Common Subsequence",
    difficulty: Difficulty.medium,
    category: "2-D DP",
    question: """Given two strings text1 and text2, return the length of their longest common subsequence. If there is no common subsequence, return 0.

A subsequence of a string is a new string generated from the original string with some characters (can be none) deleted without changing the relative order of the remaining characters.

For example, "ace" is a subsequence of "abcde".

A common subsequence of two strings is a subsequence that is common to both strings.

Example 1:
Input: text1 = "abcde", text2 = "ace"
Output: 3
Explanation: The longest common subsequence is "ace" and its length is 3.

Example 2:
Input: text1 = "abc", text2 = "abc"
Output: 3
Explanation: The longest common subsequence is "abc" and its length is 3.

Example 3:
Input: text1 = "abc", text2 = "def"
Output: 0
Explanation: There is no such common subsequence, so the result is 0.

Constraints:
• 1 <= text1.length, text2.length <= 1000
• text1 and text2 consist of only lowercase English characters.""",
    bruteForce: Solution(
      code: """def longestCommonSubsequence(text1, text2):
    def lcs(i, j):
        if i >= len(text1) or j >= len(text2):
            return 0

        if text1[i] == text2[j]:
            return 1 + lcs(i + 1, j + 1)

        return max(lcs(i + 1, j), lcs(i, j + 1))

    return lcs(0, 0)""",
      timeComplexity: "O(2^(m+n))",
      spaceComplexity: "O(m + n)",
      explanation: "Recursive solution. If characters match, include and move both pointers. Otherwise, try skipping character in either string. Overlapping subproblems cause exponential time.",
      steps: [
        "Define recursive function with indices i and j",
        "Base case: reached end of either string, return 0",
        "If characters match:",
        "  - Include in LCS, return 1 + lcs(i+1, j+1)",
        "Otherwise:",
        "  - Try skipping text1[i]: lcs(i+1, j)",
        "  - Try skipping text2[j]: lcs(i, j+1)",
        "  - Return maximum of both options",
        "Note: Recalculates same (i,j) pairs many times"
      ],
    ),
    optimized: Solution(
      code: """def longestCommonSubsequence(text1, text2):
    m, n = len(text1), len(text2)
    dp = [[0] * (n + 1) for _ in range(m + 1)]

    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if text1[i-1] == text2[j-1]:
                dp[i][j] = 1 + dp[i-1][j-1]
            else:
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])

    return dp[m][n]""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(m * n)",
      explanation: "Bottom-up DP with 2D table. dp[i][j] = LCS of text1[0:i] and text2[0:j]. Build table from empty strings to full strings.",
      steps: [
        "Create (m+1) x (n+1) DP table, initialized to 0",
        "Extra row and column for empty string base case",
        "For each position (i, j) from 1 to m, n:",
        "  - If characters match: dp[i][j] = 1 + dp[i-1][j-1]",
        "  - Otherwise: dp[i][j] = max(dp[i-1][j], dp[i][j-1])",
        "Return dp[m][n]",
        "Key: Classic 2D DP, builds solutions bottom-up"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 309,
    title: "Best Time to Buy and Sell Stock with Cooldown",
    difficulty: Difficulty.medium,
    category: "2-D DP",
    question: """You are given an array prices where prices[i] is the price of a given stock on the ith day.

Find the maximum profit you can achieve. You may complete as many transactions as you like (i.e., buy one and sell one share of the stock multiple times) with the following restrictions:
• After you sell your stock, you cannot buy stock on the next day (i.e., cooldown one day).

Note: You may not engage in multiple transactions simultaneously (i.e., you must sell the stock before you buy again).

Example 1:
Input: prices = [1,2,3,0,2]
Output: 3
Explanation: transactions = [buy, sell, cooldown, buy, sell]

Example 2:
Input: prices = [1]
Output: 0

Constraints:
• 1 <= prices.length <= 5000
• 0 <= prices[i] <= 1000""",
    bruteForce: Solution(
      code: """def maxProfit(prices):
    def profit(day, holding):
        if day >= len(prices):
            return 0

        cooldown = profit(day + 1, holding)

        if holding:
            # Can sell
            sell = prices[day] + profit(day + 2, False)  # Cooldown
            return max(cooldown, sell)
        else:
            # Can buy
            buy = -prices[day] + profit(day + 1, True)
            return max(cooldown, buy)

    return profit(0, False)""",
      timeComplexity: "O(2^n)",
      spaceComplexity: "O(n)",
      explanation: "Recursive solution with states (day, holding stock). Three actions: buy, sell (with cooldown), or do nothing. Overlapping subproblems cause exponential time.",
      steps: [
        "Define recursive function with day and holding state",
        "Base case: day >= len(prices), return 0",
        "Option 1: cooldown (do nothing), move to next day",
        "If holding stock:",
        "  - Option 2: sell today, skip next day (cooldown), recurse day+2",
        "  - Return max of cooldown and sell",
        "If not holding:",
        "  - Option 2: buy today, recurse with holding=True",
        "  - Return max of cooldown and buy",
        "Note: Many overlapping (day, holding) states"
      ],
    ),
    optimized: Solution(
      code: """def maxProfit(prices):
    if not prices:
        return 0

    n = len(prices)
    # State: [day][0=not holding, 1=holding]
    hold = -prices[0]
    sold = 0
    cooldown = 0

    for i in range(1, n):
        prev_hold = hold
        prev_sold = sold

        hold = max(prev_hold, cooldown - prices[i])
        sold = prev_hold + prices[i]
        cooldown = max(prev_sold, cooldown)

    return max(sold, cooldown)""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "State machine DP. Track three states: holding, just sold (must cooldown), ready to buy (cooled down). Transitions between states based on actions.",
      steps: [
        "Initialize three states:",
        "  - hold: max profit when holding stock",
        "  - sold: max profit just after selling (in cooldown)",
        "  - cooldown: max profit when can buy again",
        "For each day:",
        "  - Update hold: max(keep holding, buy from cooldown state)",
        "  - Update sold: sell from hold state",
        "  - Update cooldown: max(stay in cooldown, was in sold yesterday)",
        "Return max of sold or cooldown (can't end while holding)",
        "Key: State machine with three states, O(1) space"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 518,
    title: "Coin Change II",
    difficulty: Difficulty.medium,
    category: "2-D DP",
    question: """You are given an integer array coins representing coins of different denominations and an integer amount representing a total amount of money.

Return the number of combinations that make up that amount. If that amount of money cannot be made up by any combination of the coins, return 0.

You may assume that you have an infinite number of each kind of coin.

The answer is guaranteed to fit into a signed 32-bit integer.

Example 1:
Input: amount = 5, coins = [1,2,5]
Output: 4
Explanation: there are four ways to make up the amount:
5=5
5=2+2+1
5=2+1+1+1
5=1+1+1+1+1

Example 2:
Input: amount = 3, coins = [2]
Output: 0
Explanation: the amount of 3 cannot be made up just with coins of 2.

Example 3:
Input: amount = 10, coins = [10]
Output: 1

Constraints:
• 1 <= coins.length <= 300
• 1 <= coins[i] <= 5000
• All the values of coins are unique.
• 0 <= amount <= 5000""",
    bruteForce: Solution(
      code: """def change(amount, coins):
    def countWays(remaining, index):
        if remaining == 0:
            return 1
        if remaining < 0 or index >= len(coins):
            return 0

        # Use current coin
        use = countWays(remaining - coins[index], index)

        # Skip current coin
        skip = countWays(remaining, index + 1)

        return use + skip

    return countWays(amount, 0)""",
      timeComplexity: "O(2^n) where n is number of coins",
      spaceComplexity: "O(amount)",
      explanation: "Recursive solution trying to use or skip each coin. Can reuse same coin (unbounded knapsack). Overlapping subproblems cause exponential time.",
      steps: [
        "Define recursive function with remaining amount and coin index",
        "Base case: remaining == 0, found one way",
        "Base case: remaining < 0 or no coins left, return 0",
        "Option 1: use current coin, stay at same index (can reuse)",
        "Option 2: skip current coin, move to next",
        "Return sum of both options",
        "Note: Recalculates same (remaining, index) states"
      ],
    ),
    optimized: Solution(
      code: """def change(amount, coins):
    dp = [0] * (amount + 1)
    dp[0] = 1  # One way to make 0: use no coins

    for coin in coins:
        for i in range(coin, amount + 1):
            dp[i] += dp[i - coin]

    return dp[amount]""",
      timeComplexity: "O(amount * coins)",
      spaceComplexity: "O(amount)",
      explanation: "1D DP optimized from 2D. For each coin, update all amounts that can be formed. Process coins one at a time to avoid counting duplicate combinations.",
      steps: [
        "Create DP array of size amount + 1",
        "Base case: dp[0] = 1 (one way to make 0)",
        "For each coin:",
        "  - For each amount from coin to target:",
        "    - Add ways to make (amount - coin) to dp[amount]",
        "    - dp[i] += dp[i - coin]",
        "Return dp[amount]",
        "Key: Processing coins in outer loop avoids duplicate combinations",
        "E.g., (1,2) and (2,1) counted as same combination"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 494,
    title: "Target Sum",
    difficulty: Difficulty.medium,
    category: "2-D DP",
    question: """You are given an integer array nums and an integer target.

You want to build an expression out of nums by adding one of the symbols '+' and '-' before each integer in nums and then concatenate all the integers.

For example, if nums = [2, 1], you can add a '+' before 2 and a '-' before 1 and concatenate them to build the expression "+2-1".

Return the number of different expressions that you can build, which evaluates to target.

Example 1:
Input: nums = [1,1,1,1,1], target = 3
Output: 5
Explanation: There are 5 ways to assign symbols to make the sum of nums be target 3.
-1 + 1 + 1 + 1 + 1 = 3
+1 - 1 + 1 + 1 + 1 = 3
+1 + 1 - 1 + 1 + 1 = 3
+1 + 1 + 1 - 1 + 1 = 3
+1 + 1 + 1 + 1 - 1 = 3

Example 2:
Input: nums = [1], target = 1
Output: 1

Constraints:
• 1 <= nums.length <= 20
• 0 <= nums[i] <= 1000
• 0 <= sum(nums[i]) <= 1000
• -1000 <= target <= 1000""",
    bruteForce: Solution(
      code: """def findTargetSumWays(nums, target):
    def countWays(index, current_sum):
        if index == len(nums):
            return 1 if current_sum == target else 0

        # Try adding positive
        positive = countWays(index + 1, current_sum + nums[index])

        # Try adding negative
        negative = countWays(index + 1, current_sum - nums[index])

        return positive + negative

    return countWays(0, 0)""",
      timeComplexity: "O(2^n)",
      spaceComplexity: "O(n)",
      explanation: "Recursive solution trying + and - for each number. Two choices per number lead to 2^n total combinations. Overlapping subproblems.",
      steps: [
        "Define recursive function with index and current sum",
        "Base case: processed all numbers, check if sum equals target",
        "For current number, try two options:",
        "  - Add it: recurse with current_sum + nums[index]",
        "  - Subtract it: recurse with current_sum - nums[index]",
        "Return sum of ways from both options",
        "Note: Explores all 2^n combinations"
      ],
    ),
    optimized: Solution(
      code: """def findTargetSumWays(nums, target):
    total = sum(nums)

    # Mathematical insight: P - N = target and P + N = total
    # So P = (target + total) / 2
    if (target + total) % 2 != 0 or abs(target) > total:
        return 0

    subset_sum = (target + total) // 2

    dp = [0] * (subset_sum + 1)
    dp[0] = 1

    for num in nums:
        for j in range(subset_sum, num - 1, -1):
            dp[j] += dp[j - num]

    return dp[subset_sum]""",
      timeComplexity: "O(n * sum)",
      spaceComplexity: "O(sum)",
      explanation: "Transform to subset sum problem. If P=positive subset, N=negative subset, then P-N=target and P+N=total. Solve for P=(target+total)/2. Count subsets summing to P.",
      steps: [
        "Calculate total sum",
        "Mathematical transformation:",
        "  - Let P = sum of positive numbers, N = sum of negative",
        "  - P - N = target, P + N = total",
        "  - Solving: P = (target + total) / 2",
        "Check validity: (target + total) must be even and achievable",
        "Problem becomes: count subsets summing to P",
        "Use subset sum DP (like Partition Equal Subset Sum)",
        "Return dp[subset_sum]",
        "Key: Mathematical insight reduces to subset sum"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 97,
    title: "Interleaving String",
    difficulty: Difficulty.medium,
    category: "2-D DP",
    question: """Given strings s1, s2, and s3, find whether s3 is formed by an interleaving of s1 and s2.

An interleaving of two strings s and t is a configuration where s and t are divided into n and m substrings respectively, such that:
• s = s1 + s2 + ... + sn
• t = t1 + t2 + ... + tm
• |n - m| <= 1
• The interleaving is s1 + t1 + s2 + t2 + s3 + t3 + ... or t1 + s1 + t2 + s2 + t3 + s3 + ...

Note: a + b is the concatenation of strings a and b.

Example 1:
Input: s1 = "aabcc", s2 = "dbbca", s3 = "aadbbcbcac"
Output: true
Explanation: One way to obtain s3 is:
Split s1 into s1 = "aa" + "bc" + "c", and s2 into s2 = "dbbc" + "a".
Interleaving the two splits, we get "aa" + "dbbc" + "bc" + "a" + "c" = "aadbbcbcac".

Example 2:
Input: s1 = "aabcc", s2 = "dbbca", s3 = "aadbbbaccc"
Output: false

Example 3:
Input: s1 = "", s2 = "", s3 = ""
Output: true

Constraints:
• 0 <= s1.length, s2.length <= 100
• 0 <= s3.length <= 200
• s1, s2, and s3 consist of lowercase English letters.""",
    bruteForce: Solution(
      code: """def isInterleave(s1, s2, s3):
    if len(s1) + len(s2) != len(s3):
        return False

    def canForm(i, j, k):
        if k == len(s3):
            return i == len(s1) and j == len(s2)

        use_s1 = False
        if i < len(s1) and s1[i] == s3[k]:
            use_s1 = canForm(i + 1, j, k + 1)

        use_s2 = False
        if j < len(s2) and s2[j] == s3[k]:
            use_s2 = canForm(i, j + 1, k + 1)

        return use_s1 or use_s2

    return canForm(0, 0, 0)""",
      timeComplexity: "O(2^(m+n))",
      spaceComplexity: "O(m + n)",
      explanation: "Recursive solution trying to match s3[k] with either s1[i] or s2[j]. Overlapping subproblems cause exponential time.",
      steps: [
        "Check if lengths add up correctly",
        "Define recursive function with indices i, j, k",
        "Base case: processed all of s3, check if used all of s1 and s2",
        "Try matching s3[k] with s1[i] if characters match",
        "Try matching s3[k] with s2[j] if characters match",
        "Return True if either option works",
        "Note: Many duplicate (i, j, k) states"
      ],
    ),
    optimized: Solution(
      code: """def isInterleave(s1, s2, s3):
    if len(s1) + len(s2) != len(s3):
        return False

    m, n = len(s1), len(s2)
    dp = [[False] * (n + 1) for _ in range(m + 1)]
    dp[0][0] = True

    # Fill first row (using only s2)
    for j in range(1, n + 1):
        dp[0][j] = dp[0][j-1] and s2[j-1] == s3[j-1]

    # Fill first column (using only s1)
    for i in range(1, m + 1):
        dp[i][0] = dp[i-1][0] and s1[i-1] == s3[i-1]

    # Fill rest of table
    for i in range(1, m + 1):
        for j in range(1, n + 1):
            k = i + j - 1
            dp[i][j] = (
                (dp[i-1][j] and s1[i-1] == s3[k]) or
                (dp[i][j-1] and s2[j-1] == s3[k])
            )

    return dp[m][n]""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(m * n)",
      explanation: "2D DP where dp[i][j] = can form s3[0:i+j] from s1[0:i] and s2[0:j]. Build table by checking if can extend from previous states.",
      steps: [
        "Check length constraint",
        "Create (m+1) x (n+1) DP table",
        "Base case: dp[0][0] = True (empty strings)",
        "Fill first row: can form using only s2",
        "Fill first column: can form using only s1",
        "For each cell (i, j):",
        "  - k = i + j - 1 (position in s3)",
        "  - Can reach if:",
        "    - From (i-1, j) and s1[i-1] == s3[k], OR",
        "    - From (i, j-1) and s2[j-1] == s3[k]",
        "Return dp[m][n]"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 329,
    title: "Longest Increasing Path in a Matrix",
    difficulty: Difficulty.hard,
    category: "2-D DP",
    question: """Given an m x n integers matrix, return the length of the longest increasing path in matrix.

From each cell, you can either move in four directions: left, right, up, or down. You may not move diagonally or move outside the boundary (i.e., wrap-around is not allowed).

Example 1:
Input: matrix = [[9,9,4],[6,6,8],[2,1,1]]
Output: 4
Explanation: The longest increasing path is [1, 2, 6, 9].

Example 2:
Input: matrix = [[3,4,5],[3,2,6],[2,2,1]]
Output: 4
Explanation: The longest increasing path is [3, 4, 5, 6]. Moving diagonally is not allowed.

Example 3:
Input: matrix = [[1]]
Output: 1

Constraints:
• m == matrix.length
• n == matrix[i].length
• 1 <= m, n <= 200
• 0 <= matrix[i][j] <= 2³¹ - 1""",
    bruteForce: Solution(
      code: """def longestIncreasingPath(matrix):
    if not matrix:
        return 0

    m, n = len(matrix), len(matrix[0])

    def dfs(i, j):
        max_length = 1

        for di, dj in [(0,1), (0,-1), (1,0), (-1,0)]:
            ni, nj = i + di, j + dj
            if (0 <= ni < m and 0 <= nj < n and
                matrix[ni][nj] > matrix[i][j]):
                max_length = max(max_length, 1 + dfs(ni, nj))

        return max_length

    result = 0
    for i in range(m):
        for j in range(n):
            result = max(result, dfs(i, j))

    return result""",
      timeComplexity: "O(m * n * 4^(m*n)) - very slow",
      spaceComplexity: "O(m * n)",
      explanation: "DFS from each cell exploring all increasing paths. Recalculates paths from same cells repeatedly, causing extreme inefficiency.",
      steps: [
        "For each cell in matrix:",
        "  - Start DFS to find longest increasing path from that cell",
        "DFS explores all 4 directions:",
        "  - Only move to neighbor if value is greater",
        "  - Return 1 + max path from neighbors",
        "Track global maximum",
        "Return maximum path length found",
        "Note: Massive redundant computation"
      ],
    ),
    optimized: Solution(
      code: """def longestIncreasingPath(matrix):
    if not matrix:
        return 0

    m, n = len(matrix), len(matrix[0])
    memo = {}

    def dfs(i, j):
        if (i, j) in memo:
            return memo[(i, j)]

        max_length = 1

        for di, dj in [(0,1), (0,-1), (1,0), (-1,0)]:
            ni, nj = i + di, j + dj
            if (0 <= ni < m and 0 <= nj < n and
                matrix[ni][nj] > matrix[i][j]):
                max_length = max(max_length, 1 + dfs(ni, nj))

        memo[(i, j)] = max_length
        return max_length

    result = 0
    for i in range(m):
        for j in range(n):
            result = max(result, dfs(i, j))

    return result""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(m * n)",
      explanation: "DFS with memoization. Each cell calculated once and cached. The increasing path property ensures no cycles, making memoization effective.",
      steps: [
        "Create memoization dictionary",
        "Define DFS with memoization:",
        "  - If cell already computed, return cached value",
        "  - Try all 4 directions, only move if increasing",
        "  - max_length = 1 + max of paths from valid neighbors",
        "  - Cache result before returning",
        "Run DFS from every cell",
        "Return maximum path length",
        "Key: Memoization reduces O(4^(mn)) to O(mn)"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 115,
    title: "Distinct Subsequences",
    difficulty: Difficulty.hard,
    category: "2-D DP",
    question: """Given two strings s and t, return the number of distinct subsequences of s which equals t.

The test cases are generated so that the answer fits on a 32-bit signed integer.

Example 1:
Input: s = "rabbbit", t = "rabbit"
Output: 3
Explanation:
As shown below, there are 3 ways you can generate "rabbit" from s.
rabb**b**it
rab**b**bit
ra**b**bbit

Example 2:
Input: s = "babgbag", t = "bag"
Output: 5
Explanation:
As shown below, there are 5 ways you can generate "bag" from s.
**ba**g**b**bag
**ba**gbba**g**
**b**abgb**ag**
ba**b**g**bag**
babg**bag**

Constraints:
• 1 <= s.length, t.length <= 1000
• s and t consist of English letters.""",
    bruteForce: Solution(
      code: """def numDistinct(s, t):
    def countWays(i, j):
        if j == len(t):
            return 1
        if i == len(s):
            return 0

        ways = 0

        # Skip current character in s
        ways += countWays(i + 1, j)

        # Match current characters
        if s[i] == t[j]:
            ways += countWays(i + 1, j + 1)

        return ways

    return countWays(0, 0)""",
      timeComplexity: "O(2^m) where m is len(s)",
      spaceComplexity: "O(m)",
      explanation: "Recursive solution. For each character in s, try skipping it or matching it with t. Overlapping subproblems cause exponential time.",
      steps: [
        "Define recursive function with indices i (s) and j (t)",
        "Base case: matched all of t (j == len(t)), return 1",
        "Base case: exhausted s but not t, return 0",
        "Option 1: skip s[i], recurse with i+1, j",
        "Option 2: if s[i] == t[j], match them, recurse i+1, j+1",
        "Return sum of both options",
        "Note: Recalculates same (i, j) states"
      ],
    ),
    optimized: Solution(
      code: """def numDistinct(s, t):
    m, n = len(s), len(t)
    dp = [[0] * (n + 1) for _ in range(m + 1)]

    # Base case: empty t can be formed in one way
    for i in range(m + 1):
        dp[i][0] = 1

    for i in range(1, m + 1):
        for j in range(1, n + 1):
            # Skip s[i-1]
            dp[i][j] = dp[i-1][j]

            # Match s[i-1] with t[j-1]
            if s[i-1] == t[j-1]:
                dp[i][j] += dp[i-1][j-1]

    return dp[m][n]""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(m * n)",
      explanation: "2D DP where dp[i][j] = number of ways to form t[0:j] from s[0:i]. Build table considering skipping or matching characters.",
      steps: [
        "Create (m+1) x (n+1) DP table",
        "Base case: dp[i][0] = 1 for all i (empty t matched one way)",
        "For each position (i, j):",
        "  - Can always skip s[i-1]: dp[i][j] = dp[i-1][j]",
        "  - If s[i-1] == t[j-1], can also match:",
        "    - Add dp[i-1][j-1] to dp[i][j]",
        "Return dp[m][n]",
        "Key: Accumulate ways from both skip and match options"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 72,
    title: "Edit Distance",
    difficulty: Difficulty.hard,
    category: "2-D DP",
    question: """Given two strings word1 and word2, return the minimum number of operations required to convert word1 to word2.

You have the following three operations permitted on a word:
• Insert a character
• Delete a character
• Replace a character

Example 1:
Input: word1 = "horse", word2 = "ros"
Output: 3
Explanation:
horse -> rorse (replace 'h' with 'r')
rorse -> rose (remove 'r')
rose -> ros (remove 'e')

Example 2:
Input: word1 = "intention", word2 = "execution"
Output: 5
Explanation:
intention -> inention (remove 't')
inention -> enention (replace 'i' with 'e')
enention -> exention (replace 'n' with 'x')
exention -> exection (replace 'n' with 'c')
exection -> execution (insert 'u')

Constraints:
• 0 <= word1.length, word2.length <= 500
• word1 and word2 consist of lowercase English letters.""",
    bruteForce: Solution(
      code: """def minDistance(word1, word2):
    def minOps(i, j):
        if i == len(word1):
            return len(word2) - j  # Insert remaining
        if j == len(word2):
            return len(word1) - i  # Delete remaining

        if word1[i] == word2[j]:
            return minOps(i + 1, j + 1)  # No operation needed

        # Try all three operations
        insert = 1 + minOps(i, j + 1)
        delete = 1 + minOps(i + 1, j)
        replace = 1 + minOps(i + 1, j + 1)

        return min(insert, delete, replace)

    return minOps(0, 0)""",
      timeComplexity: "O(3^(m+n))",
      spaceComplexity: "O(m + n)",
      explanation: "Recursive solution trying all three operations. Overlapping subproblems cause exponential time complexity.",
      steps: [
        "Define recursive function with indices i, j",
        "Base case: reached end of word1, insert remaining chars from word2",
        "Base case: reached end of word2, delete remaining chars from word1",
        "If characters match, no operation needed, recurse both",
        "Otherwise, try all three operations:",
        "  - Insert: assume inserted char from word2, advance j",
        "  - Delete: remove char from word1, advance i",
        "  - Replace: replace word1[i] with word2[j], advance both",
        "Return 1 + minimum of three options"
      ],
    ),
    optimized: Solution(
      code: """def minDistance(word1, word2):
    m, n = len(word1), len(word2)
    dp = [[0] * (n + 1) for _ in range(m + 1)]

    # Base cases
    for i in range(m + 1):
        dp[i][0] = i  # Delete all chars from word1
    for j in range(n + 1):
        dp[0][j] = j  # Insert all chars from word2

    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if word1[i-1] == word2[j-1]:
                dp[i][j] = dp[i-1][j-1]
            else:
                dp[i][j] = 1 + min(
                    dp[i-1][j],    # Delete
                    dp[i][j-1],    # Insert
                    dp[i-1][j-1]   # Replace
                )

    return dp[m][n]""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(m * n)",
      explanation: "Classic 2D DP. dp[i][j] = min operations to convert word1[0:i] to word2[0:j]. Build table considering all three operations.",
      steps: [
        "Create (m+1) x (n+1) DP table",
        "Base cases:",
        "  - dp[i][0] = i (delete all i characters)",
        "  - dp[0][j] = j (insert all j characters)",
        "For each cell (i, j):",
        "  - If characters match: dp[i][j] = dp[i-1][j-1] (no op)",
        "  - Otherwise: 1 + min of:",
        "    - dp[i-1][j] (delete from word1)",
        "    - dp[i][j-1] (insert into word1)",
        "    - dp[i-1][j-1] (replace)",
        "Return dp[m][n]",
        "Key: Classic Levenshtein distance algorithm"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 312,
    title: "Burst Balloons",
    difficulty: Difficulty.hard,
    category: "2-D DP",
    question: """You are given n balloons, indexed from 0 to n - 1. Each balloon is painted with a number on it represented by an array nums. You are asked to burst all the balloons.

If you burst the ith balloon, you will get nums[i - 1] * nums[i] * nums[i + 1] coins. If i - 1 or i + 1 goes out of bounds of the array, then treat it as if there is a balloon with a 1 painted on it.

Return the maximum coins you can collect by bursting the balloons wisely.

Example 1:
Input: nums = [3,1,5,8]
Output: 167
Explanation:
nums = [3,1,5,8] --> [3,5,8] --> [3,8] --> [8] --> []
coins =  3*1*5    +   3*5*8   +  1*3*8  + 1*8*1 = 167

Example 2:
Input: nums = [1,5]
Output: 10

Constraints:
• n == nums.length
• 1 <= n <= 300
• 0 <= nums[i] <= 100""",
    bruteForce: Solution(
      code: """def maxCoins(nums):
    def maxCoinsHelper(arr):
        if not arr:
            return 0

        max_coins = 0

        for i in range(len(arr)):
            left = arr[i-1] if i > 0 else 1
            right = arr[i+1] if i < len(arr) - 1 else 1

            coins = left * arr[i] * right
            remaining = arr[:i] + arr[i+1:]

            max_coins = max(max_coins, coins + maxCoinsHelper(remaining))

        return max_coins

    return maxCoinsHelper(nums)""",
      timeComplexity: "O(n!)",
      spaceComplexity: "O(n)",
      explanation: "Try bursting each balloon, recursively solve remaining. Creates new arrays for each state, factorial time complexity.",
      steps: [
        "Base case: no balloons left, return 0",
        "Try bursting each balloon i:",
        "  - Calculate coins: left * nums[i] * right",
        "  - Create array without balloon i",
        "  - Recursively calculate max for remaining balloons",
        "  - Track maximum total coins",
        "Return maximum",
        "Note: n! permutations, extremely slow"
      ],
    ),
    optimized: Solution(
      code: """def maxCoins(nums):
    # Add boundary balloons with value 1
    nums = [1] + nums + [1]
    n = len(nums)
    dp = [[0] * n for _ in range(n)]

    # Length of subarray
    for length in range(2, n):
        for left in range(n - length):
            right = left + length
            # Try bursting each balloon in (left, right) last
            for i in range(left + 1, right):
                coins = nums[left] * nums[i] * nums[right]
                coins += dp[left][i] + dp[i][right]
                dp[left][right] = max(dp[left][right], coins)

    return dp[0][n-1]""",
      timeComplexity: "O(n³)",
      spaceComplexity: "O(n²)",
      explanation: "Think backwards: which balloon to burst LAST in range [left, right]. Add boundary balloons. dp[left][right] = max coins bursting balloons between left and right.",
      steps: [
        "Add boundary balloons with value 1 on both ends",
        "Create n x n DP table",
        "Iterate by subarray length from 2 to n-1:",
        "  - For each left boundary:",
        "    - Calculate right = left + length",
        "    - Try bursting each balloon i in (left, right) LAST:",
        "      - Coins = nums[left] * nums[i] * nums[right]",
        "      - Add coins from left and right subarrays",
        "      - Update dp[left][right] with maximum",
        "Return dp[0][n-1]",
        "Key: Clever reversal - think which balloon to burst last"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 10,
    title: "Regular Expression Matching",
    difficulty: Difficulty.hard,
    category: "2-D DP",
    question: """Given an input string s and a pattern p, implement regular expression matching with support for '.' and '*' where:
• '.' Matches any single character.
• '*' Matches zero or more of the preceding element.

The matching should cover the entire input string (not partial).

Example 1:
Input: s = "aa", p = "a"
Output: false
Explanation: "a" does not match the entire string "aa".

Example 2:
Input: s = "aa", p = "a*"
Output: true
Explanation: '*' means zero or more of the preceding element, 'a'. Therefore, by repeating 'a' once, it becomes "aa".

Example 3:
Input: s = "ab", p = ".*"
Output: true
Explanation: ".*" means "zero or more (*) of any character (.)".

Constraints:
• 1 <= s.length <= 20
• 1 <= p.length <= 30
• s contains only lowercase English letters.
• p contains only lowercase English letters, '.', and '*'.
• It is guaranteed for each appearance of the character '*', there will be a previous valid character to match.""",
    bruteForce: Solution(
      code: """def isMatch(s, p):
    def matchHelper(i, j):
        # Base case: both exhausted
        if j == len(p):
            return i == len(s)

        # Check if current characters match
        first_match = i < len(s) and (p[j] == s[i] or p[j] == '.')

        # Handle '*'
        if j + 1 < len(p) and p[j + 1] == '*':
            # Try using '*' zero times or one+ times
            return (matchHelper(i, j + 2) or  # Zero times
                    (first_match and matchHelper(i + 1, j)))  # One+ times
        else:
            # No '*', must match current
            return first_match and matchHelper(i + 1, j + 1)

    return matchHelper(0, 0)""",
      timeComplexity: "O(2^(m+n))",
      spaceComplexity: "O(m + n)",
      explanation: "Recursive solution handling '.' and '*'. For '*', try using it zero or more times. Overlapping subproblems cause exponential time.",
      steps: [
        "Define recursive function with indices i (s) and j (p)",
        "Base case: reached end of pattern, check if end of string too",
        "Check if current chars match (equal or pattern has '.')",
        "If next char in pattern is '*':",
        "  - Option 1: use '*' zero times, skip pattern char + '*'",
        "  - Option 2: if first_match, use '*' one+ times, advance string",
        "  - Return True if either option works",
        "Otherwise: must match current, advance both pointers",
        "Note: Recalculates same (i, j) states"
      ],
    ),
    optimized: Solution(
      code: """def isMatch(s, p):
    m, n = len(s), len(p)
    dp = [[False] * (n + 1) for _ in range(m + 1)]

    # Base case: empty string and pattern
    dp[0][0] = True

    # Handle patterns like a*, a*b*, etc. matching empty string
    for j in range(2, n + 1):
        if p[j-1] == '*':
            dp[0][j] = dp[0][j-2]

    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if p[j-1] == '*':
                # Use '*' zero times
                dp[i][j] = dp[i][j-2]

                # Use '*' one or more times
                if p[j-2] == s[i-1] or p[j-2] == '.':
                    dp[i][j] = dp[i][j] or dp[i-1][j]
            elif p[j-1] == '.' or p[j-1] == s[i-1]:
                # Characters match
                dp[i][j] = dp[i-1][j-1]

    return dp[m][n]""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(m * n)",
      explanation: "2D DP where dp[i][j] = does s[0:i] match p[0:j]. Handle '*' by trying zero or more occurrences. Handle '.' by treating as match.",
      steps: [
        "Create (m+1) x (n+1) DP table",
        "Base case: dp[0][0] = True (both empty)",
        "Initialize first row: patterns like 'a*b*' can match empty string",
        "For each cell (i, j):",
        "  - If p[j-1] is '*':",
        "    - Try zero occurrences: dp[i][j-2]",
        "    - If preceding char matches, try one+ times: dp[i-1][j]",
        "  - If p[j-1] is '.' or matches s[i-1]:",
        "    - dp[i][j] = dp[i-1][j-1]",
        "Return dp[m][n]",
        "Key: Complex but classic 2D DP problem"
      ],
    ),
  ),

];
