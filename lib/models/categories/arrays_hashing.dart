import '../leetcode_question.dart';

// Arrays & Hashing - 9 Questions
// NeetCode 150 Category

final List<LeetCodeQuestion> arraysHashingQuestions = [

  LeetCodeQuestion(
    id: 217,
    title: "Contains Duplicate",
    difficulty: Difficulty.easy,
    category: "Arrays & Hashing",
    question: """Given an integer array nums, return true if any value appears at least twice in the array, and return false if every element is distinct.

Example 1:
Input: nums = [1,2,3,1]
Output: true

Example 2:
Input: nums = [1,2,3,4]
Output: false

Example 3:
Input: nums = [1,1,1,3,3,4,3,2,4,2]
Output: true

Constraints:
• 1 <= nums.length <= 10⁵
• -10⁹ <= nums[i] <= 10⁹""",
    bruteForce: Solution(
      code: """def containsDuplicate(nums):
    for i in range(len(nums)):
        for j in range(i + 1, len(nums)):
            if nums[i] == nums[j]:
                return True
    return False""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(1)",
      explanation: "Compare every pair of elements in the array. If any two elements are equal, return True.",
      steps: [
        "Use nested loops to compare each element with all subsequent elements",
        "Outer loop iterates through each element at index i",
        "Inner loop checks all elements after i (index j where j > i)",
        "If nums[i] equals nums[j], we found a duplicate - return True",
        "If no duplicates found after all comparisons, return False"
      ],
    ),
    optimized: Solution(
      code: """def containsDuplicate(nums):
    seen = set()
    for num in nums:
        if num in seen:
            return True
        seen.add(num)
    return False""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Use a hash set to track numbers we've seen. As we iterate, if we encounter a number already in the set, we've found a duplicate.",
      steps: [
        "Create an empty set called 'seen' to track visited numbers",
        "Iterate through each number in the array",
        "Check if the current number is already in the set",
        "If yes, we found a duplicate - return True immediately",
        "If no, add the current number to the set",
        "If we finish iterating without finding duplicates, return False"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 242,
    title: "Valid Anagram",
    difficulty: Difficulty.easy,
    category: "Arrays & Hashing",
    question: """Given two strings s and t, return true if t is an anagram of s, and false otherwise.

An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

Example 1:
Input: s = "anagram", t = "nagaram"
Output: true

Example 2:
Input: s = "rat", t = "car"
Output: false

Constraints:
• 1 <= s.length, t.length <= 5 * 10⁴
• s and t consist of lowercase English letters.""",
    bruteForce: Solution(
      code: """def isAnagram(s, t):
    if len(s) != len(t):
        return False
    return sorted(s) == sorted(t)""",
      timeComplexity: "O(n log n)",
      spaceComplexity: "O(n)",
      explanation: "Sort both strings and compare them. If they're anagrams, they'll be identical after sorting.",
      steps: [
        "Check if the lengths are different - if so, return False immediately",
        "Sort both strings using the sorted() function",
        "Compare the sorted strings",
        "Return True if they're equal, False otherwise"
      ],
    ),
    optimized: Solution(
      code: """def isAnagram(s, t):
    if len(s) != len(t):
        return False

    count = {}
    for char in s:
        count[char] = count.get(char, 0) + 1

    for char in t:
        if char not in count:
            return False
        count[char] -= 1
        if count[char] < 0:
            return False

    return True""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Use a hash map to count character frequencies in the first string, then verify the second string has the same frequencies.",
      steps: [
        "Check if lengths differ - return False if so",
        "Create a hash map to count characters in string s",
        "Iterate through s and increment count for each character",
        "Iterate through t and decrement count for each character",
        "If a character in t is not in the map, return False",
        "If any count goes negative, return False",
        "If we complete both loops successfully, return True"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 1,
    title: "Two Sum",
    difficulty: Difficulty.easy,
    category: "Arrays & Hashing",
    question: """Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

Example 1:
Input: nums = [2,7,11,15], target = 9
Output: [0,1]

Example 2:
Input: nums = [3,2,4], target = 6
Output: [1,2]

Constraints:
• 2 <= nums.length <= 10⁴
• -10⁹ <= nums[i] <= 10⁹
• Only one valid answer exists.""",
    bruteForce: Solution(
      code: """def twoSum(nums, target):
    for i in range(len(nums)):
        for j in range(i + 1, len(nums)):
            if nums[i] + nums[j] == target:
                return [i, j]
    return []""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(1)",
      explanation: "Use two nested loops to check every pair of numbers. For each element, check all subsequent elements to see if their sum equals the target.",
      steps: [
        "Iterate through each element in the array with index i",
        "For each i, iterate through remaining elements with index j (where j > i)",
        "Check if nums[i] + nums[j] equals the target",
        "If match found, return [i, j]",
        "If no match found after checking all pairs, return empty array"
      ],
    ),
    optimized: Solution(
      code: """def twoSum(nums, target):
    seen = {}
    for i, num in enumerate(nums):
        complement = target - num
        if complement in seen:
            return [seen[complement], i]
        seen[num] = i
    return []""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Use a hash map to store numbers we've seen with their indices. For each number, calculate its complement and check if we've seen it before.",
      steps: [
        "Create an empty hash map to store number -> index mappings",
        "Iterate through the array with both index and value",
        "Calculate the complement: target - current number",
        "Check if complement exists in the hash map",
        "If yes, return [seen[complement], current index]",
        "If no, store current number and its index in the hash map",
        "Continue until solution is found"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 49,
    title: "Group Anagrams",
    difficulty: Difficulty.medium,
    category: "Arrays & Hashing",
    question: """Given an array of strings strs, group the anagrams together. You can return the answer in any order.

Example 1:
Input: strs = ["eat","tea","tan","ate","nat","bat"]
Output: [["bat"],["nat","tan"],["ate","eat","tea"]]

Example 2:
Input: strs = [""]
Output: [[""]]

Constraints:
• 1 <= strs.length <= 10⁴
• 0 <= strs[i].length <= 100""",
    bruteForce: Solution(
      code: """def groupAnagrams(strs):
    result = []
    used = [False] * len(strs)

    for i in range(len(strs)):
        if used[i]:
            continue
        group = [strs[i]]
        used[i] = True

        for j in range(i + 1, len(strs)):
            if not used[j] and sorted(strs[i]) == sorted(strs[j]):
                group.append(strs[j])
                used[j] = True

        result.append(group)

    return result""",
      timeComplexity: "O(n² * k log k)",
      spaceComplexity: "O(n)",
      explanation: "For each string, compare it with all other strings by sorting them. Group strings that become identical after sorting.",
      steps: [
        "Create result list and boolean array to track used strings",
        "Iterate through each string in the array",
        "Skip if string already used in a group",
        "Start new group with current string and mark as used",
        "Compare with all remaining strings using sorted comparison",
        "Add matching strings to current group and mark as used",
        "Add completed group to result"
      ],
    ),
    optimized: Solution(
      code: """def groupAnagrams(strs):
    groups = {}

    for s in strs:
        key = tuple(sorted(s))
        if key not in groups:
            groups[key] = []
        groups[key].append(s)

    return list(groups.values())""",
      timeComplexity: "O(n * k log k)",
      spaceComplexity: "O(n * k)",
      explanation: "Use a hash map where the key is the sorted version of the string. All anagrams will have the same sorted key.",
      steps: [
        "Create empty hash map to store groups",
        "Iterate through each string in the array",
        "Sort the string and convert to tuple (hashable key)",
        "Check if this key exists in the hash map",
        "If not, create new list for this key",
        "Append current string to the list for this key",
        "Return all values from the hash map as the result"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 347,
    title: "Top K Frequent Elements",
    difficulty: Difficulty.medium,
    category: "Arrays & Hashing",
    question: """Given an integer array nums and an integer k, return the k most frequent elements.

Example 1:
Input: nums = [1,1,1,2,2,3], k = 2
Output: [1,2]

Example 2:
Input: nums = [1], k = 1
Output: [1]

Constraints:
• 1 <= nums.length <= 10⁵
• k is in the range [1, number of unique elements]""",
    bruteForce: Solution(
      code: """def topKFrequent(nums, k):
    count = {}
    for num in nums:
        count[num] = count.get(num, 0) + 1

    sorted_items = sorted(count.items(), key=lambda x: x[1], reverse=True)
    return [num for num, freq in sorted_items[:k]]""",
      timeComplexity: "O(n log n)",
      spaceComplexity: "O(n)",
      explanation: "Count frequencies using a hash map, then sort by frequency descending, and return the first k elements.",
      steps: [
        "Create hash map to count frequency of each number",
        "Iterate through array and update counts",
        "Convert hash map to list of (number, frequency) pairs",
        "Sort the pairs by frequency in descending order",
        "Take the first k pairs from sorted list",
        "Extract just the numbers from these pairs",
        "Return the list of top k numbers"
      ],
    ),
    optimized: Solution(
      code: """def topKFrequent(nums, k):
    count = {}
    for num in nums:
        count[num] = count.get(num, 0) + 1

    freq = [[] for i in range(len(nums) + 1)]
    for num, cnt in count.items():
        freq[cnt].append(num)

    result = []
    for i in range(len(freq) - 1, 0, -1):
        for num in freq[i]:
            result.append(num)
            if len(result) == k:
                return result
    return result""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Use bucket sort where bucket index represents frequency. Count frequencies, place numbers in buckets, then collect from highest frequency buckets.",
      steps: [
        "Count frequency of each number using hash map",
        "Create array of buckets where index represents frequency",
        "Place each number in the bucket corresponding to its frequency",
        "Iterate through buckets from highest frequency to lowest",
        "Collect numbers from each bucket into result list",
        "Stop when we've collected k numbers",
        "Return the result"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 238,
    title: "Product of Array Except Self",
    difficulty: Difficulty.medium,
    category: "Arrays & Hashing",
    question: """Given an integer array nums, return an array answer such that answer[i] is equal to the product of all the elements of nums except nums[i].

The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.

You must write an algorithm that runs in O(n) time and without using the division operation.

Example 1:
Input: nums = [1,2,3,4]
Output: [24,12,8,6]

Example 2:
Input: nums = [-1,1,0,-3,3]
Output: [0,0,9,0,0]

Constraints:
• 2 <= nums.length <= 10⁵
• -30 <= nums[i] <= 30""",
    bruteForce: Solution(
      code: """def productExceptSelf(nums):
    result = []
    for i in range(len(nums)):
        product = 1
        for j in range(len(nums)):
            if i != j:
                product *= nums[j]
        result.append(product)
    return result""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(1)",
      explanation: "For each index, calculate the product of all other elements by iterating through the entire array and skipping the current index.",
      steps: [
        "Create empty result array",
        "For each index i in the array",
        "Initialize product to 1",
        "Iterate through all indices j",
        "If j is not equal to i, multiply product by nums[j]",
        "Append the final product to result",
        "Return the result array"
      ],
    ),
    optimized: Solution(
      code: """def productExceptSelf(nums):
    n = len(nums)
    result = [1] * n

    # Left products
    left = 1
    for i in range(n):
        result[i] = left
        left *= nums[i]

    # Right products
    right = 1
    for i in range(n - 1, -1, -1):
        result[i] *= right
        right *= nums[i]

    return result""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Use prefix and suffix products. First pass calculates products of all elements to the left. Second pass multiplies by products of all elements to the right.",
      steps: [
        "Create result array filled with 1s",
        "First pass: iterate left to right, storing prefix products",
        "For each position, store product of all elements to the left",
        "Update running left product after each position",
        "Second pass: iterate right to left with suffix products",
        "Multiply each position by product of all elements to the right",
        "Return the result"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 36,
    title: "Valid Sudoku",
    difficulty: Difficulty.medium,
    category: "Arrays & Hashing",
    question: """Determine if a 9 x 9 Sudoku board is valid. Only the filled cells need to be validated according to the following rules:

1. Each row must contain the digits 1-9 without repetition.
2. Each column must contain the digits 1-9 without repetition.
3. Each of the nine 3 x 3 sub-boxes must contain the digits 1-9 without repetition.

Note: A Sudoku board could be partially filled, where empty cells are filled with '.'.

Example 1:
Input: board =
[["5","3",".",".","7",".",".",".","."]
,["6",".",".","1","9","5",".",".","."]
,[".","9","8",".",".",".",".","6","."]
,["8",".",".",".","6",".",".",".","3"]
,["4",".",".","8",".","3",".",".","1"]
,["7",".",".",".","2",".",".",".","6"]
,[".","6",".",".",".",".","2","8","."]
,[".",".",".","4","1","9",".",".","5"]
,[".",".",".",".","8",".",".","7","9"]]
Output: true

Constraints:
• board.length == 9
• board[i].length == 9
• board[i][j] is a digit 1-9 or '.'""",
    bruteForce: Solution(
      code: """def isValidSudoku(board):
    # Check rows
    for row in board:
        seen = set()
        for num in row:
            if num != '.':
                if num in seen:
                    return False
                seen.add(num)

    # Check columns
    for col in range(9):
        seen = set()
        for row in range(9):
            num = board[row][col]
            if num != '.':
                if num in seen:
                    return False
                seen.add(num)

    # Check 3x3 boxes
    for box_row in range(3):
        for box_col in range(3):
            seen = set()
            for i in range(3):
                for j in range(3):
                    num = board[box_row*3 + i][box_col*3 + j]
                    if num != '.':
                        if num in seen:
                            return False
                        seen.add(num)

    return True""",
      timeComplexity: "O(1)",
      spaceComplexity: "O(1)",
      explanation: "Check each row, column, and 3x3 box separately using sets to detect duplicates. Since board size is fixed at 9x9, it's constant time.",
      steps: [
        "Iterate through all 9 rows, check for duplicates using a set",
        "For each row, create new set and add non-empty cells",
        "Return False if duplicate found in any row",
        "Iterate through all 9 columns, check for duplicates",
        "For each column, create new set and check all rows",
        "Iterate through all 9 boxes (3x3 sub-grids)",
        "For each box, check all 9 cells for duplicates",
        "Return True if all checks pass"
      ],
    ),
    optimized: Solution(
      code: """def isValidSudoku(board):
    rows = [set() for _ in range(9)]
    cols = [set() for _ in range(9)]
    boxes = [set() for _ in range(9)]

    for r in range(9):
        for c in range(9):
            num = board[r][c]
            if num == '.':
                continue

            box_idx = (r // 3) * 3 + (c // 3)

            if num in rows[r] or num in cols[c] or num in boxes[box_idx]:
                return False

            rows[r].add(num)
            cols[c].add(num)
            boxes[box_idx].add(num)

    return True""",
      timeComplexity: "O(1)",
      spaceComplexity: "O(1)",
      explanation: "Single pass through the board, maintaining sets for each row, column, and box. Check all three constraints simultaneously for each cell.",
      steps: [
        "Create 9 sets for rows, 9 for columns, 9 for boxes",
        "Iterate through each cell in the board",
        "Skip empty cells (marked with '.')",
        "Calculate which box the cell belongs to using (r//3)*3 + (c//3)",
        "Check if number exists in current row, column, or box set",
        "If duplicate found, return False",
        "Add number to all three sets (row, column, box)",
        "Return True if entire board passes"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 271,
    title: "Encode and Decode Strings",
    difficulty: Difficulty.medium,
    category: "Arrays & Hashing",
    question: """Design an algorithm to encode a list of strings to a single string. The encoded string is then decoded back to the original list of strings.

Please implement encode and decode.

Example 1:
Input: ["lint","code","love","you"]
Output: ["lint","code","love","you"]
Explanation: One possible encode method is: "lint:;code:;love:;you"

Example 2:
Input: ["we", "say", ":", "yes"]
Output: ["we", "say", ":", "yes"]

Constraints:
• 1 <= strs.length <= 200
• 0 <= strs[i].length <= 200
• strs[i] contains any possible characters""",
    bruteForce: Solution(
      code: """def encode(strs):
    return ':;'.join(strs)

def decode(s):
    return s.split(':;')""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Use a delimiter ':;' to separate strings. However, this fails if strings contain the delimiter themselves.",
      steps: [
        "Encode: join all strings with a delimiter ':;'",
        "Create single string with delimiter between each word",
        "Decode: split the encoded string by delimiter",
        "Problem: fails if original strings contain ':;'",
        "Not robust for all possible inputs"
      ],
    ),
    optimized: Solution(
      code: """def encode(strs):
    result = ""
    for s in strs:
        result += str(len(s)) + "#" + s
    return result

def decode(s):
    result = []
    i = 0
    while i < len(s):
        # Find the '#' delimiter
        j = i
        while s[j] != '#':
            j += 1
        # Extract length
        length = int(s[i:j])
        # Extract string of that length
        result.append(s[j+1:j+1+length])
        # Move to next encoded string
        i = j + 1 + length
    return result""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Prefix each string with its length followed by '#'. This works for any characters including delimiters.",
      steps: [
        "Encode: for each string, prepend its length and '#' delimiter",
        "Format: length#string (e.g., '4#lint5#codes')",
        "Decode: read the length, skip '#', read exactly that many characters",
        "Find '#' to get the length prefix",
        "Read exactly 'length' characters after '#'",
        "Move pointer to start of next encoded string",
        "Repeat until entire string is decoded"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 128,
    title: "Longest Consecutive Sequence",
    difficulty: Difficulty.medium,
    category: "Arrays & Hashing",
    question: """Given an unsorted array of integers nums, return the length of the longest consecutive elements sequence.

You must write an algorithm that runs in O(n) time.

Example 1:
Input: nums = [100,4,200,1,3,2]
Output: 4
Explanation: The longest consecutive sequence is [1, 2, 3, 4]. Therefore its length is 4.

Example 2:
Input: nums = [0,3,7,2,5,8,4,6,0,1]
Output: 9

Constraints:
• 0 <= nums.length <= 10⁵
• -10⁹ <= nums[i] <= 10⁹""",
    bruteForce: Solution(
      code: """def longestConsecutive(nums):
    if not nums:
        return 0

    nums.sort()
    longest = 1
    current = 1

    for i in range(1, len(nums)):
        if nums[i] == nums[i-1]:
            continue
        if nums[i] == nums[i-1] + 1:
            current += 1
            longest = max(longest, current)
        else:
            current = 1

    return longest""",
      timeComplexity: "O(n log n)",
      spaceComplexity: "O(1)",
      explanation: "Sort the array first, then iterate through counting consecutive numbers. Reset count when sequence breaks.",
      steps: [
        "Handle edge case: empty array returns 0",
        "Sort the entire array",
        "Initialize longest and current sequence counters to 1",
        "Iterate through sorted array",
        "Skip duplicates (same number as previous)",
        "If current number is previous + 1, increment current streak",
        "If not consecutive, reset current streak to 1",
        "Return the longest streak found"
      ],
    ),
    optimized: Solution(
      code: """def longestConsecutive(nums):
    if not nums:
        return 0

    num_set = set(nums)
    longest = 0

    for num in num_set:
        # Only start counting if it's the start of a sequence
        if num - 1 not in num_set:
            current_num = num
            current_streak = 1

            # Count consecutive numbers
            while current_num + 1 in num_set:
                current_num += 1
                current_streak += 1

            longest = max(longest, current_streak)

    return longest""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Use a hash set for O(1) lookups. Only start counting from the beginning of each sequence (when num-1 doesn't exist), then count upward.",
      steps: [
        "Convert array to set for O(1) lookups",
        "Initialize longest streak to 0",
        "Iterate through each unique number in set",
        "Check if current number is start of sequence (num-1 not in set)",
        "If it's a start, count how long the sequence extends",
        "Keep incrementing and checking if next number exists in set",
        "Update longest if current streak is longer",
        "Return the longest streak found"
      ],
    ),
  ),

];
