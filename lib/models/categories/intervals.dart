import '../leetcode_question.dart';

// NeetCode 150 - Intervals Category
// 6 questions with complete solutions

final List<LeetCodeQuestion> intervalsQuestions = [

  LeetCodeQuestion(
    id: 57,
    title: "Insert Interval",
    difficulty: Difficulty.medium,
    category: "Intervals",
    question: """You are given an array of non-overlapping intervals intervals where intervals[i] = [starti, endi] represent the start and the end of the ith interval and intervals is sorted in ascending order by starti. You are also given an interval newInterval = [start, end] that represents the start and end of another interval.

Insert newInterval into intervals such that intervals is still sorted in ascending order by starti and intervals still does not have any overlapping intervals (merge overlapping intervals if necessary).

Return intervals after the insertion.

Example 1:
Input: intervals = [[1,3],[6,9]], newInterval = [2,5]
Output: [[1,5],[6,9]]

Example 2:
Input: intervals = [[1,2],[3,5],[6,7],[8,10],[12,16]], newInterval = [4,8]
Output: [[1,2],[3,10],[12,16]]
Explanation: Because the new interval [4,8] overlaps with [3,5],[6,7],[8,10].

Constraints:
• 0 <= intervals.length <= 10⁴
• intervals[i].length == 2
• 0 <= starti <= endi <= 10⁵
• intervals is sorted by starti in ascending order.
• newInterval.length == 2
• 0 <= start <= end <= 10⁵""",
    bruteForce: Solution(
      code: """def insert(intervals, newInterval):
    # Add new interval and sort
    intervals.append(newInterval)
    intervals.sort()

    # Merge overlapping intervals
    merged = []

    for interval in intervals:
        if not merged or merged[-1][1] < interval[0]:
            merged.append(interval)
        else:
            merged[-1][1] = max(merged[-1][1], interval[1])

    return merged""",
      timeComplexity: "O(n log n)",
      spaceComplexity: "O(n)",
      explanation: "Add new interval to list, sort all intervals, then merge overlapping ones. Sorting makes this inefficient.",
      steps: [
        "Add newInterval to intervals list",
        "Sort all intervals by start time",
        "Initialize empty merged list",
        "For each interval:",
        "  - If doesn't overlap with last merged, add it",
        "  - If overlaps, merge by updating end time of last interval",
        "Return merged intervals",
        "Note: O(n log n) due to sorting"
      ],
    ),
    optimized: Solution(
      code: """def insert(intervals, newInterval):
    result = []
    i = 0
    n = len(intervals)

    # Add all intervals before newInterval
    while i < n and intervals[i][1] < newInterval[0]:
        result.append(intervals[i])
        i += 1

    # Merge overlapping intervals with newInterval
    while i < n and intervals[i][0] <= newInterval[1]:
        newInterval[0] = min(newInterval[0], intervals[i][0])
        newInterval[1] = max(newInterval[1], intervals[i][1])
        i += 1

    result.append(newInterval)

    # Add remaining intervals
    while i < n:
        result.append(intervals[i])
        i += 1

    return result""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Use the fact that intervals are already sorted. Three phases: add non-overlapping before, merge overlapping, add non-overlapping after.",
      steps: [
        "Phase 1: Add all intervals that end before newInterval starts",
        "Phase 2: Merge all intervals that overlap with newInterval",
        "  - Update newInterval bounds to include all overlapping intervals",
        "Phase 3: Add merged newInterval",
        "Phase 4: Add all remaining intervals",
        "Return result",
        "Key: Leverage sorted property, O(n) single pass"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 56,
    title: "Merge Intervals",
    difficulty: Difficulty.medium,
    category: "Intervals",
    question: """Given an array of intervals where intervals[i] = [starti, endi], merge all overlapping intervals, and return an array of the non-overlapping intervals that cover all the intervals in the input.

Example 1:
Input: intervals = [[1,3],[2,6],[8,10],[15,18]]
Output: [[1,6],[8,10],[15,18]]
Explanation: Since intervals [1,3] and [2,6] overlap, merge them into [1,6].

Example 2:
Input: intervals = [[1,4],[4,5]]
Output: [[1,5]]
Explanation: Intervals [1,4] and [4,5] are considered overlapping.

Constraints:
• 1 <= intervals.length <= 10⁴
• intervals[i].length == 2
• 0 <= starti <= endi <= 10⁴""",
    bruteForce: Solution(
      code: """def merge(intervals):
    # Keep merging until no more changes
    changed = True

    while changed:
        changed = False
        merged = []
        i = 0

        while i < len(intervals):
            current = intervals[i]
            j = i + 1

            # Find first overlapping interval
            while j < len(intervals):
                if (intervals[j][0] <= current[1] and
                    intervals[j][1] >= current[0]):
                    # Merge
                    current = [min(current[0], intervals[j][0]),
                               max(current[1], intervals[j][1])]
                    intervals.pop(j)
                    changed = True
                else:
                    j += 1

            merged.append(current)
            i += 1

        intervals = merged

    return intervals""",
      timeComplexity: "O(n³)",
      spaceComplexity: "O(n)",
      explanation: "Repeatedly scan for overlapping intervals and merge them. Continue until no changes. Very inefficient with multiple passes.",
      steps: [
        "Repeat until no changes:",
        "  - For each interval:",
        "    - Scan remaining intervals for overlaps",
        "    - Merge if overlap found",
        "    - Mark changed = True",
        "  - Replace intervals with merged list",
        "Return final merged intervals",
        "Note: Multiple passes, O(n³) worst case"
      ],
    ),
    optimized: Solution(
      code: """def merge(intervals):
    intervals.sort(key=lambda x: x[0])
    merged = [intervals[0]]

    for i in range(1, len(intervals)):
        if intervals[i][0] <= merged[-1][1]:
            # Overlapping, merge
            merged[-1][1] = max(merged[-1][1], intervals[i][1])
        else:
            # Non-overlapping, add new interval
            merged.append(intervals[i])

    return merged""",
      timeComplexity: "O(n log n)",
      spaceComplexity: "O(n)",
      explanation: "Sort intervals by start time. Then iterate once, merging consecutive overlapping intervals.",
      steps: [
        "Sort intervals by start time",
        "Initialize merged with first interval",
        "For each remaining interval:",
        "  - If overlaps with last merged interval:",
        "    - Extend last merged interval's end time",
        "  - Else:",
        "    - Add as new interval to merged",
        "Return merged",
        "Key: Sorting enables O(n) merge pass",
        "Total: O(n log n) for sort + O(n) for merge"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 435,
    title: "Non-overlapping Intervals",
    difficulty: Difficulty.medium,
    category: "Intervals",
    question: """Given an array of intervals intervals where intervals[i] = [starti, endi], return the minimum number of intervals you need to remove to make the rest of the intervals non-overlapping.

Example 1:
Input: intervals = [[1,2],[2,3],[3,4],[1,3]]
Output: 1
Explanation: [1,3] can be removed and the rest of the intervals are non-overlapping.

Example 2:
Input: intervals = [[1,2],[1,2],[1,2]]
Output: 2
Explanation: You need to remove two [1,2] to make the rest of the intervals non-overlapping.

Example 3:
Input: intervals = [[1,2],[2,3]]
Output: 0
Explanation: You don't need to remove any of the intervals since they're already non-overlapping.

Constraints:
• 1 <= intervals.length <= 10⁵
• intervals[i].length == 2
• -5 * 10⁴ <= starti < endi <= 5 * 10⁴""",
    bruteForce: Solution(
      code: """def eraseOverlapIntervals(intervals):
    def countNonOverlapping(intervals):
        if not intervals:
            return 0

        intervals.sort()
        count = 1
        end = intervals[0][1]

        for i in range(1, len(intervals)):
            if intervals[i][0] >= end:
                count += 1
                end = intervals[i][1]
            else:
                end = min(end, intervals[i][1])

        return count

    # Try removing each subset and check if non-overlapping
    n = len(intervals)
    max_keep = 0

    from itertools import combinations
    for size in range(n, 0, -1):
        for combo in combinations(range(n), size):
            subset = [intervals[i] for i in combo]

            # Check if this subset is non-overlapping
            subset.sort()
            is_valid = True

            for i in range(1, len(subset)):
                if subset[i][0] < subset[i-1][1]:
                    is_valid = False
                    break

            if is_valid:
                return n - size

    return n""",
      timeComplexity: "O(2ⁿ * n log n)",
      spaceComplexity: "O(n)",
      explanation: "Try all possible subsets of intervals, check if non-overlapping, find maximum size. Exponential complexity.",
      steps: [
        "Try subsets in decreasing size order",
        "For each subset:",
        "  - Sort the intervals",
        "  - Check if non-overlapping",
        "  - If yes, return (total - subset size)",
        "Note: 2ⁿ subsets, exponential"
      ],
    ),
    optimized: Solution(
      code: """def eraseOverlapIntervals(intervals):
    intervals.sort(key=lambda x: x[1])  # Sort by end time

    count = 0
    end = float('-inf')

    for interval in intervals:
        if interval[0] >= end:
            # Non-overlapping, keep it
            end = interval[1]
        else:
            # Overlapping, remove it
            count += 1

    return count""",
      timeComplexity: "O(n log n)",
      spaceComplexity: "O(n)",
      explanation: "Greedy approach: sort by end time. Always keep interval with earliest end time. This maximizes number of non-overlapping intervals we can keep.",
      steps: [
        "Sort intervals by end time (greedy choice)",
        "Initialize removal count and current end time",
        "For each interval:",
        "  - If doesn't overlap with previous (start >= end):",
        "    - Keep it, update end time",
        "  - Else:",
        "    - Remove it, increment count",
        "Return removal count",
        "Key: Greedy - earliest end time maximizes room for others",
        "O(n log n) for sorting"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 252,
    title: "Meeting Rooms",
    difficulty: Difficulty.easy,
    category: "Intervals",
    question: """Given an array of meeting time intervals where intervals[i] = [starti, endi], determine if a person could attend all meetings.

Example 1:
Input: intervals = [[0,30],[5,10],[15,20]]
Output: false

Example 2:
Input: intervals = [[7,10],[2,4]]
Output: true

Constraints:
• 0 <= intervals.length <= 10⁴
• intervals[i].length == 2
• 0 <= starti < endi <= 10⁶""",
    bruteForce: Solution(
      code: """def canAttendMeetings(intervals):
    # Check every pair for overlap
    for i in range(len(intervals)):
        for j in range(i + 1, len(intervals)):
            # Check if intervals overlap
            if (intervals[i][0] < intervals[j][1] and
                intervals[j][0] < intervals[i][1]):
                return False

    return True""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(1)",
      explanation: "Check every pair of intervals to see if they overlap. Quadratic time complexity.",
      steps: [
        "For each pair of intervals (i, j):",
        "  - Check if they overlap",
        "  - Overlap if: start_i < end_j AND start_j < end_i",
        "  - If any overlap found, return False",
        "If no overlaps, return True",
        "Note: O(n²) comparisons"
      ],
    ),
    optimized: Solution(
      code: """def canAttendMeetings(intervals):
    if not intervals:
        return True

    intervals.sort(key=lambda x: x[0])

    for i in range(1, len(intervals)):
        if intervals[i][0] < intervals[i-1][1]:
            return False

    return True""",
      timeComplexity: "O(n log n)",
      spaceComplexity: "O(n)",
      explanation: "Sort by start time. Then just check if each meeting starts before previous one ends. If sorted, only need to check adjacent pairs.",
      steps: [
        "Handle empty case",
        "Sort intervals by start time",
        "For each interval from index 1:",
        "  - Check if it starts before previous ends",
        "  - If intervals[i][0] < intervals[i-1][1], overlap exists",
        "  - Return False",
        "If no overlaps found, return True",
        "Key: Sorting allows checking only adjacent intervals",
        "O(n log n) for sort, O(n) for check"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 253,
    title: "Meeting Rooms II",
    difficulty: Difficulty.medium,
    category: "Intervals",
    question: """Given an array of meeting time intervals intervals where intervals[i] = [starti, endi], return the minimum number of conference rooms required.

Example 1:
Input: intervals = [[0,30],[5,10],[15,20]]
Output: 2

Example 2:
Input: intervals = [[7,10],[2,4]]
Output: 1

Constraints:
• 1 <= intervals.length <= 10⁴
• 0 <= starti < endi <= 10⁶""",
    bruteForce: Solution(
      code: """def minMeetingRooms(intervals):
    max_rooms = 0

    # For each time point, count concurrent meetings
    times = set()
    for interval in intervals:
        times.add(interval[0])
        times.add(interval[1])

    for time in times:
        concurrent = 0

        for interval in intervals:
            if interval[0] <= time < interval[1]:
                concurrent += 1

        max_rooms = max(max_rooms, concurrent)

    return max_rooms""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(n)",
      explanation: "For each unique time point, count how many meetings are active. Return maximum. Inefficient due to checking all intervals for each time.",
      steps: [
        "Collect all unique start and end times",
        "For each unique time point:",
        "  - Count meetings active at this time",
        "  - Meeting active if: start <= time < end",
        "  - Update maximum rooms needed",
        "Return maximum",
        "Note: O(n) time points × O(n) intervals = O(n²)"
      ],
    ),
    optimized: Solution(
      code: """def minMeetingRooms(intervals):
    if not intervals:
        return 0

    # Separate and sort start and end times
    starts = sorted([interval[0] for interval in intervals])
    ends = sorted([interval[1] for interval in intervals])

    rooms = 0
    max_rooms = 0
    start_ptr = 0
    end_ptr = 0

    while start_ptr < len(intervals):
        if starts[start_ptr] < ends[end_ptr]:
            # Meeting starting, need a room
            rooms += 1
            max_rooms = max(max_rooms, rooms)
            start_ptr += 1
        else:
            # Meeting ending, free a room
            rooms -= 1
            end_ptr += 1

    return max_rooms""",
      timeComplexity: "O(n log n)",
      spaceComplexity: "O(n)",
      explanation: "Chronological ordering approach. Process all start and end events in chronological order. Track concurrent meetings using two pointers.",
      steps: [
        "Extract and sort all start times",
        "Extract and sort all end times",
        "Use two pointers for starts and ends",
        "Initialize rooms counter and max_rooms",
        "Process events chronologically:",
        "  - If next event is start (starts[i] < ends[j]):",
        "    - Increment rooms, update max",
        "  - Else (meeting ending):",
        "    - Decrement rooms",
        "Return max_rooms",
        "Key: Chronological processing with two pointers",
        "O(n log n) for sorting"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 1851,
    title: "Minimum Interval to Include Each Query",
    difficulty: Difficulty.hard,
    category: "Intervals",
    question: """You are given a 2D integer array intervals, where intervals[i] = [lefti, righti] describes the ith interval starting at lefti and ending at righti (inclusive). The size of an interval is defined as the number of integers it contains, or more formally righti - lefti + 1.

You are also given an integer array queries. The answer to the jth query is the size of the smallest interval i such that lefti <= queries[j] <= righti. If no such interval exists, the answer is -1.

Return an array containing the answers to the queries.

Example 1:
Input: intervals = [[1,4],[2,4],[3,6],[4,4]], queries = [2,3,4,5]
Output: [3,3,1,4]
Explanation:
- The smallest interval containing 2 is [2,4] with size 3.
- The smallest interval containing 3 is [2,4] with size 3.
- The smallest interval containing 4 is [4,4] with size 1.
- The smallest interval containing 5 is [3,6] with size 4.

Example 2:
Input: intervals = [[2,3],[2,5],[1,8],[20,25]], queries = [2,19,5,22]
Output: [2,-1,4,6]
Explanation:
- The smallest interval containing 2 is [2,3] with size 2.
- No interval contains 19.
- The smallest interval containing 5 is [2,5] with size 4.
- The smallest interval containing 22 is [20,25] with size 6.

Constraints:
• 1 <= intervals.length <= 10⁵
• 1 <= queries.length <= 10⁵
• intervals[i].length == 2
• 1 <= lefti <= righti <= 10⁷
• 1 <= queries[j] <= 10⁷""",
    bruteForce: Solution(
      code: """def minInterval(intervals, queries):
    result = []

    for query in queries:
        min_size = float('inf')

        for interval in intervals:
            left, right = interval

            # Check if query in interval
            if left <= query <= right:
                size = right - left + 1
                min_size = min(min_size, size)

        result.append(min_size if min_size != float('inf') else -1)

    return result""",
      timeComplexity: "O(n * m)",
      spaceComplexity: "O(1)",
      explanation: "For each query, check all intervals to find smallest one containing the query. No optimization, O(n*m) where n=intervals, m=queries.",
      steps: [
        "For each query:",
        "  - Initialize min_size to infinity",
        "  - Check all intervals:",
        "    - If interval contains query:",
        "      - Calculate size",
        "      - Update min_size",
        "  - Add min_size to result (or -1 if no interval found)",
        "Return result",
        "Note: O(queries × intervals)"
      ],
    ),
    optimized: Solution(
      code: """def minInterval(intervals, queries):
    import heapq

    # Sort intervals by start time, sort queries with indices
    intervals.sort()
    sorted_queries = sorted((q, i) for i, q in enumerate(queries))

    result = [-1] * len(queries)
    min_heap = []  # (size, end)
    interval_idx = 0

    for query, original_idx in sorted_queries:
        # Add all intervals that start <= query
        while interval_idx < len(intervals) and intervals[interval_idx][0] <= query:
            left, right = intervals[interval_idx]
            size = right - left + 1
            heapq.heappush(min_heap, (size, right))
            interval_idx += 1

        # Remove intervals that end < query
        while min_heap and min_heap[0][1] < query:
            heapq.heappop(min_heap)

        # Get smallest interval containing query
        if min_heap:
            result[original_idx] = min_heap[0][0]

    return result""",
      timeComplexity: "O((n + m) log n)",
      spaceComplexity: "O(n + m)",
      explanation: "Sort intervals and queries. Use min heap to track valid intervals. Process queries in sorted order, maintaining heap of intervals that could contain current query.",
      steps: [
        "Sort intervals by start time",
        "Sort queries while tracking original indices",
        "Initialize result array and min heap",
        "For each query (in sorted order):",
        "  - Add to heap all intervals starting <= query",
        "  - Remove from heap intervals ending < query",
        "  - Heap top is smallest valid interval",
        "  - Store size in result at original index",
        "Return result",
        "Key: Sorted processing + heap for efficient min finding",
        "O((n+m) log n) - sort + heap operations"
      ],
    ),
  ),

];
