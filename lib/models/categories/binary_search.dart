import '../leetcode_question.dart';

// NeetCode 150 - Binary Search Category
// 7 questions with complete solutions

final List<LeetCodeQuestion> binarySearchQuestions = [

  LeetCodeQuestion(
    id: 704,
    title: "Binary Search",
    difficulty: Difficulty.easy,
    category: "Binary Search",
    question: """Given an array of integers nums which is sorted in ascending order, and an integer target, write a function to search target in nums. If target exists, then return its index. Otherwise, return -1.

You must write an algorithm with O(log n) runtime complexity.

Example 1:
Input: nums = [-1,0,3,5,9,12], target = 9
Output: 4
Explanation: 9 exists in nums and its index is 4

Example 2:
Input: nums = [-1,0,3,5,9,12], target = 2
Output: -1
Explanation: 2 does not exist in nums so return -1

Constraints:
• 1 <= nums.length <= 10⁴
• -10⁴ < nums[i], target < 10⁴
• All the integers in nums are unique.
• nums is sorted in ascending order.""",
    bruteForce: Solution(
      code: """def search(nums, target):
    for i in range(len(nums)):
        if nums[i] == target:
            return i
    return -1""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Linear search through the array checking each element. This doesn't take advantage of the sorted property and violates the O(log n) requirement.",
      steps: [
        "Iterate through array with index i",
        "Check if nums[i] equals target",
        "If match found, return index i",
        "If loop completes without finding target, return -1",
        "Note: This is O(n) and doesn't use the sorted property"
      ],
    ),
    optimized: Solution(
      code: """def search(nums, target):
    left = 0
    right = len(nums) - 1

    while left <= right:
        mid = left + (right - left) // 2

        if nums[mid] == target:
            return mid
        elif nums[mid] < target:
            left = mid + 1  # Search right half
        else:
            right = mid - 1  # Search left half

    return -1""",
      timeComplexity: "O(log n)",
      spaceComplexity: "O(1)",
      explanation: "Classic binary search. Repeatedly divide the search space in half by comparing the middle element with the target. Move left or right pointer based on comparison.",
      steps: [
        "Initialize left pointer to 0 and right pointer to len(nums) - 1",
        "Loop while left <= right:",
        "  - Calculate mid index: left + (right - left) // 2",
        "  - If nums[mid] equals target, return mid (found it)",
        "  - If nums[mid] < target, search right half: left = mid + 1",
        "  - If nums[mid] > target, search left half: right = mid - 1",
        "If loop exits, target not found - return -1",
        "Note: Use left + (right - left) // 2 to avoid integer overflow"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 74,
    title: "Search a 2D Matrix",
    difficulty: Difficulty.medium,
    category: "Binary Search",
    question: """You are given an m x n integer matrix matrix with the following two properties:
• Each row is sorted in non-decreasing order.
• The first integer of each row is greater than the last integer of the previous row.

Given an integer target, return true if target is in matrix or false otherwise.

You must write a solution in O(log(m * n)) time complexity.

Example 1:
Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 3
Output: true

Example 2:
Input: matrix = [[1,3,5,7],[10,11,16,20],[23,30,34,60]], target = 13
Output: false

Constraints:
• m == matrix.length
• n == matrix[i].length
• 1 <= m, n <= 100
• -10⁴ <= matrix[i][j], target <= 10⁴""",
    bruteForce: Solution(
      code: """def searchMatrix(matrix, target):
    for row in matrix:
        for val in row:
            if val == target:
                return True
    return False""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(1)",
      explanation: "Check every element in the matrix using nested loops. This doesn't take advantage of the sorted property.",
      steps: [
        "Iterate through each row in the matrix",
        "For each row, iterate through each value",
        "If value equals target, return True",
        "If all elements checked without match, return False",
        "Note: This is O(m*n) and ignores the sorted structure"
      ],
    ),
    optimized: Solution(
      code: """def searchMatrix(matrix, target):
    if not matrix or not matrix[0]:
        return False

    m, n = len(matrix), len(matrix[0])
    left, right = 0, m * n - 1

    while left <= right:
        mid = left + (right - left) // 2
        # Convert 1D index to 2D coordinates
        row = mid // n
        col = mid % n
        mid_val = matrix[row][col]

        if mid_val == target:
            return True
        elif mid_val < target:
            left = mid + 1
        else:
            right = mid - 1

    return False""",
      timeComplexity: "O(log(m * n))",
      spaceComplexity: "O(1)",
      explanation: "Treat the 2D matrix as a flattened 1D sorted array and perform binary search. Convert 1D indices to 2D coordinates using division and modulo operations.",
      steps: [
        "Handle edge case: empty matrix",
        "Get dimensions m (rows) and n (columns)",
        "Initialize left = 0, right = m * n - 1 (treat as 1D array)",
        "Binary search loop while left <= right:",
        "  - Calculate mid index in 1D space",
        "  - Convert to 2D: row = mid // n, col = mid % n",
        "  - Get value: mid_val = matrix[row][col]",
        "  - If mid_val == target, return True",
        "  - If mid_val < target, search right: left = mid + 1",
        "  - If mid_val > target, search left: right = mid - 1",
        "If loop exits, target not found - return False"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 875,
    title: "Koko Eating Bananas",
    difficulty: Difficulty.medium,
    category: "Binary Search",
    question: """Koko loves to eat bananas. There are n piles of bananas, the ith pile has piles[i] bananas. The guards have gone and will come back in h hours.

Koko can decide her bananas-per-hour eating speed of k. Each hour, she chooses some pile of bananas and eats k bananas from that pile. If the pile has less than k bananas, she eats all of them instead and will not eat any more bananas during this hour.

Koko likes to eat slowly but still wants to finish eating all the bananas before the guards return.

Return the minimum integer k such that she can eat all the bananas within h hours.

Example 1:
Input: piles = [3,6,7,11], h = 8
Output: 4

Example 2:
Input: piles = [30,11,23,4,20], h = 5
Output: 30

Example 3:
Input: piles = [30,11,23,4,20], h = 6
Output: 23

Constraints:
• 1 <= piles.length <= 10⁴
• piles.length <= h <= 10⁹
• 1 <= piles[i] <= 10⁹""",
    bruteForce: Solution(
      code: """def minEatingSpeed(piles, h):
    import math

    def canFinish(k):
        hours = 0
        for pile in piles:
            hours += math.ceil(pile / k)
        return hours <= h

    # Try every speed from 1 to max(piles)
    for k in range(1, max(piles) + 1):
        if canFinish(k):
            return k

    return max(piles)""",
      timeComplexity: "O(n * m) - n is len(piles), m is max(piles)",
      spaceComplexity: "O(1)",
      explanation: "Try every possible eating speed from 1 to max(piles). For each speed, calculate if Koko can finish all bananas in h hours. Return the first speed that works.",
      steps: [
        "Create helper function canFinish(k) that checks if speed k works",
        "  - For each pile, calculate hours needed: ceil(pile / k)",
        "  - Sum total hours and check if <= h",
        "Iterate through speeds k from 1 to max(piles)",
        "For each speed k, check if canFinish(k) is True",
        "If True, return k (first valid speed is minimum)",
        "If no speed works, return max(piles) (guaranteed to work in h >= n)",
        "Note: This is very slow for large max(piles)"
      ],
    ),
    optimized: Solution(
      code: """def minEatingSpeed(piles, h):
    import math

    def canFinish(k):
        hours = 0
        for pile in piles:
            hours += math.ceil(pile / k)
        return hours <= h

    left = 1
    right = max(piles)

    while left < right:
        mid = left + (right - left) // 2

        if canFinish(mid):
            # Can finish at this speed, try slower
            right = mid
        else:
            # Too slow, need faster speed
            left = mid + 1

    return left""",
      timeComplexity: "O(n * log m) - n is len(piles), m is max(piles)",
      spaceComplexity: "O(1)",
      explanation: "Use binary search on the speed range [1, max(piles)]. For each candidate speed, check if it's sufficient. If yes, try slower speeds (search left). If no, try faster speeds (search right).",
      steps: [
        "Create helper function canFinish(k) to check if speed k works",
        "Initialize binary search range: left = 1, right = max(piles)",
        "Binary search loop while left < right:",
        "  - Calculate mid speed",
        "  - Check if canFinish(mid) is True",
        "  - If True, mid might work but try slower: right = mid",
        "  - If False, need faster speed: left = mid + 1",
        "When left == right, we found minimum speed",
        "Return left",
        "Key: We're searching for the minimum k where canFinish(k) is True"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 153,
    title: "Find Minimum in Rotated Sorted Array",
    difficulty: Difficulty.medium,
    category: "Binary Search",
    question: """Suppose an array of length n sorted in ascending order is rotated between 1 and n times. For example, the array nums = [0,1,2,4,5,6,7] might become:
• [4,5,6,7,0,1,2] if it was rotated 4 times.
• [0,1,2,4,5,6,7] if it was rotated 7 times.

Notice that rotating an array [a[0], a[1], a[2], ..., a[n-1]] 1 time results in the array [a[n-1], a[0], a[1], a[2], ..., a[n-2]].

Given the sorted rotated array nums of unique elements, return the minimum element of this array.

You must write an algorithm that runs in O(log n) time.

Example 1:
Input: nums = [3,4,5,1,2]
Output: 1
Explanation: The original array was [1,2,3,4,5] rotated 3 times.

Example 2:
Input: nums = [4,5,6,7,0,1,2]
Output: 0
Explanation: The original array was [0,1,2,4,5,6,7] and it was rotated 4 times.

Example 3:
Input: nums = [11,13,15,17]
Output: 11
Explanation: The original array was [11,13,15,17] and it was rotated 4 times.

Constraints:
• n == nums.length
• 1 <= n <= 5000
• -5000 <= nums[i] <= 5000
• All the integers of nums are unique.
• nums is sorted and rotated between 1 and n times.""",
    bruteForce: Solution(
      code: """def findMin(nums):
    return min(nums)""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Simply use the built-in min() function to scan through entire array and find the minimum. This works but doesn't meet the O(log n) requirement.",
      steps: [
        "Use Python's min() function on the array",
        "Return the minimum value found",
        "Note: This is O(n) and doesn't leverage the sorted/rotated structure"
      ],
    ),
    optimized: Solution(
      code: """def findMin(nums):
    left = 0
    right = len(nums) - 1

    while left < right:
        mid = left + (right - left) // 2

        # If mid element is greater than right element,
        # minimum is in the right half
        if nums[mid] > nums[right]:
            left = mid + 1
        else:
            # Minimum is in the left half (including mid)
            right = mid

    return nums[left]""",
      timeComplexity: "O(log n)",
      spaceComplexity: "O(1)",
      explanation: "Use binary search. Compare middle element with rightmost element. If mid > right, the minimum is in the right half (rotation point is ahead). Otherwise, minimum is in left half including mid.",
      steps: [
        "Initialize left = 0, right = len(nums) - 1",
        "Binary search loop while left < right:",
        "  - Calculate mid index",
        "  - Compare nums[mid] with nums[right]",
        "  - If nums[mid] > nums[right]:",
        "    - Rotation point is to the right of mid",
        "    - Minimum is in right half: left = mid + 1",
        "  - Otherwise:",
        "    - Minimum is in left half (could be mid itself)",
        "    - Search left including mid: right = mid",
        "When left == right, found minimum",
        "Return nums[left]"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 33,
    title: "Search in Rotated Sorted Array",
    difficulty: Difficulty.medium,
    category: "Binary Search",
    question: """There is an integer array nums sorted in ascending order (with distinct values).

Prior to being passed to your function, nums is possibly rotated at an unknown pivot index k (1 <= k < nums.length) such that the resulting array is [nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]] (0-indexed). For example, [0,1,2,4,5,6,7] might be rotated at pivot index 3 and become [4,5,6,7,0,1,2].

Given the array nums after the possible rotation and an integer target, return the index of target if it is in nums, or -1 if it is not in nums.

You must write an algorithm with O(log n) runtime complexity.

Example 1:
Input: nums = [4,5,6,7,0,1,2], target = 0
Output: 4

Example 2:
Input: nums = [4,5,6,7,0,1,2], target = 3
Output: -1

Example 3:
Input: nums = [1], target = 0
Output: -1

Constraints:
• 1 <= nums.length <= 5000
• -10⁴ <= nums[i] <= 10⁴
• All values of nums are unique.
• nums is an ascending array that is possibly rotated.
• -10⁴ <= target <= 10⁴""",
    bruteForce: Solution(
      code: """def search(nums, target):
    for i in range(len(nums)):
        if nums[i] == target:
            return i
    return -1""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Linear search through the entire array. This works but doesn't meet the O(log n) requirement.",
      steps: [
        "Iterate through array with index i",
        "Check if nums[i] equals target",
        "If match found, return index i",
        "If loop completes without finding target, return -1",
        "Note: This is O(n) and doesn't use the sorted/rotated property"
      ],
    ),
    optimized: Solution(
      code: """def search(nums, target):
    left = 0
    right = len(nums) - 1

    while left <= right:
        mid = left + (right - left) // 2

        if nums[mid] == target:
            return mid

        # Determine which half is sorted
        if nums[left] <= nums[mid]:  # Left half is sorted
            if nums[left] <= target < nums[mid]:
                # Target is in sorted left half
                right = mid - 1
            else:
                # Target is in right half
                left = mid + 1
        else:  # Right half is sorted
            if nums[mid] < target <= nums[right]:
                # Target is in sorted right half
                left = mid + 1
            else:
                # Target is in left half
                right = mid - 1

    return -1""",
      timeComplexity: "O(log n)",
      spaceComplexity: "O(1)",
      explanation: "Modified binary search. At each step, determine which half is properly sorted by comparing left and mid elements. Then check if target is in the sorted half using normal binary search logic. If not, search the other half.",
      steps: [
        "Initialize left = 0, right = len(nums) - 1",
        "Binary search loop while left <= right:",
        "  - Calculate mid index",
        "  - If nums[mid] == target, return mid (found it)",
        "  - Determine which half is sorted:",
        "    - If nums[left] <= nums[mid], left half is sorted",
        "      - If target in range [nums[left], nums[mid]), search left",
        "      - Otherwise, search right",
        "    - Otherwise, right half is sorted",
        "      - If target in range (nums[mid], nums[right]], search right",
        "      - Otherwise, search left",
        "If loop exits, target not found - return -1",
        "Key: One half is always properly sorted, use that to guide search"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 981,
    title: "Time Based Key-Value Store",
    difficulty: Difficulty.medium,
    category: "Binary Search",
    question: """Design a time-based key-value data structure that can store multiple values for the same key at different time stamps and retrieve the key's value at a certain timestamp.

Implement the TimeMap class:
• TimeMap() Initializes the object of the data structure.
• void set(String key, String value, int timestamp) Stores the key key with the value value at the given time timestamp.
• String get(String key, int timestamp) Returns a value such that set was called previously, with timestamp_prev <= timestamp. If there are multiple such values, it returns the value associated with the largest timestamp_prev. If there are no values, it returns "".

Example 1:
Input
["TimeMap", "set", "get", "get", "set", "get", "get"]
[[], ["foo", "bar", 1], ["foo", 1], ["foo", 3], ["foo", "bar2", 4], ["foo", 4], ["foo", 5]]
Output
[null, null, "bar", "bar", null, "bar2", "bar2"]

Explanation
TimeMap timeMap = new TimeMap();
timeMap.set("foo", "bar", 1);  // store the key "foo" and value "bar" along with timestamp = 1.
timeMap.get("foo", 1);         // return "bar"
timeMap.get("foo", 3);         // return "bar", since there is no value corresponding to foo at timestamp 3 and timestamp 2, then the only value is at timestamp 1 is "bar".
timeMap.set("foo", "bar2", 4); // store the key "foo" and value "bar2" along with timestamp = 4.
timeMap.get("foo", 4);         // return "bar2"
timeMap.get("foo", 5);         // return "bar2"

Constraints:
• 1 <= key.length, value.length <= 100
• key and value consist of lowercase English letters and digits.
• 1 <= timestamp <= 10⁷
• All the timestamps timestamp of set are strictly increasing.
• At most 2 * 10⁵ calls will be made to set and get.""",
    bruteForce: Solution(
      code: """class TimeMap:
    def __init__(self):
        self.store = {}  # key -> list of (timestamp, value)

    def set(self, key, value, timestamp):
        if key not in self.store:
            self.store[key] = []
        self.store[key].append((timestamp, value))

    def get(self, key, timestamp):
        if key not in self.store:
            return ""

        values = self.store[key]

        # Linear search from the end
        for i in range(len(values) - 1, -1, -1):
            if values[i][0] <= timestamp:
                return values[i][1]

        return \"""\"

      timeComplexity: "O(1) for set, O(n) for get",
      spaceComplexity: "O(n)",
      explanation: "Store list of (timestamp, value) pairs for each key. For set, append to list. For get, linear search backwards to find largest timestamp <= given timestamp.",
      steps: [
        "Initialize: Create hash map storing key -> list of (timestamp, value) pairs",
        "Set operation:",
        "  - If key not in map, create empty list",
        "  - Append (timestamp, value) to key's list",
        "Get operation:",
        "  - If key not in map, return empty string",
        "  - Get list of (timestamp, value) pairs for key",
        "  - Iterate backwards through list",
        "  - Find first entry where timestamp <= requested timestamp",
        "  - Return the value",
        "  - If no valid entry found, return empty string",
        "Note: Linear search makes get operation O(n)"
      ],
    ),
    optimized: Solution(
      code: """class TimeMap:
    def __init__(self):
        self.store = {}  # key -> list of (timestamp, value)

    def set(self, key, value, timestamp):
        if key not in self.store:
            self.store[key] = []
        self.store[key].append((timestamp, value))

    def get(self, key, timestamp):
        if key not in self.store:
            return ""

        values = self.store[key]
        left, right = 0, len(values) - 1
        result = ""

        while left <= right:
            mid = left + (right - left) // 2

            if values[mid][0] <= timestamp:
                # Valid candidate, try to find larger timestamp
                result = values[mid][1]
                left = mid + 1
            else:
                # Timestamp too large, search left
                right = mid - 1

        return result""",
      timeComplexity: "O(1) for set, O(log n) for get",
      spaceComplexity: "O(n)",
      explanation: "Store list of (timestamp, value) pairs for each key. Since timestamps are strictly increasing, the list is sorted. Use binary search to find the largest timestamp <= given timestamp.",
      steps: [
        "Initialize: Create hash map storing key -> list of (timestamp, value)",
        "Set operation (O(1)):",
        "  - If key not in map, create empty list",
        "  - Append (timestamp, value) to key's list",
        "  - List stays sorted since timestamps are strictly increasing",
        "Get operation (O(log n)):",
        "  - If key not in map, return empty string",
        "  - Binary search to find largest timestamp <= requested",
        "  - Initialize left = 0, right = len(values) - 1, result = ''",
        "  - While left <= right:",
        "    - If values[mid][0] <= timestamp, update result and search right",
        "    - Otherwise, search left",
        "  - Return result",
        "Key: Leverage sorted property for binary search"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 4,
    title: "Median of Two Sorted Arrays",
    difficulty: Difficulty.hard,
    category: "Binary Search",
    question: """Given two sorted arrays nums1 and nums2 of size m and n respectively, return the median of the two sorted arrays.

The overall run time complexity should be O(log (m+n)).

Example 1:
Input: nums1 = [1,3], nums2 = [2]
Output: 2.00000
Explanation: merged array = [1,2,3] and median is 2.

Example 2:
Input: nums1 = [1,2], nums2 = [3,4]
Output: 2.50000
Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.

Constraints:
• nums1.length == m
• nums2.length == n
• 0 <= m <= 1000
• 0 <= n <= 1000
• 1 <= m + n <= 2000
• -10⁶ <= nums1[i], nums2[i] <= 10⁶""",
    bruteForce: Solution(
      code: """def findMedianSortedArrays(nums1, nums2):
    # Merge both arrays
    merged = sorted(nums1 + nums2)
    n = len(merged)

    # Find median
    if n % 2 == 1:
        return float(merged[n // 2])
    else:
        return (merged[n // 2 - 1] + merged[n // 2]) / 2.0""",
      timeComplexity: "O((m+n) log(m+n))",
      spaceComplexity: "O(m+n)",
      explanation: "Merge both arrays and sort. Then find the median based on whether the total length is odd or even. This is simple but doesn't meet the O(log(m+n)) requirement.",
      steps: [
        "Merge both arrays using concatenation: nums1 + nums2",
        "Sort the merged array",
        "Get length n of merged array",
        "If n is odd:",
        "  - Median is middle element: merged[n // 2]",
        "If n is even:",
        "  - Median is average of two middle elements",
        "  - (merged[n // 2 - 1] + merged[n // 2]) / 2",
        "Return median as float",
        "Note: Sorting takes O((m+n) log(m+n)), violates requirement"
      ],
    ),
    optimized: Solution(
      code: """def findMedianSortedArrays(nums1, nums2):
    # Ensure nums1 is the smaller array
    if len(nums1) > len(nums2):
        nums1, nums2 = nums2, nums1

    m, n = len(nums1), len(nums2)
    left, right = 0, m

    while left <= right:
        partition1 = (left + right) // 2
        partition2 = (m + n + 1) // 2 - partition1

        # Handle edge cases
        max_left1 = float('-inf') if partition1 == 0 else nums1[partition1 - 1]
        min_right1 = float('inf') if partition1 == m else nums1[partition1]

        max_left2 = float('-inf') if partition2 == 0 else nums2[partition2 - 1]
        min_right2 = float('inf') if partition2 == n else nums2[partition2]

        # Check if we found the correct partition
        if max_left1 <= min_right2 and max_left2 <= min_right1:
            # Odd total length
            if (m + n) % 2 == 1:
                return float(max(max_left1, max_left2))
            # Even total length
            else:
                return (max(max_left1, max_left2) + min(min_right1, min_right2)) / 2.0
        elif max_left1 > min_right2:
            # Too far right in nums1, go left
            right = partition1 - 1
        else:
            # Too far left in nums1, go right
            left = partition1 + 1

    return 0.0""",
      timeComplexity: "O(log(min(m, n)))",
      spaceComplexity: "O(1)",
      explanation: "Use binary search on the smaller array to find the correct partition point. The partition divides both arrays such that all elements on the left are <= all elements on the right. The median is derived from the elements around the partition.",
      steps: [
        "Ensure nums1 is the smaller array (swap if needed)",
        "Binary search on nums1 with left = 0, right = len(nums1)",
        "For each partition point in nums1:",
        "  - Calculate corresponding partition in nums2 to balance halves",
        "  - Get max of left side and min of right side for both arrays",
        "  - Handle edge cases with infinity values",
        "  - Check if partition is valid: max_left1 <= min_right2 AND max_left2 <= min_right1",
        "  - If valid:",
        "    - Odd total length: return max of left sides",
        "    - Even total length: return average of (max of left sides, min of right sides)",
        "  - If max_left1 > min_right2, move partition left in nums1",
        "  - Otherwise, move partition right in nums1",
        "Continue binary search until valid partition found"
      ],
    ),
  ),

];
