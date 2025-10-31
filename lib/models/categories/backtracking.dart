import '../leetcode_question.dart';

// NeetCode 150 - Backtracking Category
// 9 questions with complete solutions

final List<LeetCodeQuestion> backtrackingQuestions = [

  LeetCodeQuestion(
    id: 78,
    title: "Subsets",
    difficulty: Difficulty.medium,
    category: "Backtracking",
    question: """Given an integer array nums of unique elements, return all possible subsets (the power set).

The solution set must not contain duplicate subsets. Return the solution in any order.

Example 1:
Input: nums = [1,2,3]
Output: [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]

Example 2:
Input: nums = [0]
Output: [[],[0]]

Constraints:
• 1 <= nums.length <= 10
• -10 <= nums[i] <= 10
• All the numbers of nums are unique.""",
    bruteForce: Solution(
      code: """def subsets(nums):
    result = []
    n = len(nums)

    # Generate all 2^n combinations using bit manipulation
    for i in range(2 ** n):
        subset = []
        for j in range(n):
            # Check if jth bit is set
            if i & (1 << j):
                subset.append(nums[j])
        result.append(subset)

    return result""",
      timeComplexity: "O(n * 2^n)",
      spaceComplexity: "O(n * 2^n)",
      explanation: "Use bit manipulation to generate all 2^n subsets. For each number from 0 to 2^n-1, use its binary representation to determine which elements to include.",
      steps: [
        "Initialize empty result list",
        "Get length n of nums array",
        "Iterate i from 0 to 2^n - 1:",
        "  - Create empty subset",
        "  - For each bit position j from 0 to n-1:",
        "    - If jth bit is set in i, include nums[j]",
        "  - Add subset to result",
        "Return result",
        "Note: Works but less intuitive than backtracking"
      ],
    ),
    optimized: Solution(
      code: """def subsets(nums):
    result = []

    def backtrack(start, current):
        # Add current subset to result
        result.append(current[:])

        # Try adding each remaining element
        for i in range(start, len(nums)):
            current.append(nums[i])
            backtrack(i + 1, current)
            current.pop()  # Backtrack

    backtrack(0, [])
    return result""",
      timeComplexity: "O(n * 2^n)",
      spaceComplexity: "O(n) - recursion depth",
      explanation: "Use backtracking to build subsets incrementally. For each element, make two choices: include it or skip it. Add current subset at each step.",
      steps: [
        "Initialize empty result list",
        "Define backtrack function with start index and current subset",
        "Add copy of current subset to result (every path is valid)",
        "For each index from start to end:",
        "  - Add nums[i] to current subset",
        "  - Recursively explore with i+1 as new start",
        "  - Remove nums[i] (backtrack)",
        "Start backtracking from index 0 with empty subset",
        "Return result",
        "Key: Include subset at each node, not just leaves"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 39,
    title: "Combination Sum",
    difficulty: Difficulty.medium,
    category: "Backtracking",
    question: """Given an array of distinct integers candidates and a target integer target, return a list of all unique combinations of candidates where the chosen numbers sum to target. You may return the combinations in any order.

The same number may be chosen from candidates an unlimited number of times. Two combinations are unique if the frequency of at least one of the chosen numbers is different.

The test cases are generated such that the number of unique combinations that sum up to target is less than 150 combinations for the given input.

Example 1:
Input: candidates = [2,3,6,7], target = 7
Output: [[2,2,3],[7]]
Explanation:
2 and 3 are candidates, and 2 + 2 + 3 = 7. Note that 2 can be used multiple times.
7 is a candidate, and 7 = 7.
These are the only two combinations.

Example 2:
Input: candidates = [2,3,5], target = 8
Output: [[2,2,2,2],[2,3,3],[3,5]]

Example 3:
Input: candidates = [2], target = 1
Output: []

Constraints:
• 1 <= candidates.length <= 30
• 2 <= candidates[i] <= 40
• All elements of candidates are distinct.
• 1 <= target <= 40""",
    bruteForce: Solution(
      code: """def combinationSum(candidates, target):
    result = []

    def backtrack(current, remaining, index):
        if remaining == 0:
            result.append(current[:])
            return

        if remaining < 0:
            return

        # Try all candidates starting from index
        for i in range(index, len(candidates)):
            current.append(candidates[i])
            # Can reuse same element, so pass i not i+1
            backtrack(current, remaining - candidates[i], i)
            current.pop()

    backtrack([], target, 0)
    return result""",
      timeComplexity: "O(n^(T/M)) - T target, M min candidate",
      spaceComplexity: "O(T/M) - recursion depth",
      explanation: "Try all combinations using backtracking. For each candidate, try using it multiple times by allowing same index in recursion. Prune when sum exceeds target.",
      steps: [
        "Initialize empty result list",
        "Define backtrack with current combo, remaining sum, start index",
        "Base case: if remaining == 0, found valid combination",
        "Pruning: if remaining < 0, invalid path - return",
        "For each candidate from index onwards:",
        "  - Add candidate to current",
        "  - Recurse with same index i (can reuse element)",
        "  - Subtract candidate from remaining",
        "  - Backtrack by removing candidate",
        "Start with empty list, target sum, index 0",
        "Return result"
      ],
    ),
    optimized: Solution(
      code: """def combinationSum(candidates, target):
    result = []
    candidates.sort()  # Optional: helps with early pruning

    def backtrack(start, current, remaining):
        if remaining == 0:
            result.append(current[:])
            return

        for i in range(start, len(candidates)):
            if candidates[i] > remaining:
                break  # Early termination (if sorted)

            current.append(candidates[i])
            backtrack(i, current, remaining - candidates[i])
            current.pop()

    backtrack(0, [], target)
    return result""",
      timeComplexity: "O(n^(T/M))",
      spaceComplexity: "O(T/M)",
      explanation: "Same backtracking approach but with optimization: sort candidates first to enable early termination when candidate exceeds remaining sum.",
      steps: [
        "Sort candidates (optional but helps pruning)",
        "Initialize empty result",
        "Define backtrack with start, current, remaining",
        "Base case: if remaining == 0, add to result",
        "For each candidate from start:",
        "  - If candidate > remaining, break (no point continuing)",
        "  - Add candidate to current",
        "  - Recurse from same index (can reuse)",
        "  - Backtrack",
        "Start backtracking",
        "Return result",
        "Key: Sorted array enables early break"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 46,
    title: "Permutations",
    difficulty: Difficulty.medium,
    category: "Backtracking",
    question: """Given an array nums of distinct integers, return all the possible permutations. You can return the answer in any order.

Example 1:
Input: nums = [1,2,3]
Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]

Example 2:
Input: nums = [0,1]
Output: [[0,1],[1,0]]

Example 3:
Input: nums = [1]
Output: [[1]]

Constraints:
• 1 <= nums.length <= 6
• -10 <= nums[i] <= 10
• All the integers of nums are unique.""",
    bruteForce: Solution(
      code: """def permute(nums):
    from itertools import permutations
    return [list(p) for p in permutations(nums)]""",
      timeComplexity: "O(n! * n)",
      spaceComplexity: "O(n!)",
      explanation: "Use Python's itertools.permutations which generates all permutations. Simple but doesn't demonstrate understanding of backtracking.",
      steps: [
        "Import permutations from itertools",
        "Call permutations(nums) to get all permutations",
        "Convert each tuple to list",
        "Return result",
        "Note: Uses library function, doesn't show algorithm understanding"
      ],
    ),
    optimized: Solution(
      code: """def permute(nums):
    result = []

    def backtrack(current, remaining):
        if not remaining:
            result.append(current[:])
            return

        for i in range(len(remaining)):
            # Choose element at index i
            current.append(remaining[i])
            # Recurse with remaining elements (excluding i)
            backtrack(current, remaining[:i] + remaining[i+1:])
            # Backtrack
            current.pop()

    backtrack([], nums)
    return result""",
      timeComplexity: "O(n! * n)",
      spaceComplexity: "O(n!) - output size",
      explanation: "Use backtracking to build permutations. At each step, try each unused element, recurse with remaining elements, then backtrack.",
      steps: [
        "Initialize empty result",
        "Define backtrack with current permutation and remaining elements",
        "Base case: if no remaining elements, add current to result",
        "For each element in remaining:",
        "  - Add element to current",
        "  - Recurse with remaining minus this element",
        "  - Remove element (backtrack)",
        "Start with empty current and all nums as remaining",
        "Return result",
        "Key: Build permutations by choosing from remaining elements"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 90,
    title: "Subsets II",
    difficulty: Difficulty.medium,
    category: "Backtracking",
    question: """Given an integer array nums that may contain duplicates, return all possible subsets (the power set).

The solution set must not contain duplicate subsets. Return the solution in any order.

Example 1:
Input: nums = [1,2,2]
Output: [[],[1],[1,2],[1,2,2],[2],[2,2]]

Example 2:
Input: nums = [0]
Output: [[],[0]]

Constraints:
• 1 <= nums.length <= 10
• -10 <= nums[i] <= 10""",
    bruteForce: Solution(
      code: """def subsetsWithDup(nums):
    result = []

    def backtrack(start, current):
        result.append(current[:])

        for i in range(start, len(nums)):
            current.append(nums[i])
            backtrack(i + 1, current)
            current.pop()

    backtrack(0, [])

    # Remove duplicates by converting to set of tuples
    unique = []
    seen = set()
    for subset in result:
        subset_sorted = tuple(sorted(subset))
        if subset_sorted not in seen:
            seen.add(subset_sorted)
            unique.append(subset)

    return unique""",
      timeComplexity: "O(n * 2^n)",
      spaceComplexity: "O(n * 2^n)",
      explanation: "Generate all subsets like regular Subsets problem, then remove duplicates by converting to sorted tuples and using a set. Inefficient due to duplicate generation.",
      steps: [
        "Generate all subsets using backtracking",
        "Create set to track seen subsets",
        "For each subset:",
        "  - Sort it and convert to tuple",
        "  - If not seen before, add to unique list",
        "  - Add to seen set",
        "Return unique list",
        "Note: Generates duplicates then filters them out"
      ],
    ),
    optimized: Solution(
      code: """def subsetsWithDup(nums):
    result = []
    nums.sort()  # Sort to group duplicates

    def backtrack(start, current):
        result.append(current[:])

        for i in range(start, len(nums)):
            # Skip duplicates: if same as previous and we didn't use previous
            if i > start and nums[i] == nums[i - 1]:
                continue

            current.append(nums[i])
            backtrack(i + 1, current)
            current.pop()

    backtrack(0, [])
    return result""",
      timeComplexity: "O(n * 2^n)",
      spaceComplexity: "O(n) - recursion depth",
      explanation: "Sort array first to group duplicates. During backtracking, skip duplicate elements at the same recursion level to avoid generating duplicate subsets.",
      steps: [
        "Sort nums array to group duplicates together",
        "Initialize empty result",
        "Define backtrack with start and current subset",
        "Add current subset to result",
        "For each index from start:",
        "  - Skip if duplicate at same level: i > start and nums[i] == nums[i-1]",
        "  - Add nums[i] to current",
        "  - Recurse with i+1",
        "  - Backtrack",
        "Start from index 0",
        "Return result",
        "Key: Sorting + skip duplicates at same level prevents duplicate subsets"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 40,
    title: "Combination Sum II",
    difficulty: Difficulty.medium,
    category: "Backtracking",
    question: """Given a collection of candidate numbers (candidates) and a target number (target), find all unique combinations in candidates where the candidate numbers sum to target.

Each number in candidates may only be used once in the combination.

Note: The solution set must not contain duplicate combinations.

Example 1:
Input: candidates = [10,1,2,7,6,1,5], target = 8
Output: [[1,1,6],[1,2,5],[1,7],[2,6]]

Example 2:
Input: candidates = [2,5,2,1,2], target = 5
Output: [[1,2,2],[5]]

Constraints:
• 1 <= candidates.length <= 100
• 1 <= candidates[i] <= 50
• 1 <= target <= 30""",
    bruteForce: Solution(
      code: """def combinationSum2(candidates, target):
    result = []

    def backtrack(start, current, remaining):
        if remaining == 0:
            result.append(current[:])
            return

        if remaining < 0:
            return

        for i in range(start, len(candidates)):
            current.append(candidates[i])
            backtrack(i + 1, current, remaining - candidates[i])
            current.pop()

    backtrack(0, [], target)

    # Remove duplicates
    unique = []
    seen = set()
    for combo in result:
        combo_sorted = tuple(sorted(combo))
        if combo_sorted not in seen:
            seen.add(combo_sorted)
            unique.append(combo)

    return unique""",
      timeComplexity: "O(2^n * n)",
      spaceComplexity: "O(n)",
      explanation: "Generate all combinations then filter duplicates. Inefficient as it creates duplicates before removing them.",
      steps: [
        "Use backtracking to generate all combinations",
        "Each element used at most once (i+1 in recursion)",
        "Collect all combinations",
        "Remove duplicates using set of sorted tuples",
        "Return unique combinations",
        "Note: Generates duplicates unnecessarily"
      ],
    ),
    optimized: Solution(
      code: """def combinationSum2(candidates, target):
    result = []
    candidates.sort()

    def backtrack(start, current, remaining):
        if remaining == 0:
            result.append(current[:])
            return

        for i in range(start, len(candidates)):
            if candidates[i] > remaining:
                break

            # Skip duplicates at same level
            if i > start and candidates[i] == candidates[i - 1]:
                continue

            current.append(candidates[i])
            backtrack(i + 1, current, remaining - candidates[i])
            current.pop()

    backtrack(0, [], target)
    return result""",
      timeComplexity: "O(2^n)",
      spaceComplexity: "O(n)",
      explanation: "Sort array and skip duplicates at same recursion level. Each element used once (i+1, not i). Early termination when candidate exceeds remaining.",
      steps: [
        "Sort candidates to enable duplicate skipping and pruning",
        "Initialize empty result",
        "Define backtrack with start, current, remaining",
        "Base case: remaining == 0, add to result",
        "For each candidate from start:",
        "  - Break if candidate > remaining (pruning)",
        "  - Skip if duplicate at same level",
        "  - Add candidate, recurse with i+1 (not i), backtrack",
        "Return result",
        "Key: Sort + skip duplicates + use each element once"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 79,
    title: "Word Search",
    difficulty: Difficulty.medium,
    category: "Backtracking",
    question: """Given an m x n grid of characters board and a string word, return true if word exists in the grid.

The word can be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once.

Example 1:
Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCCED"
Output: true

Example 2:
Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "SEE"
Output: true

Example 3:
Input: board = [["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], word = "ABCB"
Output: false

Constraints:
• m == board.length
• n = board[i].length
• 1 <= m, n <= 6
• 1 <= word.length <= 15
• board and word consists of only lowercase and uppercase English letters.""",
    bruteForce: Solution(
      code: """def exist(board, word):
    def dfs(i, j, index, visited):
        if index == len(word):
            return True

        if (i < 0 or i >= len(board) or j < 0 or j >= len(board[0]) or
            (i, j) in visited or board[i][j] != word[index]):
            return False

        visited.add((i, j))

        # Try all 4 directions
        found = (dfs(i+1, j, index+1, visited) or
                 dfs(i-1, j, index+1, visited) or
                 dfs(i, j+1, index+1, visited) or
                 dfs(i, j-1, index+1, visited))

        visited.remove((i, j))
        return found

    for i in range(len(board)):
        for j in range(len(board[0])):
            if dfs(i, j, 0, set()):
                return True

    return False""",
      timeComplexity: "O(m * n * 4^L) - L is word length",
      spaceComplexity: "O(L)",
      explanation: "Try DFS from each cell. Use visited set to track path. Try all 4 directions recursively. Works but uses extra space for visited set.",
      steps: [
        "Define DFS with position, word index, visited set",
        "Base cases: found complete word, or invalid position/character",
        "Mark current cell as visited",
        "Try all 4 directions recursively",
        "Unmark cell (backtrack)",
        "Try starting from each cell in board",
        "Return true if any starting position succeeds",
        "Note: Uses O(L) space for visited set"
      ],
    ),
    optimized: Solution(
      code: """def exist(board, word):
    m, n = len(board), len(board[0])

    def dfs(i, j, index):
        if index == len(word):
            return True

        if i < 0 or i >= m or j < 0 or j >= n or board[i][j] != word[index]:
            return False

        # Mark as visited by modifying board
        temp = board[i][j]
        board[i][j] = '#'

        # Try all 4 directions
        found = (dfs(i+1, j, index+1) or
                 dfs(i-1, j, index+1) or
                 dfs(i, j+1, index+1) or
                 dfs(i, j-1, index+1))

        # Restore cell
        board[i][j] = temp

        return found

    for i in range(m):
        for j in range(n):
            if dfs(i, j, 0):
                return True

    return False""",
      timeComplexity: "O(m * n * 4^L)",
      spaceComplexity: "O(L) - recursion only",
      explanation: "Same DFS approach but optimize space by marking visited cells in-place using '#', then restoring after exploration. No need for separate visited set.",
      steps: [
        "Get board dimensions m and n",
        "Define DFS with position i, j and word index",
        "Base case: if index == len(word), found complete word",
        "Check bounds and character match",
        "Mark current cell as visited: board[i][j] = '#'",
        "Try all 4 directions recursively",
        "Restore original character (backtrack)",
        "Try starting from each cell",
        "Return true if any path succeeds",
        "Key: In-place marking saves space, O(L) for recursion only"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 131,
    title: "Palindrome Partitioning",
    difficulty: Difficulty.medium,
    category: "Backtracking",
    question: """Given a string s, partition s such that every substring of the partition is a palindrome. Return all possible palindrome partitioning of s.

Example 1:
Input: s = "aab"
Output: [["a","a","b"],["aa","b"]]

Example 2:
Input: s = "a"
Output: [["a"]]

Constraints:
• 1 <= s.length <= 16
• s contains only lowercase English letters.""",
    bruteForce: Solution(
      code: """def partition(s):
    def isPalindrome(string):
        return string == string[::-1]

    result = []

    def backtrack(start, current):
        if start == len(s):
            result.append(current[:])
            return

        for end in range(start + 1, len(s) + 1):
            substring = s[start:end]
            if isPalindrome(substring):
                current.append(substring)
                backtrack(end, current)
                current.pop()

    backtrack(0, [])
    return result""",
      timeComplexity: "O(n * 2^n)",
      spaceComplexity: "O(n)",
      explanation: "Try all possible partitions using backtracking. For each position, try all possible end positions and check if substring is palindrome. Simple but rechecks palindromes.",
      steps: [
        "Define isPalindrome helper to check if string is palindrome",
        "Initialize empty result",
        "Define backtrack with start index and current partition",
        "Base case: if start == len(s), add partition to result",
        "For each possible end position from start+1 to len(s):",
        "  - Get substring s[start:end]",
        "  - If palindrome, add to current and recurse from end",
        "  - Backtrack",
        "Start from index 0",
        "Return result"
      ],
    ),
    optimized: Solution(
      code: """def partition(s):
    n = len(s)
    # Precompute palindrome check using DP
    is_palindrome = [[False] * n for _ in range(n)]

    for i in range(n):
        is_palindrome[i][i] = True

    for length in range(2, n + 1):
        for i in range(n - length + 1):
            j = i + length - 1
            if s[i] == s[j]:
                if length == 2:
                    is_palindrome[i][j] = True
                else:
                    is_palindrome[i][j] = is_palindrome[i + 1][j - 1]

    result = []

    def backtrack(start, current):
        if start == n:
            result.append(current[:])
            return

        for end in range(start, n):
            if is_palindrome[start][end]:
                current.append(s[start:end + 1])
                backtrack(end + 1, current)
                current.pop()

    backtrack(0, [])
    return result""",
      timeComplexity: "O(n * 2^n)",
      spaceComplexity: "O(n^2)",
      explanation: "Precompute palindrome checks using DP table, then use backtracking. Avoids rechecking same substrings for palindrome property.",
      steps: [
        "Create n x n DP table for palindrome checks",
        "Initialize single characters as palindromes",
        "Fill DP table for all substring lengths:",
        "  - If s[i] == s[j] and inner is palindrome, mark as palindrome",
        "Define backtrack with start and current partition",
        "Base case: start == n, add to result",
        "For each end from start to n-1:",
        "  - If is_palindrome[start][end], add substring and recurse",
        "  - Backtrack",
        "Return result",
        "Key: DP table gives O(1) palindrome checks"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 17,
    title: "Letter Combinations of a Phone Number",
    difficulty: Difficulty.medium,
    category: "Backtracking",
    question: """Given a string containing digits from 2-9 inclusive, return all possible letter combinations that the number could represent. Return the answer in any order.

A mapping of digits to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.

2: abc
3: def
4: ghi
5: jkl
6: mno
7: pqrs
8: tuv
9: wxyz

Example 1:
Input: digits = "23"
Output: ["ad","ae","af","bd","be","bf","cd","ce","cf"]

Example 2:
Input: digits = ""
Output: []

Example 3:
Input: digits = "2"
Output: ["a","b","c"]

Constraints:
• 0 <= digits.length <= 4
• digits[i] is a digit in the range ['2', '9'].""",
    bruteForce: Solution(
      code: """def letterCombinations(digits):
    if not digits:
        return []

    mapping = {
        '2': 'abc', '3': 'def', '4': 'ghi', '5': 'jkl',
        '6': 'mno', '7': 'pqrs', '8': 'tuv', '9': 'wxyz'
    }

    result = ['']

    for digit in digits:
        new_result = []
        for combo in result:
            for letter in mapping[digit]:
                new_result.append(combo + letter)
        result = new_result

    return result""",
      timeComplexity: "O(4^n * n) - worst case 4 letters per digit",
      spaceComplexity: "O(4^n * n)",
      explanation: "Iteratively build combinations. For each digit, generate new combinations by appending each possible letter to all existing combinations.",
      steps: [
        "Handle empty string - return []",
        "Create digit to letters mapping",
        "Initialize result with empty string",
        "For each digit in digits:",
        "  - Create new_result list",
        "  - For each existing combination:",
        "    - For each letter mapped to current digit:",
        "      - Append combo + letter to new_result",
        "  - Replace result with new_result",
        "Return result"
      ],
    ),
    optimized: Solution(
      code: """def letterCombinations(digits):
    if not digits:
        return []

    mapping = {
        '2': 'abc', '3': 'def', '4': 'ghi', '5': 'jkl',
        '6': 'mno', '7': 'pqrs', '8': 'tuv', '9': 'wxyz'
    }

    result = []

    def backtrack(index, current):
        if index == len(digits):
            result.append(current)
            return

        for letter in mapping[digits[index]]:
            backtrack(index + 1, current + letter)

    backtrack(0, '')
    return result""",
      timeComplexity: "O(4^n * n)",
      spaceComplexity: "O(n) - recursion depth",
      explanation: "Use backtracking to build combinations digit by digit. For each digit, try each possible letter and recurse to next digit.",
      steps: [
        "Handle empty input",
        "Create digit to letters mapping",
        "Initialize empty result",
        "Define backtrack with current index and current string",
        "Base case: if index == len(digits), add to result",
        "For each letter mapped to current digit:",
        "  - Recursively build with letter appended",
        "Start backtracking from index 0 with empty string",
        "Return result",
        "Key: Cleaner backtracking approach, less space"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 51,
    title: "N-Queens",
    difficulty: Difficulty.hard,
    category: "Backtracking",
    question: """The n-queens puzzle is the problem of placing n queens on an n x n chessboard such that no two queens attack each other.

Given an integer n, return all distinct solutions to the n-queens puzzle. You may return the answer in any order.

Each solution contains a distinct board configuration of the n-queens' placement, where 'Q' and '.' both indicate a queen and an empty space, respectively.

Example 1:
Input: n = 4
Output: [[".Q..","...Q","Q...","..Q."],["..Q.","Q...","...Q",".Q.."]]

Example 2:
Input: n = 1
Output: [["Q"]]

Constraints:
• 1 <= n <= 9""",
    bruteForce: Solution(
      code: """def solveNQueens(n):
    def isSafe(board, row, col):
        # Check column
        for i in range(row):
            if board[i][col] == 'Q':
                return False

        # Check upper left diagonal
        i, j = row - 1, col - 1
        while i >= 0 and j >= 0:
            if board[i][j] == 'Q':
                return False
            i -= 1
            j -= 1

        # Check upper right diagonal
        i, j = row - 1, col + 1
        while i >= 0 and j < n:
            if board[i][j] == 'Q':
                return False
            i -= 1
            j += 1

        return True

    result = []

    def backtrack(row, board):
        if row == n:
            result.append([''.join(row) for row in board])
            return

        for col in range(n):
            if isSafe(board, row, col):
                board[row][col] = 'Q'
                backtrack(row + 1, board)
                board[row][col] = '.'

    board = [['.' for _ in range(n)] for _ in range(n)]
    backtrack(0, board)
    return result""",
      timeComplexity: "O(n!)",
      spaceComplexity: "O(n^2)",
      explanation: "Place queens row by row. For each row, try each column and check if safe (no conflicts). Check entire column and diagonals on each placement.",
      steps: [
        "Define isSafe to check if position is safe:",
        "  - Check entire column above",
        "  - Check upper left diagonal",
        "  - Check upper right diagonal",
        "Define backtrack with current row and board",
        "Base case: row == n, add solution to result",
        "For each column in current row:",
        "  - If safe, place queen and recurse to next row",
        "  - Backtrack by removing queen",
        "Initialize n x n board with dots",
        "Start backtracking from row 0",
        "Return result"
      ],
    ),
    optimized: Solution(
      code: """def solveNQueens(n):
    result = []
    cols = set()
    diag1 = set()  # row - col
    diag2 = set()  # row + col

    def backtrack(row, board):
        if row == n:
            result.append([''.join(row) for row in board])
            return

        for col in range(n):
            if col in cols or (row - col) in diag1 or (row + col) in diag2:
                continue

            # Place queen
            cols.add(col)
            diag1.add(row - col)
            diag2.add(row + col)
            board[row][col] = 'Q'

            backtrack(row + 1, board)

            # Remove queen
            cols.remove(col)
            diag1.remove(row - col)
            diag2.remove(row + col)
            board[row][col] = '.'

    board = [['.' for _ in range(n)] for _ in range(n)]
    backtrack(0, board)
    return result""",
      timeComplexity: "O(n!)",
      spaceComplexity: "O(n)",
      explanation: "Use sets to track attacked columns and diagonals for O(1) conflict checking. Diagonals identified by row-col and row+col values.",
      steps: [
        "Initialize sets for columns, diagonal1 (row-col), diagonal2 (row+col)",
        "Define backtrack with row and board",
        "Base case: row == n, add solution",
        "For each column:",
        "  - Skip if column or diagonals already attacked",
        "  - Add to attack sets and place queen",
        "  - Recurse to next row",
        "  - Remove from sets and remove queen (backtrack)",
        "Start from row 0",
        "Return result",
        "Key: Sets give O(1) conflict checking vs O(n) scanning"
      ],
    ),
  ),

];
