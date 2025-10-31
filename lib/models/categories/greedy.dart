import '../leetcode_question.dart';

// NeetCode 150 - Greedy Category
// 8 questions with complete solutions

final List<LeetCodeQuestion> greedyQuestions = [

  LeetCodeQuestion(
    id: 53,
    title: "Maximum Subarray",
    difficulty: Difficulty.medium,
    category: "Greedy",
    question: """Given an integer array nums, find the subarray with the largest sum, and return its sum.

Example 1:
Input: nums = [-2,1,-3,4,-1,2,1,-5,4]
Output: 6
Explanation: The subarray [4,-1,2,1] has the largest sum 6.

Example 2:
Input: nums = [1]
Output: 1
Explanation: The subarray [1] has the largest sum 1.

Example 3:
Input: nums = [5,4,-1,7,8]
Output: 23
Explanation: The subarray [5,4,-1,7,8] has the largest sum 23.

Constraints:
• 1 <= nums.length <= 10⁵
• -10⁴ <= nums[i] <= 10⁴

Follow up: If you have figured out the O(n) solution, try coding another solution using the divide and conquer approach, which is more subtle.""",
    bruteForce: Solution(
      code: """def maxSubArray(nums):
    max_sum = float('-inf')

    for i in range(len(nums)):
        current_sum = 0
        for j in range(i, len(nums)):
            current_sum += nums[j]
            max_sum = max(max_sum, current_sum)

    return max_sum""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(1)",
      explanation: "Try all possible subarrays. For each starting position i, calculate sum of all subarrays starting at i by extending to each ending position j.",
      steps: [
        "Initialize max_sum to negative infinity",
        "For each starting index i:",
        "  - Initialize current_sum to 0",
        "  - For each ending index j from i to end:",
        "    - Add nums[j] to current_sum",
        "    - Update max_sum if current_sum is larger",
        "Return max_sum",
        "Note: O(n²) due to nested loops"
      ],
    ),
    optimized: Solution(
      code: """def maxSubArray(nums):
    max_sum = nums[0]
    current_sum = nums[0]

    for i in range(1, len(nums)):
        # Either extend current subarray or start new one
        current_sum = max(nums[i], current_sum + nums[i])
        max_sum = max(max_sum, current_sum)

    return max_sum""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Kadane's Algorithm. At each position, decide whether to extend the current subarray or start a new one. Keep track of maximum sum seen so far.",
      steps: [
        "Initialize max_sum and current_sum to first element",
        "For each element from index 1 onwards:",
        "  - Decide: extend current subarray (current_sum + nums[i]) or start fresh (nums[i])",
        "  - Update current_sum to the maximum of these two choices",
        "  - Update max_sum if current_sum is larger",
        "Return max_sum",
        "Key: Greedy choice at each step, O(n) single pass",
        "Kadane's Algorithm - classic greedy approach"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 55,
    title: "Jump Game",
    difficulty: Difficulty.medium,
    category: "Greedy",
    question: """You are given an integer array nums. You are initially positioned at the array's first index, and each element in the array represents your maximum jump length at that position.

Return true if you can reach the last index, or false otherwise.

Example 1:
Input: nums = [2,3,1,1,4]
Output: true
Explanation: Jump 1 step from index 0 to 1, then 3 steps to the last index.

Example 2:
Input: nums = [3,2,1,0,4]
Output: false
Explanation: You will always arrive at index 3 no matter what. Its maximum jump length is 0, which makes it impossible to reach the last index.

Constraints:
• 1 <= nums.length <= 10⁴
• 0 <= nums[i] <= 10⁵""",
    bruteForce: Solution(
      code: """def canJump(nums):
    n = len(nums)
    can_reach = [False] * n
    can_reach[0] = True

    for i in range(n):
        if not can_reach[i]:
            continue

        for jump in range(1, nums[i] + 1):
            if i + jump < n:
                can_reach[i + jump] = True

    return can_reach[n - 1]""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(n)",
      explanation: "Track which positions are reachable. For each reachable position, mark all positions within jump range as reachable.",
      steps: [
        "Create boolean array to track reachable positions",
        "Mark starting position as reachable",
        "For each position:",
        "  - If not reachable, skip",
        "  - For each possible jump from this position:",
        "    - Mark destination as reachable",
        "Return whether last position is reachable",
        "Note: O(n²) in worst case"
      ],
    ),
    optimized: Solution(
      code: """def canJump(nums):
    max_reach = 0

    for i in range(len(nums)):
        if i > max_reach:
            return False

        max_reach = max(max_reach, i + nums[i])

    return True""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Track the farthest position we can reach. At each position, update max reachable. If current position is beyond max reach, we can't get there.",
      steps: [
        "Initialize max_reach to 0",
        "For each position i:",
        "  - If i is beyond max_reach, return False (unreachable)",
        "  - Update max_reach to max of current max_reach and i + nums[i]",
        "If we complete the loop, return True",
        "Key: Greedy - track maximum reachable position",
        "Single pass, O(1) space"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 45,
    title: "Jump Game II",
    difficulty: Difficulty.medium,
    category: "Greedy",
    question: """You are given a 0-indexed array of integers nums of length n. You are initially positioned at nums[0].

Each element nums[i] represents the maximum length of a forward jump from index i. In other words, if you are at nums[i], you can jump to any nums[i + j] where:

• 0 <= j <= nums[i] and
• i + j < n

Return the minimum number of jumps to reach nums[n - 1]. The test cases are generated such that you can reach nums[n - 1].

Example 1:
Input: nums = [2,3,1,1,4]
Output: 2
Explanation: The minimum number of jumps to reach the last index is 2. Jump 1 step from index 0 to 1, then 3 steps to the last index.

Example 2:
Input: nums = [2,3,0,1,4]
Output: 2

Constraints:
• 1 <= nums.length <= 10⁴
• 0 <= nums[i] <= 1000
• It's guaranteed that you can reach nums[n - 1].""",
    bruteForce: Solution(
      code: """def jump(nums):
    n = len(nums)
    min_jumps = [float('inf')] * n
    min_jumps[0] = 0

    for i in range(n):
        for jump in range(1, nums[i] + 1):
            if i + jump < n:
                min_jumps[i + jump] = min(min_jumps[i + jump], min_jumps[i] + 1)

    return min_jumps[n - 1]""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(n)",
      explanation: "Dynamic programming approach. For each position, try all possible jumps and update minimum jumps needed to reach each destination.",
      steps: [
        "Create array to track min jumps to each position",
        "Initialize starting position to 0 jumps",
        "For each position i:",
        "  - For each possible jump from i:",
        "    - Update min jumps to destination",
        "    - min_jumps[i + jump] = min(current, min_jumps[i] + 1)",
        "Return min_jumps at last position",
        "Note: O(n²) complexity"
      ],
    ),
    optimized: Solution(
      code: """def jump(nums):
    jumps = 0
    current_end = 0
    farthest = 0

    for i in range(len(nums) - 1):
        farthest = max(farthest, i + nums[i])

        if i == current_end:
            jumps += 1
            current_end = farthest

    return jumps""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Greedy BFS-like approach. Think of jumps as levels. Track the farthest we can reach in current level. When we reach end of current level, increment jumps and move to next level.",
      steps: [
        "Initialize jumps, current_end (end of current jump), farthest",
        "For each position except last:",
        "  - Update farthest reachable position",
        "  - If we've reached end of current jump:",
        "    - Increment jump count",
        "    - Move current_end to farthest (start next jump)",
        "Return total jumps",
        "Key: Greedy BFS approach, each jump is a level",
        "O(n) time, O(1) space"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 134,
    title: "Gas Station",
    difficulty: Difficulty.medium,
    category: "Greedy",
    question: """There are n gas stations along a circular route, where the amount of gas at the ith station is gas[i].

You have a car with an unlimited gas tank and it costs cost[i] of gas to travel from the ith station to its next (i + 1)th station. You begin the journey with an empty tank at one of the gas stations.

Given two integer arrays gas and cost, return the starting gas station's index if you can travel around the circuit once in the clockwise direction, otherwise return -1. If there exists a solution, it is guaranteed to be unique.

Example 1:
Input: gas = [1,2,3,4,5], cost = [3,4,5,1,2]
Output: 3
Explanation: Start at station 3 (index 3) and fill up with 4 unit of gas. Your tank = 0 + 4 = 4. Travel to station 4. Your tank = 4 - 1 + 5 = 8. Travel to station 0. Your tank = 8 - 2 + 1 = 7. Travel to station 1. Your tank = 7 - 3 + 2 = 6. Travel to station 2. Your tank = 6 - 4 + 3 = 5. Travel to station 3. The cost is 5. Your gas is just enough to travel back to station 3. Therefore, return 3 as the starting index.

Example 2:
Input: gas = [2,3,4], cost = [3,4,3]
Output: -1
Explanation: You can't start at station 0 or 1, as there is not enough gas to travel to the next station. Let's start at station 2 and fill up with 4 unit of gas. Your tank = 0 + 4 = 4. Travel to station 0. Your tank = 4 - 3 + 2 = 3. Travel to station 1. Your tank = 3 - 3 + 3 = 3. You cannot travel back to station 2, as it requires 4 unit of gas but you only have 3. Therefore, you can't travel around the circuit once no matter where you start.

Constraints:
• n == gas.length == cost.length
• 1 <= n <= 10⁵
• 0 <= gas[i], cost[i] <= 10⁴""",
    bruteForce: Solution(
      code: """def canCompleteCircuit(gas, cost):
    n = len(gas)

    for start in range(n):
        tank = 0
        stations_visited = 0
        current = start

        while stations_visited < n:
            tank += gas[current]
            tank -= cost[current]

            if tank < 0:
                break

            current = (current + 1) % n
            stations_visited += 1

        if stations_visited == n:
            return start

    return -1""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(1)",
      explanation: "Try each station as starting point. Simulate the journey from that station. If we complete the circuit, return that station.",
      steps: [
        "For each possible starting station:",
        "  - Initialize tank to 0",
        "  - Simulate journey station by station:",
        "    - Add gas at current station",
        "    - Subtract cost to next station",
        "    - If tank becomes negative, break",
        "  - If completed full circuit, return this start",
        "If no valid start found, return -1",
        "Note: O(n²) - tries each start, each simulation is O(n)"
      ],
    ),
    optimized: Solution(
      code: """def canCompleteCircuit(gas, cost):
    total_tank = 0
    current_tank = 0
    start = 0

    for i in range(len(gas)):
        total_tank += gas[i] - cost[i]
        current_tank += gas[i] - cost[i]

        if current_tank < 0:
            start = i + 1
            current_tank = 0

    return start if total_tank >= 0 else -1""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Key insight: if total gas >= total cost, solution exists. If we can't reach station j from i, then any station between i and j also can't reach j. So next candidate is j+1.",
      steps: [
        "Track total_tank (total gas - total cost) and current_tank",
        "Assume start at station 0",
        "For each station:",
        "  - Add net gas (gas[i] - cost[i]) to both tanks",
        "  - If current_tank becomes negative:",
        "    - Can't start from current start",
        "    - Reset start to next station (i + 1)",
        "    - Reset current_tank to 0",
        "If total_tank >= 0, return start, else -1",
        "Key: Greedy - single pass determines unique start",
        "Mathematical proof ensures correctness"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 846,
    title: "Hand of Straights",
    difficulty: Difficulty.medium,
    category: "Greedy",
    question: """Alice has some number of cards and she wants to rearrange the cards into groups so that each group is of size groupSize, and consists of groupSize consecutive cards.

Given an integer array hand where hand[i] is the value written on the ith card and an integer groupSize, return true if she can rearrange the cards, or false otherwise.

Example 1:
Input: hand = [1,2,3,6,2,3,4,7,8], groupSize = 3
Output: true
Explanation: Alice's hand can be rearranged as [1,2,3],[2,3,4],[6,7,8]

Example 2:
Input: hand = [1,2,3,4,5], groupSize = 4
Output: false
Explanation: Alice's hand can't be rearranged into groups of 4.

Constraints:
• 1 <= hand.length <= 10⁴
• 0 <= hand[i] <= 10⁹
• 1 <= groupSize <= hand.length

Note: This question is the same as 1296: https://leetcode.com/problems/divide-array-in-sets-of-k-consecutive-numbers/""",
    bruteForce: Solution(
      code: """def isNStraightHand(hand, groupSize):
    if len(hand) % groupSize != 0:
        return False

    hand.sort()

    while hand:
        if len(hand) < groupSize:
            return False

        first = hand[0]
        group = [first]
        hand.remove(first)

        for i in range(1, groupSize):
            next_card = first + i
            if next_card in hand:
                group.append(next_card)
                hand.remove(next_card)
            else:
                return False

    return True""",
      timeComplexity: "O(n² log n)",
      spaceComplexity: "O(1)",
      explanation: "Sort cards, repeatedly try to form groups starting with smallest card. Use list.remove() which is O(n). Very inefficient.",
      steps: [
        "Check if total cards divisible by groupSize",
        "Sort the hand",
        "While cards remain:",
        "  - Take smallest card",
        "  - Try to find next groupSize-1 consecutive cards",
        "  - Remove each card from hand (O(n) operation)",
        "  - If can't form group, return False",
        "Return True if all groups formed",
        "Note: remove() is O(n), called O(n) times = O(n²)"
      ],
    ),
    optimized: Solution(
      code: """def isNStraightHand(hand, groupSize):
    if len(hand) % groupSize != 0:
        return False

    from collections import Counter
    count = Counter(hand)

    for card in sorted(count.keys()):
        if count[card] > 0:
            needed = count[card]

            for i in range(groupSize):
                if count[card + i] < needed:
                    return False
                count[card + i] -= needed

    return True""",
      timeComplexity: "O(n log n)",
      spaceComplexity: "O(n)",
      explanation: "Use Counter to track card frequencies. Sort unique cards. For each card with count > 0, try to form that many groups starting with this card.",
      steps: [
        "Check if length divisible by groupSize",
        "Create Counter of card frequencies",
        "Sort unique card values",
        "For each card in sorted order:",
        "  - If count > 0, need to form that many groups starting here",
        "  - Check if next groupSize-1 cards have enough count",
        "  - Decrease count for all cards in the group",
        "  - If any card insufficient, return False",
        "Return True if all groups formed",
        "Key: Counter + sorting, O(n log n) time"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 1899,
    title: "Merge Triplets to Form Target Triplet",
    difficulty: Difficulty.medium,
    category: "Greedy",
    question: """A triplet is an array of three integers. You are given a 2D integer array triplets, where triplets[i] = [ai, bi, ci] describes the ith triplet. You are also given an integer array target = [x, y, z] that describes the triplet you want to obtain.

To obtain target, you may apply the following operation on triplets any number of times (possibly zero):

Choose two indices (0-indexed) i and j (i != j) and update triplets[j] to become [max(ai, aj), max(bi, bj), max(ci, cj)].

For example, if triplets[i] = [2, 5, 3] and triplets[j] = [1, 7, 5], triplets[j] will be updated to [max(2, 1), max(5, 7), max(3, 5)] = [2, 7, 5].

Return true if it is possible to obtain the target triplet [x, y, z] as an element of triplets, or false otherwise.

Example 1:
Input: triplets = [[2,5,3],[1,8,4],[1,7,5]], target = [2,7,5]
Output: true
Explanation: Perform the following operations:
- Choose the first and last triplets [[2,5,3],[1,8,4],[1,7,5]]. Update the last triplet to be [max(2,1), max(5,7), max(3,5)] = [2,7,5]. triplets = [[2,5,3],[1,8,4],[2,7,5]]
The target triplet [2,7,5] is now an element of triplets.

Example 2:
Input: triplets = [[3,4,5],[4,5,6]], target = [3,2,5]
Output: false
Explanation: It is impossible to have [3,2,5] as an element because there is no 2 in any of the triplets.

Example 3:
Input: triplets = [[2,5,3],[2,3,4],[1,2,5],[5,2,3]], target = [5,5,5]
Output: true
Explanation: Perform the following operations:
- Choose the first and fourth triplets [[2,5,3],[2,3,4],[1,2,5],[5,2,3]]. Update the fourth triplet to be [max(2,5), max(5,2), max(3,3)] = [5,5,3]. triplets = [[2,5,3],[2,3,4],[1,2,5],[5,5,3]].
- Choose the third and fourth triplets [[2,5,3],[2,3,4],[1,2,5],[5,5,3]]. Update the fourth triplet to be [max(1,5), max(2,5), max(5,3)] = [5,5,5]. triplets = [[2,5,3],[2,3,4],[1,2,5],[5,5,5]].
The target triplet [5,5,5] is now an element of triplets.

Constraints:
• 1 <= triplets.length <= 10⁵
• triplets[i].length == target.length == 3
• 1 <= ai, bi, ci, x, y, z <= 1000""",
    bruteForce: Solution(
      code: """def mergeTriplets(triplets, target):
    from itertools import combinations

    n = len(triplets)

    # Try all possible combinations
    for size in range(1, n + 1):
        for combo in combinations(range(n), size):
            result = [0, 0, 0]

            for idx in combo:
                result[0] = max(result[0], triplets[idx][0])
                result[1] = max(result[1], triplets[idx][1])
                result[2] = max(result[2], triplets[idx][2])

            if result == target:
                return True

    return False""",
      timeComplexity: "O(2ⁿ * n)",
      spaceComplexity: "O(n)",
      explanation: "Try all possible combinations of triplets, compute max for each position, check if equals target. Exponential time complexity.",
      steps: [
        "Generate all possible subsets of triplets",
        "For each subset:",
        "  - Compute element-wise maximum",
        "  - Check if result equals target",
        "  - If yes, return True",
        "If no combination works, return False",
        "Note: 2ⁿ combinations, exponential complexity"
      ],
    ),
    optimized: Solution(
      code: """def mergeTriplets(triplets, target):
    found = [False, False, False]

    for triplet in triplets:
        # Skip if any value exceeds target (can't use this triplet)
        if (triplet[0] > target[0] or
            triplet[1] > target[1] or
            triplet[2] > target[2]):
            continue

        # Mark which target values we can achieve
        if triplet[0] == target[0]:
            found[0] = True
        if triplet[1] == target[1]:
            found[1] = True
        if triplet[2] == target[2]:
            found[2] = True

    return all(found)""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Key insight: we can only use triplets where no value exceeds target (since we can only increase values). Check if we can find target[i] in position i across valid triplets.",
      steps: [
        "Track which target positions we can achieve",
        "For each triplet:",
        "  - Skip if any value exceeds corresponding target value",
        "  - For valid triplets, mark which target values match",
        "  - If triplet[i] == target[i], mark found[i] = True",
        "Return True if all three positions found",
        "Key: Greedy - just need one triplet with target[i] in position i",
        "No need to try combinations, O(n) single pass"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 763,
    title: "Partition Labels",
    difficulty: Difficulty.medium,
    category: "Greedy",
    question: """You are given a string s. We want to partition the string into as many parts as possible so that each letter appears in at most one part.

Note that the partition is done so that after concatenating all the parts in order, the resultant string should be s.

Return a list of integers representing the size of these parts.

Example 1:
Input: s = "ababcbacadefegdehijhklij"
Output: [9,7,8]
Explanation:
The partition is "ababcbaca", "defegde", "hijhklij".
This is a partition so that each letter appears in at most one part.
A partition like "ababcbacadefegde", "hijhklij" is incorrect, because it splits s into less parts.

Example 2:
Input: s = "eccbbbbdec"
Output: [10]

Constraints:
• 1 <= s.length <= 500
• s consists of lowercase English letters.""",
    bruteForce: Solution(
      code: """def partitionLabels(s):
    result = []
    start = 0

    while start < len(s):
        end = start
        chars_in_partition = set()

        # Keep extending partition until all chars contained
        while True:
            # Add chars in current range
            for i in range(start, end + 1):
                chars_in_partition.add(s[i])

            # Find last occurrence of any char in partition
            max_end = end
            for char in chars_in_partition:
                for i in range(len(s) - 1, start - 1, -1):
                    if s[i] == char:
                        max_end = max(max_end, i)
                        break

            if max_end == end:
                break

            end = max_end

        result.append(end - start + 1)
        start = end + 1

    return result""",
      timeComplexity: "O(n³)",
      spaceComplexity: "O(n)",
      explanation: "For each partition, repeatedly extend until all characters' last occurrences are included. Very inefficient with multiple scans.",
      steps: [
        "Start from beginning",
        "For each partition:",
        "  - Track all characters in current partition",
        "  - Find last occurrence of each character",
        "  - Extend partition to include all last occurrences",
        "  - Repeat until no extension needed",
        "Add partition size to result",
        "Move start to next position",
        "Note: Multiple scans make this O(n³)"
      ],
    ),
    optimized: Solution(
      code: """def partitionLabels(s):
    # Precompute last occurrence of each character
    last_occurrence = {}
    for i, char in enumerate(s):
        last_occurrence[char] = i

    result = []
    start = 0
    end = 0

    for i, char in enumerate(s):
        end = max(end, last_occurrence[char])

        if i == end:
            result.append(end - start + 1)
            start = i + 1

    return result""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1) - only 26 letters",
      explanation: "Precompute last occurrence of each character. Use greedy approach: extend partition end to include last occurrence of current character. When we reach partition end, start new partition.",
      steps: [
        "First pass: store last occurrence index for each character",
        "Initialize start = 0, end = 0",
        "For each character at index i:",
        "  - Update end to max of current end and last occurrence of this char",
        "  - If i equals end, we've reached partition boundary:",
        "    - Add partition size to result",
        "    - Move start to next position",
        "Return result",
        "Key: Greedy - extend partition greedily, O(n) two-pass"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 678,
    title: "Valid Parenthesis String",
    difficulty: Difficulty.medium,
    category: "Greedy",
    question: """Given a string s containing only three types of characters: '(', ')' and '*', return true if s is valid.

The following rules define a valid string:

• Any left parenthesis '(' must have a corresponding right parenthesis ')'.
• Any right parenthesis ')' must have a corresponding left parenthesis '('.
• Left parenthesis '(' must go before the corresponding right parenthesis ')'.
• '*' could be treated as a single right parenthesis ')' or a single left parenthesis '(' or an empty string "".

Example 1:
Input: s = "()"
Output: true

Example 2:
Input: s = "(*)"
Output: true

Example 3:
Input: s = "(*))"
Output: true

Constraints:
• 1 <= s.length <= 100
• s[i] is '(', ')' or '*'.""",
    bruteForce: Solution(
      code: """def checkValidString(s):
    def isValid(s, i, count):
        if count < 0:
            return False

        if i == len(s):
            return count == 0

        if s[i] == '(':
            return isValid(s, i + 1, count + 1)
        elif s[i] == ')':
            return isValid(s, i + 1, count - 1)
        else:  # '*'
            # Try all three options
            return (isValid(s, i + 1, count + 1) or  # '('
                    isValid(s, i + 1, count - 1) or  # ')'
                    isValid(s, i + 1, count))        # empty

    return isValid(s, 0, 0)""",
      timeComplexity: "O(3ⁿ)",
      spaceComplexity: "O(n)",
      explanation: "Recursively try all three possibilities for each '*'. Exponential time complexity due to branching.",
      steps: [
        "Use recursion with current index and open parenthesis count",
        "Base case: if count negative, invalid",
        "Base case: at end of string, check if count is 0",
        "If '(', increment count and recurse",
        "If ')', decrement count and recurse",
        "If '*', try all three options:",
        "  - Treat as '(' (count + 1)",
        "  - Treat as ')' (count - 1)",
        "  - Treat as empty (count unchanged)",
        "Note: Exponential branching, O(3ⁿ)"
      ],
    ),
    optimized: Solution(
      code: """def checkValidString(s):
    # Track range of possible open parentheses count
    min_open = 0
    max_open = 0

    for char in s:
        if char == '(':
            min_open += 1
            max_open += 1
        elif char == ')':
            min_open -= 1
            max_open -= 1
        else:  # '*'
            min_open -= 1  # Treat as ')'
            max_open += 1  # Treat as '('

        if max_open < 0:
            return False

        min_open = max(min_open, 0)

    return min_open == 0""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Track range of possible open parentheses counts. min_open is minimum (treat * as ')' or empty), max_open is maximum (treat * as '('). Valid if 0 is in final range.",
      steps: [
        "Maintain min_open and max_open (range of possible open count)",
        "For each character:",
        "  - '(': increase both min and max",
        "  - ')': decrease both min and max",
        "  - '*': decrease min (worst case), increase max (best case)",
        "If max_open < 0, too many ')', return False",
        "Keep min_open >= 0 (can't go negative)",
        "At end, check if min_open == 0 (can balance to 0)",
        "Key: Track range instead of all possibilities",
        "Greedy approach, O(n) single pass"
      ],
    ),
  ),

];
