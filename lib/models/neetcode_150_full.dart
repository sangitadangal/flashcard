import 'leetcode_question.dart';

// NeetCode 150 - Complete Question List
// This file contains all 150 questions with full solutions
// Organized by category for better learning

final List<LeetCodeQuestion> neetcode150Questions = [

  // ============================================================================
  // ARRAYS & HASHING (9 questions)
  // ============================================================================

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
      spaceComplexity: "O(1) - only 26 lowercase letters",
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
    id: 49,
    title: "Group Anagrams",
    difficulty: Difficulty.medium,
    category: "Arrays & Hashing",
    question: """Given an array of strings strs, group the anagrams together. You can return the answer in any order.

An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

Example 1:
Input: strs = ["eat","tea","tan","ate","nat","bat"]
Output: [["bat"],["nat","tan"],["ate","eat","tea"]]

Example 2:
Input: strs = [""]
Output: [[""]]

Example 3:
Input: strs = ["a"]
Output: [["a"]]

Constraints:
• 1 <= strs.length <= 10⁴
• 0 <= strs[i].length <= 100
• strs[i] consists of lowercase English letters.""",
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
      explanation: "Use a hash map where the key is the sorted version of the string. All anagrams will have the same sorted key, so they'll be grouped together automatically.",
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
    question: """Given an integer array nums and an integer k, return the k most frequent elements. You may return the answer in any order.

Example 1:
Input: nums = [1,1,1,2,2,3], k = 2
Output: [1,2]

Example 2:
Input: nums = [1], k = 1
Output: [1]

Constraints:
• 1 <= nums.length <= 10⁵
• -10⁴ <= nums[i] <= 10⁴
• k is in the range [1, the number of unique elements in the array]
• It is guaranteed that the answer is unique.

Follow up: Your algorithm's time complexity must be better than O(n log n).""",
    bruteForce: Solution(
      code: """def topKFrequent(nums, k):
    # Count frequencies
    count = {}
    for num in nums:
        count[num] = count.get(num, 0) + 1

    # Sort by frequency
    sorted_items = sorted(count.items(), key=lambda x: x[1], reverse=True)

    # Return top k
    return [num for num, freq in sorted_items[:k]]""",
      timeComplexity: "O(n log n)",
      spaceComplexity: "O(n)",
      explanation: "Count frequencies using a hash map, then sort the items by frequency in descending order, and return the first k elements.",
      steps: [
        "Create hash map to count frequency of each number",
        "Iterate through array and update counts",
        "Convert hash map to list of (number, frequency) pairs",
        "Sort the pairs by frequency in descending order",
        "Take the first k pairs from sorted list",
        "Extract just the numbers (not frequencies) from these pairs",
        "Return the list of top k numbers"
      ],
    ),
    optimized: Solution(
      code: """def topKFrequent(nums, k):
    # Count frequencies
    count = {}
    for num in nums:
        count[num] = count.get(num, 0) + 1

    # Bucket sort by frequency
    freq = [[] for i in range(len(nums) + 1)]
    for num, cnt in count.items():
        freq[cnt].append(num)

    # Gather top k from buckets
    result = []
    for i in range(len(freq) - 1, 0, -1):
        for num in freq[i]:
            result.append(num)
            if len(result) == k:
                return result

    return result""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Use bucket sort where bucket index represents frequency. Count frequencies, place numbers in buckets based on their frequency, then collect from highest frequency buckets.",
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

  // ARRAYS & HASHING - More questions will be added in next update
  // Continuing with remaining Arrays & Hashing questions...

];
