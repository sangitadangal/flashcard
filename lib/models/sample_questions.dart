import 'leetcode_question.dart';

final List<LeetCodeQuestion> sampleQuestions = [
  LeetCodeQuestion(
    id: 1,
    title: "Two Sum",
    difficulty: Difficulty.easy,
    category: "Arrays & Hashing",
    question: """Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

You can return the answer in any order.

Example 1:
Input: nums = [2,7,11,15], target = 9
Output: [0,1]
Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].

Example 2:
Input: nums = [3,2,4], target = 6
Output: [1,2]

Example 3:
Input: nums = [3,3], target = 6
Output: [0,1]

Constraints:
• 2 <= nums.length <= 10⁴
• -10⁹ <= nums[i] <= 10⁹
• -10⁹ <= target <= 10⁹
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
      explanation: "The brute force approach uses two nested loops to check every pair of numbers. For each element, we check all subsequent elements to see if their sum equals the target.",
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
      explanation: "The optimized approach uses a hash map to store numbers we've seen along with their indices. For each number, we calculate its complement (target - num) and check if we've seen it before.",
      steps: [
        "Create an empty hash map called 'seen' to store number -> index mappings",
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
    id: 2,
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
• s and t consist of lowercase English letters.

Follow up: What if the inputs contain Unicode characters?""",
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
      spaceComplexity: "O(1) - since alphabet is fixed size",
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
    id: 3,
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
    id: 4,
    title: "Valid Palindrome",
    difficulty: Difficulty.easy,
    category: "Two Pointers",
    question: """A phrase is a palindrome if, after converting all uppercase letters into lowercase letters and removing all non-alphanumeric characters, it reads the same forward and backward. Alphanumeric characters include letters and numbers.

Given a string s, return true if it is a palindrome, or false otherwise.

Example 1:
Input: s = "A man, a plan, a canal: Panama"
Output: true
Explanation: "amanaplanacanalpanama" is a palindrome.

Example 2:
Input: s = "race a car"
Output: false
Explanation: "raceacar" is not a palindrome.

Example 3:
Input: s = " "
Output: true
Explanation: s is an empty string "" after removing non-alphanumeric characters. Since an empty string reads the same forward and backward, it is a palindrome.

Constraints:
• 1 <= s.length <= 2 * 10⁵
• s consists only of printable ASCII characters.""",
    bruteForce: Solution(
      code: """def isPalindrome(s):
    # Clean the string
    cleaned = ""
    for char in s:
        if char.isalnum():
            cleaned += char.lower()

    # Check if palindrome
    return cleaned == cleaned[::-1]""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "First, create a cleaned string with only alphanumeric characters in lowercase. Then check if this cleaned string equals its reverse.",
      steps: [
        "Create an empty string called 'cleaned'",
        "Iterate through each character in the input string",
        "Check if the character is alphanumeric using isalnum()",
        "If yes, convert to lowercase and append to 'cleaned'",
        "After building cleaned string, reverse it using [::-1]",
        "Compare cleaned string with its reverse",
        "Return True if they're equal, False otherwise"
      ],
    ),
    optimized: Solution(
      code: """def isPalindrome(s):
    left = 0
    right = len(s) - 1

    while left < right:
        # Skip non-alphanumeric from left
        while left < right and not s[left].isalnum():
            left += 1
        # Skip non-alphanumeric from right
        while left < right and not s[right].isalnum():
            right -= 1

        # Compare characters
        if s[left].lower() != s[right].lower():
            return False

        left += 1
        right -= 1

    return True""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Use two pointers starting from both ends. Skip non-alphanumeric characters and compare valid characters from both ends, moving towards the center.",
      steps: [
        "Initialize two pointers: left at start (0), right at end (len-1)",
        "Loop while left pointer is less than right pointer",
        "Skip non-alphanumeric characters from the left by incrementing left",
        "Skip non-alphanumeric characters from the right by decrementing right",
        "Compare characters at left and right (after converting to lowercase)",
        "If they don't match, return False immediately",
        "If they match, move both pointers (left++, right--)",
        "If loop completes without finding mismatch, return True"
      ],
    ),
  ),
  LeetCodeQuestion(
    id: 5,
    title: "3Sum",
    difficulty: Difficulty.medium,
    category: "Two Pointers",
    question: """Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.

Notice that the solution set must not contain duplicate triplets.

Example 1:
Input: nums = [-1,0,1,2,-1,-4]
Output: [[-1,-1,2],[-1,0,1]]
Explanation:
nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0.
nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0.
nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0.
The distinct triplets are [-1,0,1] and [-1,-1,2].

Example 2:
Input: nums = [0,1,1]
Output: []
Explanation: The only possible triplet does not sum up to 0.

Example 3:
Input: nums = [0,0,0]
Output: [[0,0,0]]
Explanation: The only possible triplet sums up to 0.

Constraints:
• 3 <= nums.length <= 3000
• -10⁵ <= nums[i] <= 10⁵""",
    bruteForce: Solution(
      code: """def threeSum(nums):
    result = []
    seen = set()

    for i in range(len(nums)):
        for j in range(i + 1, len(nums)):
            for k in range(j + 1, len(nums)):
                if nums[i] + nums[j] + nums[k] == 0:
                    triplet = tuple(sorted([nums[i], nums[j], nums[k]]))
                    if triplet not in seen:
                        seen.add(triplet)
                        result.append(list(triplet))

    return result""",
      timeComplexity: "O(n³)",
      spaceComplexity: "O(n)",
      explanation: "Use three nested loops to check every possible combination of three numbers. Sort each triplet and use a set to avoid duplicates.",
      steps: [
        "Initialize empty result list and seen set for tracking duplicates",
        "Use three nested loops with indices i, j, k (where i < j < k)",
        "For each combination, check if sum equals 0",
        "If sum is 0, sort the triplet to normalize it",
        "Convert to tuple and check if it's in the seen set",
        "If not seen before, add to seen set and append to result",
        "Return the result list after checking all combinations"
      ],
    ),
    optimized: Solution(
      code: """def threeSum(nums):
    nums.sort()
    result = []

    for i in range(len(nums) - 2):
        # Skip duplicates for i
        if i > 0 and nums[i] == nums[i - 1]:
            continue

        left = i + 1
        right = len(nums) - 1

        while left < right:
            total = nums[i] + nums[left] + nums[right]

            if total < 0:
                left += 1
            elif total > 0:
                right -= 1
            else:
                result.append([nums[i], nums[left], nums[right]])

                # Skip duplicates for left and right
                while left < right and nums[left] == nums[left + 1]:
                    left += 1
                while left < right and nums[right] == nums[right - 1]:
                    right -= 1

                left += 1
                right -= 1

    return result""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(1) - excluding output array",
      explanation: "Sort the array first, then for each element, use two pointers to find pairs that sum to the negative of that element. Skip duplicates to avoid duplicate triplets.",
      steps: [
        "Sort the input array to enable two-pointer technique",
        "Iterate through array with index i (up to len-2)",
        "Skip duplicate values for i by checking if nums[i] == nums[i-1]",
        "For each i, set left pointer to i+1 and right pointer to end",
        "Calculate sum of three numbers: nums[i] + nums[left] + nums[right]",
        "If sum < 0, increment left pointer (need larger sum)",
        "If sum > 0, decrement right pointer (need smaller sum)",
        "If sum == 0, add triplet to result",
        "Skip duplicate values for left and right pointers",
        "Move both pointers inward and continue",
        "Return result list with all unique triplets"
      ],
    ),
  ),
];
