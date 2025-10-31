import '../leetcode_question.dart';

// NeetCode 150 - Sliding Window Category
// 6 questions with complete solutions

final List<LeetCodeQuestion> slidingWindowQuestions = [

  LeetCodeQuestion(
    id: 121,
    title: "Best Time to Buy and Sell Stock",
    difficulty: Difficulty.easy,
    category: "Sliding Window",
    question: """You are given an array prices where prices[i] is the price of a given stock on the ith day.

You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.

Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.

Example 1:
Input: prices = [7,1,5,3,6,4]
Output: 5
Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
Note that buying on day 2 and selling on day 1 is not allowed because you must buy before you sell.

Example 2:
Input: prices = [7,6,4,3,1]
Output: 0
Explanation: In this case, no transactions are done and the max profit = 0.

Constraints:
• 1 <= prices.length <= 10⁵
• 0 <= prices[i] <= 10⁴""",
    bruteForce: Solution(
      code: """def maxProfit(prices):
    max_profit = 0

    for i in range(len(prices)):
        for j in range(i + 1, len(prices)):
            profit = prices[j] - prices[i]
            max_profit = max(max_profit, profit)

    return max_profit""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(1)",
      explanation: "Check every possible buy-sell pair. For each buy day, check all future sell days and calculate profit. Track the maximum profit found.",
      steps: [
        "Initialize max_profit to 0",
        "Use outer loop with index i (buy day) from 0 to len(prices)-1",
        "Use inner loop with index j (sell day) from i+1 to len(prices)-1",
        "Calculate profit as prices[j] - prices[i]",
        "Update max_profit if current profit is larger",
        "Return max_profit after checking all pairs"
      ],
    ),
    optimized: Solution(
      code: """def maxProfit(prices):
    min_price = float('inf')
    max_profit = 0

    for price in prices:
        # Update minimum price seen so far
        min_price = min(min_price, price)

        # Calculate profit if we sell at current price
        profit = price - min_price

        # Update maximum profit
        max_profit = max(max_profit, profit)

    return max_profit""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Track the minimum price seen so far as we iterate. For each price, calculate the profit if we sell at that price (current price - minimum price) and update maximum profit.",
      steps: [
        "Initialize min_price to infinity and max_profit to 0",
        "Iterate through each price in the array",
        "Update min_price to be the minimum of current min_price and current price",
        "Calculate profit if selling at current price: price - min_price",
        "Update max_profit if current profit is larger",
        "Continue for all prices",
        "Return max_profit"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 3,
    title: "Longest Substring Without Repeating Characters",
    difficulty: Difficulty.medium,
    category: "Sliding Window",
    question: """Given a string s, find the length of the longest substring without repeating characters.

Example 1:
Input: s = "abcabcbb"
Output: 3
Explanation: The answer is "abc", with the length of 3.

Example 2:
Input: s = "bbbbb"
Output: 1
Explanation: The answer is "b", with the length of 1.

Example 3:
Input: s = "pwwkew"
Output: 3
Explanation: The answer is "wke", with the length of 3.
Notice that the answer must be a substring, "pwke" is a subsequence and not a substring.

Constraints:
• 0 <= s.length <= 5 * 10⁴
• s consists of English letters, digits, symbols and spaces.""",
    bruteForce: Solution(
      code: """def lengthOfLongestSubstring(s):
    max_length = 0

    for i in range(len(s)):
        seen = set()
        for j in range(i, len(s)):
            if s[j] in seen:
                break
            seen.add(s[j])
            max_length = max(max_length, j - i + 1)

    return max_length""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(min(n, m)) - m is charset size",
      explanation: "For each starting position, expand the substring until we hit a duplicate character. Track the maximum length found.",
      steps: [
        "Initialize max_length to 0",
        "Use outer loop with index i (start of substring)",
        "For each start position, create empty set 'seen'",
        "Use inner loop with index j (end of substring) from i onwards",
        "Check if character at j is already in seen set",
        "If duplicate found, break inner loop",
        "If not duplicate, add character to seen set",
        "Update max_length with current substring length (j - i + 1)",
        "Return max_length after checking all substrings"
      ],
    ),
    optimized: Solution(
      code: """def lengthOfLongestSubstring(s):
    char_index = {}
    max_length = 0
    left = 0

    for right in range(len(s)):
        char = s[right]

        # If char is in window and after left pointer
        if char in char_index and char_index[char] >= left:
            # Move left pointer past the duplicate
            left = char_index[char] + 1

        # Update char's latest index
        char_index[char] = right

        # Update max length
        max_length = max(max_length, right - left + 1)

    return max_length""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(min(n, m)) - m is charset size",
      explanation: "Use sliding window with a hash map storing each character's most recent index. When we find a duplicate, move the left pointer past the previous occurrence of that character.",
      steps: [
        "Initialize char_index hash map, max_length to 0, and left pointer to 0",
        "Use right pointer to iterate through each character",
        "Check if current character is in the window (in map and index >= left)",
        "If duplicate found in current window, move left pointer to char_index[char] + 1",
        "Update character's index in hash map to current position (right)",
        "Calculate current window length: right - left + 1",
        "Update max_length if current length is larger",
        "Continue until end of string",
        "Return max_length"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 424,
    title: "Longest Repeating Character Replacement",
    difficulty: Difficulty.medium,
    category: "Sliding Window",
    question: """You are given a string s and an integer k. You can choose any character of the string and change it to any other uppercase English character. You can perform this operation at most k times.

Return the length of the longest substring containing the same letter you can get after performing the above operations.

Example 1:
Input: s = "ABAB", k = 2
Output: 4
Explanation: Replace the two 'A's with two 'B's or vice versa.

Example 2:
Input: s = "AABABBA", k = 1
Output: 4
Explanation: Replace the one 'A' in the middle with 'B' and form "AABBBBA".
The substring "BBBB" has the longest repeating letters, which is 4.
There may exists other ways to achieve this answer too.

Constraints:
• 1 <= s.length <= 10⁵
• s consists of only uppercase English letters
• 0 <= k <= s.length""",
    bruteForce: Solution(
      code: """def characterReplacement(s, k):
    max_length = 0

    for i in range(len(s)):
        count = {}
        max_freq = 0

        for j in range(i, len(s)):
            # Update count for current character
            count[s[j]] = count.get(s[j], 0) + 1
            max_freq = max(max_freq, count[s[j]])

            # Length of current window
            window_len = j - i + 1

            # Number of replacements needed
            replacements_needed = window_len - max_freq

            if replacements_needed <= k:
                max_length = max(max_length, window_len)
            else:
                break  # Can't extend further from this start

    return max_length""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(1) - max 26 uppercase letters",
      explanation: "For each starting position, expand the window while tracking character frequencies. A window is valid if (window_length - most_frequent_char_count) <= k, meaning we can replace the minority characters.",
      steps: [
        "Initialize max_length to 0",
        "Outer loop with index i (window start)",
        "For each start, create count hash map and max_freq counter",
        "Inner loop with index j (window end) from i onwards",
        "Update count for character at j",
        "Update max_freq if current character's count is highest",
        "Calculate window length: j - i + 1",
        "Calculate replacements needed: window_len - max_freq",
        "If replacements_needed <= k, window is valid - update max_length",
        "If replacements_needed > k, break (can't extend from this start)",
        "Return max_length"
      ],
    ),
    optimized: Solution(
      code: """def characterReplacement(s, k):
    count = {}
    max_length = 0
    max_freq = 0
    left = 0

    for right in range(len(s)):
        # Add right character to window
        count[s[right]] = count.get(s[right], 0) + 1
        max_freq = max(max_freq, count[s[right]])

        # Calculate replacements needed
        window_len = right - left + 1
        replacements_needed = window_len - max_freq

        # If window invalid, shrink from left
        if replacements_needed > k:
            count[s[left]] -= 1
            left += 1
        else:
            # Valid window, update max length
            max_length = max(max_length, window_len)

    return max_length""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1) - max 26 uppercase letters",
      explanation: "Use sliding window with character frequency map. Expand window by moving right pointer. If replacements needed exceeds k, shrink window from left. Track maximum valid window size.",
      steps: [
        "Initialize count map, max_length to 0, max_freq to 0, left pointer to 0",
        "Iterate with right pointer through string",
        "Add character at right to count map",
        "Update max_freq with count of current character",
        "Calculate window length: right - left + 1",
        "Calculate replacements needed: window_len - max_freq",
        "If replacements_needed > k, window is invalid:",
        "  - Decrement count for character at left",
        "  - Move left pointer right to shrink window",
        "If window is valid, update max_length with window length",
        "Continue until end of string",
        "Return max_length"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 567,
    title: "Permutation in String",
    difficulty: Difficulty.medium,
    category: "Sliding Window",
    question: """Given two strings s1 and s2, return true if s2 contains a permutation of s1, or false otherwise.

In other words, return true if one of s1's permutations is the substring of s2.

Example 1:
Input: s1 = "ab", s2 = "eidbaooo"
Output: true
Explanation: s2 contains one permutation of s1 ("ba").

Example 2:
Input: s1 = "ab", s2 = "eidboaoo"
Output: false

Constraints:
• 1 <= s1.length, s2.length <= 10⁴
• s1 and s2 consist of lowercase English letters.""",
    bruteForce: Solution(
      code: """def checkInclusion(s1, s2):
    from collections import Counter

    s1_count = Counter(s1)
    s1_len = len(s1)

    for i in range(len(s2) - s1_len + 1):
        # Get substring of same length as s1
        substring = s2[i:i + s1_len]
        # Check if character frequencies match
        if Counter(substring) == s1_count:
            return True

    return False""",
      timeComplexity: "O(n * m) - n is len(s2), m is len(s1)",
      spaceComplexity: "O(1) - max 26 lowercase letters",
      explanation: "For each possible starting position in s2, extract a substring of length equal to s1 and compare character frequencies. If frequencies match, we found a permutation.",
      steps: [
        "Count character frequencies in s1 using Counter",
        "Store length of s1 for convenience",
        "Iterate through s2 from index 0 to len(s2) - len(s1)",
        "For each position i, extract substring: s2[i:i+s1_len]",
        "Count character frequencies in substring using Counter",
        "Compare substring's Counter with s1's Counter",
        "If they match, we found a permutation - return True",
        "If no match found after checking all positions, return False"
      ],
    ),
    optimized: Solution(
      code: """def checkInclusion(s1, s2):
    if len(s1) > len(s2):
        return False

    # Count frequencies in s1
    s1_count = {}
    for char in s1:
        s1_count[char] = s1_count.get(char, 0) + 1

    # Initialize window count
    window_count = {}
    window_size = len(s1)

    # Initialize first window
    for i in range(window_size):
        char = s2[i]
        window_count[char] = window_count.get(char, 0) + 1

    # Check first window
    if window_count == s1_count:
        return True

    # Slide the window
    for i in range(window_size, len(s2)):
        # Add new character on right
        new_char = s2[i]
        window_count[new_char] = window_count.get(new_char, 0) + 1

        # Remove character on left
        old_char = s2[i - window_size]
        window_count[old_char] -= 1
        if window_count[old_char] == 0:
            del window_count[old_char]

        # Check if current window matches
        if window_count == s1_count:
            return True

    return False""",
      timeComplexity: "O(n) - n is len(s2)",
      spaceComplexity: "O(1) - max 26 lowercase letters",
      explanation: "Use a fixed-size sliding window equal to length of s1. Maintain character frequencies for the current window. Slide window one character at a time, updating frequencies by adding new character and removing old character.",
      steps: [
        "Handle edge case: if s1 longer than s2, return False",
        "Count character frequencies in s1",
        "Initialize window_count hash map for current window",
        "Build initial window of size len(s1) from start of s2",
        "Check if initial window matches s1's frequencies",
        "Slide window through rest of s2:",
        "  - Add new character on right to window_count",
        "  - Remove old character on left from window_count",
        "  - Delete character from map if count becomes 0",
        "  - Compare window_count with s1_count",
        "  - If match found, return True",
        "If no match found after sliding through entire s2, return False"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 76,
    title: "Minimum Window Substring",
    difficulty: Difficulty.hard,
    category: "Sliding Window",
    question: """Given two strings s and t of lengths m and n respectively, return the minimum window substring of s such that every character in t (including duplicates) is included in the window. If there is no such substring, return the empty string "".

The testcases will be generated such that the answer is unique.

Example 1:
Input: s = "ADOBECODEBANC", t = "ABC"
Output: "BANC"
Explanation: The minimum window substring "BANC" includes 'A', 'B', and 'C' from string t.

Example 2:
Input: s = "a", t = "a"
Output: "a"
Explanation: The entire string s is the minimum window.

Example 3:
Input: s = "a", t = "aa"
Output: ""
Explanation: Both 'a's from t must be included in the window.
Since the largest window of s only has one 'a', return empty string.

Constraints:
• m == s.length
• n == t.length
• 1 <= m, n <= 10⁵
• s and t consist of uppercase and lowercase English letters.

Follow up: Could you find an algorithm that runs in O(m + n) time?""",
    bruteForce: Solution(
      code: """def minWindow(s, t):
    from collections import Counter

    t_count = Counter(t)
    min_len = float('inf')
    min_window = ""

    for i in range(len(s)):
        for j in range(i, len(s)):
            substring = s[i:j+1]
            substring_count = Counter(substring)

            # Check if substring contains all chars from t
            valid = True
            for char, count in t_count.items():
                if substring_count[char] < count:
                    valid = False
                    break

            if valid and len(substring) < min_len:
                min_len = len(substring)
                min_window = substring

    return min_window""",
      timeComplexity: "O(n² * m) - n is len(s), m is len(t)",
      spaceComplexity: "O(n + m)",
      explanation: "Check every possible substring of s. For each substring, count character frequencies and verify it contains all characters from t with required frequencies. Track the shortest valid substring.",
      steps: [
        "Count character frequencies in t using Counter",
        "Initialize min_len to infinity and min_window to empty string",
        "Use nested loops to generate all substrings of s",
        "Outer loop with index i (start of substring)",
        "Inner loop with index j (end of substring) from i onwards",
        "Extract substring s[i:j+1] and count its character frequencies",
        "Check if substring contains all characters from t with required counts",
        "If valid and shorter than current min_len, update min_window",
        "Return min_window after checking all substrings"
      ],
    ),
    optimized: Solution(
      code: """def minWindow(s, t):
    if not s or not t:
        return ""

    # Count characters in t
    t_count = {}
    for char in t:
        t_count[char] = t_count.get(char, 0) + 1

    required = len(t_count)  # Unique chars needed
    formed = 0  # Unique chars in window with desired frequency

    window_count = {}
    left = 0
    min_len = float('inf')
    min_left = 0

    for right in range(len(s)):
        # Add character from right
        char = s[right]
        window_count[char] = window_count.get(char, 0) + 1

        # Check if frequency matches
        if char in t_count and window_count[char] == t_count[char]:
            formed += 1

        # Try to shrink window while valid
        while left <= right and formed == required:
            # Update result if smaller window found
            if right - left + 1 < min_len:
                min_len = right - left + 1
                min_left = left

            # Remove character from left
            char = s[left]
            window_count[char] -= 1
            if char in t_count and window_count[char] < t_count[char]:
                formed -= 1
            left += 1

    return "" if min_len == float('inf') else s[min_left:min_left + min_len]""",
      timeComplexity: "O(m + n) - m is len(s), n is len(t)",
      spaceComplexity: "O(m + n)",
      explanation: "Use sliding window with two pointers. Expand window by moving right pointer until all characters from t are included. Then shrink from left while maintaining validity to find minimum window. Track the smallest valid window found.",
      steps: [
        "Handle edge cases: return empty string if s or t is empty",
        "Count character frequencies in t",
        "Track 'required' (unique chars in t) and 'formed' (unique chars satisfied)",
        "Initialize window_count, left pointer, min_len, and min_left",
        "Expand window with right pointer:",
        "  - Add character at right to window_count",
        "  - If char's frequency matches requirement, increment 'formed'",
        "When window is valid (formed == required), try to shrink:",
        "  - Update min_len and min_left if current window is smaller",
        "  - Remove character at left from window",
        "  - If removal breaks requirement, decrement 'formed'",
        "  - Move left pointer right",
        "Return substring from min_left with min_len (or empty if no valid window)"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 239,
    title: "Sliding Window Maximum",
    difficulty: Difficulty.hard,
    category: "Sliding Window",
    question: """You are given an array of integers nums, there is a sliding window of size k which is moving from the very left of the array to the very right. You can only see the k numbers in the window. Each time the sliding window moves right by one position.

Return the max sliding window.

Example 1:
Input: nums = [1,3,-1,-3,5,3,6,7], k = 3
Output: [3,3,5,5,6,7]
Explanation:
Window position                Max
---------------               -----
[1  3  -1] -3  5  3  6  7       3
 1 [3  -1  -3] 5  3  6  7       3
 1  3 [-1  -3  5] 3  6  7       5
 1  3  -1 [-3  5  3] 6  7       5
 1  3  -1  -3 [5  3  6] 7       6
 1  3  -1  -3  5 [3  6  7]      7

Example 2:
Input: nums = [1], k = 1
Output: [1]

Constraints:
• 1 <= nums.length <= 10⁵
• -10⁴ <= nums[i] <= 10⁴
• 1 <= k <= nums.length""",
    bruteForce: Solution(
      code: """def maxSlidingWindow(nums, k):
    result = []

    for i in range(len(nums) - k + 1):
        # Find max in current window
        window_max = max(nums[i:i + k])
        result.append(window_max)

    return result""",
      timeComplexity: "O(n * k)",
      spaceComplexity: "O(1) - excluding output",
      explanation: "For each window position, find the maximum element in the current window of size k using the max() function. This requires scanning k elements for each window.",
      steps: [
        "Initialize empty result list",
        "Iterate through valid window starting positions: 0 to len(nums) - k",
        "For each position i, extract window: nums[i:i+k]",
        "Find maximum element in current window using max() function",
        "Append the maximum to result list",
        "Return result after processing all windows"
      ],
    ),
    optimized: Solution(
      code: """def maxSlidingWindow(nums, k):
    from collections import deque

    result = []
    deq = deque()  # Stores indices

    for i in range(len(nums)):
        # Remove indices outside current window
        while deq and deq[0] < i - k + 1:
            deq.popleft()

        # Remove smaller elements (they won't be max)
        while deq and nums[deq[-1]] < nums[i]:
            deq.pop()

        # Add current index
        deq.append(i)

        # Add max to result (window is fully formed)
        if i >= k - 1:
            result.append(nums[deq[0]])

    return result""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(k)",
      explanation: "Use a deque (double-ended queue) to store indices of elements in decreasing order of their values. The front of the deque always contains the index of the maximum element in the current window. Remove indices outside the window and smaller elements that can't be the maximum.",
      steps: [
        "Import deque and initialize empty result list and deque",
        "Deque stores indices in order of decreasing element values",
        "Iterate through nums with index i",
        "Remove indices from front of deque if they're outside current window (i - k + 1)",
        "Remove indices from back of deque if their values are smaller than nums[i]",
        "  (They can never be maximum while nums[i] is in window)",
        "Add current index i to back of deque",
        "If window is fully formed (i >= k-1), add maximum to result",
        "  Maximum is nums[deq[0]] (front of deque)",
        "Return result array"
      ],
    ),
  ),

];
