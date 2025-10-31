import '../leetcode_question.dart';

// NeetCode 150 - Two Pointers Category
// 5 questions with complete solutions

final List<LeetCodeQuestion> twoPointersQuestions = [

  LeetCodeQuestion(
    id: 125,
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
Explanation: s is an empty string "" after removing non-alphanumeric characters.
Since an empty string reads the same forward and backward, it is a palindrome.

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

    # Reverse and compare
    return cleaned == cleaned[::-1]""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Clean the string by removing non-alphanumeric characters and converting to lowercase, then create a reversed copy and compare the two strings.",
      steps: [
        "Initialize an empty string called 'cleaned'",
        "Iterate through each character in the input string",
        "Check if the character is alphanumeric using isalnum()",
        "If alphanumeric, convert to lowercase and append to cleaned string",
        "After building cleaned string, create reversed version using slicing [::-1]",
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
      explanation: "Use two pointers starting from both ends. Skip non-alphanumeric characters and compare valid characters case-insensitively. This avoids creating a cleaned copy of the string.",
      steps: [
        "Initialize two pointers: left at start (0) and right at end (len(s)-1)",
        "Loop while left pointer is less than right pointer",
        "Skip non-alphanumeric characters from left by incrementing left pointer",
        "Skip non-alphanumeric characters from right by decrementing right pointer",
        "Compare characters at both pointers after converting to lowercase",
        "If characters don't match, return False immediately",
        "Move both pointers inward (left++, right--) and continue",
        "If loop completes without mismatches, return True"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 167,
    title: "Two Sum II - Input Array Is Sorted",
    difficulty: Difficulty.medium,
    category: "Two Pointers",
    question: """Given a 1-indexed array of integers numbers that is already sorted in non-decreasing order, find two numbers such that they add up to a specific target number. Let these two numbers be numbers[index1] and numbers[index2] where 1 <= index1 < index2 <= numbers.length.

Return the indices of the two numbers, index1 and index2, added by one as an integer array [index1, index2] of length 2.

The tests are generated such that there is exactly one solution. You may not use the same element twice.

Your solution must use only constant extra space.

Example 1:
Input: numbers = [2,7,11,15], target = 9
Output: [1,2]
Explanation: The sum of 2 and 7 is 9. Therefore, index1 = 1, index2 = 2. We return [1, 2].

Example 2:
Input: numbers = [2,3,4], target = 6
Output: [1,3]
Explanation: The sum of 2 and 4 is 6. Therefore index1 = 1, index2 = 3. We return [1, 3].

Example 3:
Input: numbers = [-1,0], target = -1
Output: [1,2]
Explanation: The sum of -1 and 0 is -1. Therefore index1 = 1, index2 = 2. We return [1, 2].

Constraints:
• 2 <= numbers.length <= 3 * 10⁴
• -1000 <= numbers[i] <= 1000
• numbers is sorted in non-decreasing order
• -1000 <= target <= 1000
• The tests are generated such that there is exactly one solution.""",
    bruteForce: Solution(
      code: """def twoSum(numbers, target):
    for i in range(len(numbers)):
        for j in range(i + 1, len(numbers)):
            if numbers[i] + numbers[j] == target:
                return [i + 1, j + 1]  # 1-indexed
    return []""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(1)",
      explanation: "Use nested loops to check every pair of numbers. When a pair sums to target, return their indices (converted to 1-indexed).",
      steps: [
        "Use outer loop with index i from 0 to len(numbers)-1",
        "Use inner loop with index j from i+1 to len(numbers)-1",
        "Check if numbers[i] + numbers[j] equals target",
        "If match found, return [i+1, j+1] (convert to 1-indexed)",
        "If no match found after all iterations, return empty array",
        "Note: This approach doesn't leverage the sorted property"
      ],
    ),
    optimized: Solution(
      code: """def twoSum(numbers, target):
    left = 0
    right = len(numbers) - 1

    while left < right:
        current_sum = numbers[left] + numbers[right]

        if current_sum == target:
            return [left + 1, right + 1]  # 1-indexed
        elif current_sum < target:
            left += 1  # Need larger sum
        else:
            right -= 1  # Need smaller sum

    return []""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Use two pointers from both ends of the sorted array. If sum is too small, move left pointer right to increase sum. If sum is too large, move right pointer left to decrease sum.",
      steps: [
        "Initialize left pointer at start (0) and right pointer at end (len-1)",
        "Loop while left < right",
        "Calculate current sum: numbers[left] + numbers[right]",
        "If current sum equals target, return [left+1, right+1] (1-indexed)",
        "If current sum < target, increment left pointer (need larger number)",
        "If current sum > target, decrement right pointer (need smaller number)",
        "Continue until solution found (guaranteed to exist)"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 15,
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
Notice that the order of the output and the order of the triplets does not matter.

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
    n = len(nums)

    for i in range(n):
        for j in range(i + 1, n):
            for k in range(j + 1, n):
                if nums[i] + nums[j] + nums[k] == 0:
                    triplet = sorted([nums[i], nums[j], nums[k]])
                    if triplet not in result:
                        result.append(triplet)

    return result""",
      timeComplexity: "O(n³)",
      spaceComplexity: "O(n)",
      explanation: "Use three nested loops to check every possible triplet. Sort each valid triplet and check if it's already in results to avoid duplicates.",
      steps: [
        "Initialize empty result list",
        "Use three nested loops with indices i, j, k",
        "Outer loop: i from 0 to n-1",
        "Middle loop: j from i+1 to n-1",
        "Inner loop: k from j+1 to n-1",
        "Check if nums[i] + nums[j] + nums[k] == 0",
        "If sum is 0, sort the triplet to normalize order",
        "Check if this sorted triplet is not already in result",
        "If unique, add to result list",
        "Return result after checking all combinations"
      ],
    ),
    optimized: Solution(
      code: """def threeSum(nums):
    nums.sort()
    result = []

    for i in range(len(nums) - 2):
        # Skip duplicates for first element
        if i > 0 and nums[i] == nums[i - 1]:
            continue

        left = i + 1
        right = len(nums) - 1

        while left < right:
            three_sum = nums[i] + nums[left] + nums[right]

            if three_sum == 0:
                result.append([nums[i], nums[left], nums[right]])

                # Skip duplicates for second element
                while left < right and nums[left] == nums[left + 1]:
                    left += 1
                # Skip duplicates for third element
                while left < right and nums[right] == nums[right - 1]:
                    right -= 1

                left += 1
                right -= 1
            elif three_sum < 0:
                left += 1
            else:
                right -= 1

    return result""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(1) - excluding output",
      explanation: "Sort the array first. Fix one element and use two pointers for the remaining elements. Skip duplicates at all three positions to avoid duplicate triplets.",
      steps: [
        "Sort the input array in ascending order",
        "Initialize empty result list",
        "Loop through array with index i (first element of triplet)",
        "Skip duplicate values for i by checking if nums[i] == nums[i-1]",
        "For each i, use two pointers: left = i+1, right = end",
        "Calculate sum of three elements: nums[i] + nums[left] + nums[right]",
        "If sum == 0, add triplet to result and skip duplicates for left and right",
        "If sum < 0, increment left pointer (need larger sum)",
        "If sum > 0, decrement right pointer (need smaller sum)",
        "Continue until all triplets found"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 11,
    title: "Container With Most Water",
    difficulty: Difficulty.medium,
    category: "Two Pointers",
    question: """You are given an integer array height of length n. There are n vertical lines drawn such that the two endpoints of the ith line are (i, 0) and (i, height[i]).

Find two lines that together with the x-axis form a container, such that the container contains the most water.

Return the maximum amount of water a container can store.

Notice that you may not slant the container.

Example 1:
Input: height = [1,8,6,2,5,4,8,3,7]
Output: 49
Explanation: The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49.

Example 2:
Input: height = [1,1]
Output: 1

Constraints:
• n == height.length
• 2 <= n <= 10⁵
• 0 <= height[i] <= 10⁴""",
    bruteForce: Solution(
      code: """def maxArea(height):
    max_area = 0

    for i in range(len(height)):
        for j in range(i + 1, len(height)):
            width = j - i
            h = min(height[i], height[j])
            area = width * h
            max_area = max(max_area, area)

    return max_area""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(1)",
      explanation: "Check every pair of lines to calculate the area formed. The area is determined by the width (distance between lines) and the height (minimum of the two lines).",
      steps: [
        "Initialize max_area to 0",
        "Use outer loop with index i from 0 to len(height)-1",
        "Use inner loop with index j from i+1 to len(height)-1",
        "Calculate width as distance between lines: j - i",
        "Calculate height as minimum of the two lines: min(height[i], height[j])",
        "Calculate area as width * height",
        "Update max_area if current area is larger",
        "Return max_area after checking all pairs"
      ],
    ),
    optimized: Solution(
      code: """def maxArea(height):
    max_area = 0
    left = 0
    right = len(height) - 1

    while left < right:
        # Calculate current area
        width = right - left
        h = min(height[left], height[right])
        area = width * h
        max_area = max(max_area, area)

        # Move pointer with smaller height
        if height[left] < height[right]:
            left += 1
        else:
            right -= 1

    return max_area""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Use two pointers starting from both ends. The area is limited by the shorter line, so we move the pointer at the shorter line inward, hoping to find a taller line that might give us a larger area.",
      steps: [
        "Initialize max_area to 0, left pointer at 0, right pointer at end",
        "Loop while left < right",
        "Calculate width as distance between pointers: right - left",
        "Calculate height as minimum of both lines: min(height[left], height[right])",
        "Calculate current area: width * height",
        "Update max_area if current area is larger",
        "Move the pointer pointing to the shorter line inward",
        "If height[left] < height[right], increment left; otherwise decrement right",
        "Continue until pointers meet",
        "Return max_area"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 42,
    title: "Trapping Rain Water",
    difficulty: Difficulty.hard,
    category: "Two Pointers",
    question: """Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it can trap after raining.

Example 1:
Input: height = [0,1,0,2,1,0,1,3,2,1,2,1]
Output: 6
Explanation: The above elevation map (black section) is represented by array [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water (blue section) are being trapped.

Example 2:
Input: height = [4,2,0,3,2,5]
Output: 9

Constraints:
• n == height.length
• 1 <= n <= 2 * 10⁴
• 0 <= height[i] <= 10⁵""",
    bruteForce: Solution(
      code: """def trap(height):
    if not height:
        return 0

    total_water = 0

    for i in range(len(height)):
        # Find max height to the left
        left_max = 0
        for j in range(i):
            left_max = max(left_max, height[j])

        # Find max height to the right
        right_max = 0
        for j in range(i + 1, len(height)):
            right_max = max(right_max, height[j])

        # Calculate water at current position
        water_level = min(left_max, right_max)
        if water_level > height[i]:
            total_water += water_level - height[i]

    return total_water""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(1)",
      explanation: "For each position, find the maximum height to its left and right. The water trapped at this position is determined by the minimum of these two maximums minus the current height.",
      steps: [
        "Handle edge case: return 0 if height array is empty",
        "Initialize total_water to 0",
        "For each position i in the array:",
        "Find left_max: iterate from 0 to i-1 and track maximum height",
        "Find right_max: iterate from i+1 to end and track maximum height",
        "Calculate water_level as min(left_max, right_max)",
        "If water_level > height[i], water is trapped",
        "Add (water_level - height[i]) to total_water",
        "Return total_water after processing all positions"
      ],
    ),
    optimized: Solution(
      code: """def trap(height):
    if not height:
        return 0

    left = 0
    right = len(height) - 1
    left_max = height[left]
    right_max = height[right]
    total_water = 0

    while left < right:
        if left_max < right_max:
            left += 1
            left_max = max(left_max, height[left])
            total_water += left_max - height[left]
        else:
            right -= 1
            right_max = max(right_max, height[right])
            total_water += right_max - height[right]

    return total_water""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Use two pointers with running max heights from both sides. Move the pointer with smaller max inward. The water trapped at current position depends on the smaller of the two max heights seen so far.",
      steps: [
        "Handle edge case: return 0 if height is empty",
        "Initialize left pointer at 0, right pointer at end",
        "Initialize left_max and right_max with heights at respective pointers",
        "Initialize total_water to 0",
        "Loop while left < right",
        "If left_max < right_max, process left side:",
        "  - Move left pointer right",
        "  - Update left_max if current height is taller",
        "  - Add (left_max - height[left]) to total_water",
        "Otherwise, process right side:",
        "  - Move right pointer left",
        "  - Update right_max if current height is taller",
        "  - Add (right_max - height[right]) to total_water",
        "Return total_water when pointers meet"
      ],
    ),
  ),

];
