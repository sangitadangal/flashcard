import '../leetcode_question.dart';

// NeetCode 150 - Heap/Priority Queue Category
// 7 questions with complete solutions

final List<LeetCodeQuestion> heapPriorityQueueQuestions = [

  LeetCodeQuestion(
    id: 703,
    title: "Kth Largest Element in a Stream",
    difficulty: Difficulty.easy,
    category: "Heap / Priority Queue",
    question: """Design a class to find the kth largest element in a stream. Note that it is the kth largest element in the sorted order, not the kth distinct element.

Implement KthLargest class:
• KthLargest(int k, int[] nums) Initializes the object with the integer k and the stream of integers nums.
• int add(int val) Appends the integer val to the stream and returns the element representing the kth largest element in the stream.

Example 1:
Input
["KthLargest", "add", "add", "add", "add", "add"]
[[3, [4, 5, 8, 2]], [3], [5], [10], [9], [4]]
Output
[null, 4, 5, 5, 8, 8]

Explanation
KthLargest kthLargest = new KthLargest(3, [4, 5, 8, 2]);
kthLargest.add(3);   // return 4
kthLargest.add(5);   // return 5
kthLargest.add(10);  // return 5
kthLargest.add(9);   // return 8
kthLargest.add(4);   // return 8

Constraints:
• 1 <= k <= 10⁴
• 0 <= nums.length <= 10⁴
• -10⁴ <= nums[i] <= 10⁴
• -10⁴ <= val <= 10⁴
• At most 10⁴ calls will be made to add.""",
    bruteForce: Solution(
      code: """class KthLargest:
    def __init__(self, k, nums):
        self.k = k
        self.nums = nums

    def add(self, val):
        self.nums.append(val)
        self.nums.sort(reverse=True)
        return self.nums[self.k - 1]""",
      timeComplexity: "O(n log n) per add operation",
      spaceComplexity: "O(n)",
      explanation: "Store all numbers and sort on every add operation. Return kth element after sorting. Very inefficient for frequent additions.",
      steps: [
        "Initialize: Store k and nums array",
        "Add operation:",
        "  - Append new value to nums array",
        "  - Sort entire array in descending order (O(n log n))",
        "  - Return element at index k-1",
        "Note: Sorting entire array on every add is very slow"
      ],
    ),
    optimized: Solution(
      code: """class KthLargest:
    def __init__(self, k, nums):
        import heapq
        self.k = k
        self.heap = nums
        heapq.heapify(self.heap)

        # Keep only k largest elements
        while len(self.heap) > k:
            heapq.heappop(self.heap)

    def add(self, val):
        import heapq
        heapq.heappush(self.heap, val)

        if len(self.heap) > self.k:
            heapq.heappop(self.heap)

        return self.heap[0]  # Min of k largest = kth largest""",
      timeComplexity: "O(log k) per add, O(n log k) initialization",
      spaceComplexity: "O(k)",
      explanation: "Maintain min heap of size k containing k largest elements. The root (minimum) of this heap is the kth largest element. Add takes O(log k) time.",
      steps: [
        "Initialize:",
        "  - Store k",
        "  - Convert nums to min heap",
        "  - Pop elements until heap size is k (keep k largest)",
        "Add operation:",
        "  - Push new value to heap",
        "  - If heap size > k, pop minimum (smallest of k largest)",
        "  - Return heap[0] (minimum of k largest = kth largest overall)",
        "Key: Min heap of k elements, root is kth largest"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 1046,
    title: "Last Stone Weight",
    difficulty: Difficulty.easy,
    category: "Heap / Priority Queue",
    question: """You are given an array of integers stones where stones[i] is the weight of the ith stone.

We are playing a game with the stones. On each turn, we choose the heaviest two stones and smash them together. Suppose the heaviest two stones have weights x and y with x <= y. The result of this smash is:
• If x == y, both stones are destroyed, and
• If x != y, the stone of weight x is destroyed, and the stone of weight y has new weight y - x.

At the end of the game, there is at most one stone left.

Return the weight of the last remaining stone. If there are no stones left, return 0.

Example 1:
Input: stones = [2,7,4,1,8,1]
Output: 1
Explanation:
We combine 7 and 8 to get 1 so the array converts to [2,4,1,1,1] then,
we combine 2 and 4 to get 2 so the array converts to [2,1,1,1] then,
we combine 2 and 1 to get 1 so the array converts to [1,1,1] then,
we combine 1 and 1 to get 0 so the array converts to [1] then that's the value of the last stone.

Example 2:
Input: stones = [1]
Output: 1

Constraints:
• 1 <= stones.length <= 30
• 1 <= stones[i] <= 1000""",
    bruteForce: Solution(
      code: """def lastStoneWeight(stones):
    while len(stones) > 1:
        stones.sort()
        y = stones.pop()  # Heaviest
        x = stones.pop()  # Second heaviest

        if x != y:
            stones.append(y - x)

    return stones[0] if stones else 0""",
      timeComplexity: "O(n² log n)",
      spaceComplexity: "O(1)",
      explanation: "Sort array on each iteration to find two heaviest stones. While correct, sorting takes O(n log n) and we do this n times.",
      steps: [
        "While more than one stone remains:",
        "  - Sort array to get stones in ascending order",
        "  - Pop last element (heaviest stone y)",
        "  - Pop new last element (second heaviest x)",
        "  - If x != y, append difference y - x back to array",
        "Return last stone if exists, otherwise 0",
        "Note: Sorting on every iteration is inefficient"
      ],
    ),
    optimized: Solution(
      code: """def lastStoneWeight(stones):
    import heapq

    # Python heapq is min heap, negate for max heap
    heap = [-stone for stone in stones]
    heapq.heapify(heap)

    while len(heap) > 1:
        y = -heapq.heappop(heap)  # Heaviest
        x = -heapq.heappop(heap)  # Second heaviest

        if x != y:
            heapq.heappush(heap, -(y - x))

    return -heap[0] if heap else 0""",
      timeComplexity: "O(n log n)",
      spaceComplexity: "O(n)",
      explanation: "Use max heap (negated min heap in Python) to efficiently get two heaviest stones. Each operation takes O(log n) and we do at most n operations.",
      steps: [
        "Convert stones to max heap (negate values for Python's min heap)",
        "Heapify the array",
        "While more than one stone in heap:",
        "  - Pop heaviest stone y (negate back to positive)",
        "  - Pop second heaviest stone x (negate back)",
        "  - If x != y, push difference y - x (negated) to heap",
        "Return last stone (negated) if exists, else 0",
        "Key: Heap operations are O(log n), total O(n log n)"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 973,
    title: "K Closest Points to Origin",
    difficulty: Difficulty.medium,
    category: "Heap / Priority Queue",
    question: """Given an array of points where points[i] = [xi, yi] represents a point on the X-Y plane and an integer k, return the k closest points to the origin (0, 0).

The distance between two points on the X-Y plane is the Euclidean distance (i.e., √(x1 - x2)² + (y1 - y2)²).

You may return the answer in any order. The answer is guaranteed to be unique (except for the order that it is in).

Example 1:
Input: points = [[1,3],[-2,2]], k = 1
Output: [[-2,2]]
Explanation:
The distance between (1, 3) and the origin is sqrt(10).
The distance between (-2, 2) and the origin is sqrt(8).
Since sqrt(8) < sqrt(10), (-2, 2) is closer to the origin.

Example 2:
Input: points = [[3,3],[5,-1],[-2,4]], k = 2
Output: [[3,3],[-2,4]]

Constraints:
• 1 <= k <= points.length <= 10⁴
• -10⁴ < xi, yi < 10⁴""",
    bruteForce: Solution(
      code: """def kClosest(points, k):
    # Calculate distance for each point and sort
    distances = []
    for x, y in points:
        dist = x*x + y*y  # No need for sqrt, just compare
        distances.append((dist, [x, y]))

    distances.sort()

    return [point for dist, point in distances[:k]]""",
      timeComplexity: "O(n log n)",
      spaceComplexity: "O(n)",
      explanation: "Calculate squared distance for each point, sort by distance, return first k points. Sorting entire array is more work than necessary.",
      steps: [
        "Create list of (distance, point) tuples",
        "For each point, calculate squared distance: x² + y²",
        "  (No need for sqrt since we only compare)",
        "Append (distance, point) to list",
        "Sort list by distance",
        "Extract points from first k tuples",
        "Return k closest points",
        "Note: Sorting all n points when we only need k"
      ],
    ),
    optimized: Solution(
      code: """def kClosest(points, k):
    import heapq

    # Max heap of size k (negate distances)
    heap = []

    for x, y in points:
        dist = -(x*x + y*y)  # Negate for max heap

        if len(heap) < k:
            heapq.heappush(heap, (dist, [x, y]))
        elif dist > heap[0][0]:  # Current closer than farthest in heap
            heapq.heapreplace(heap, (dist, [x, y]))

    return [point for dist, point in heap]""",
      timeComplexity: "O(n log k)",
      spaceComplexity: "O(k)",
      explanation: "Maintain max heap of k closest points. For each point, if heap has room or point is closer than farthest in heap, add it. This avoids sorting all n points.",
      steps: [
        "Create empty max heap (using negated distances)",
        "For each point:",
        "  - Calculate negated squared distance",
        "  - If heap size < k, push point to heap",
        "  - Else if current point closer than farthest in heap:",
        "    - Replace farthest with current point",
        "Extract points from heap",
        "Return k closest points",
        "Key: Only maintain k elements, O(n log k) vs O(n log n)"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 215,
    title: "Kth Largest Element in an Array",
    difficulty: Difficulty.medium,
    category: "Heap / Priority Queue",
    question: """Given an integer array nums and an integer k, return the kth largest element in the array.

Note that it is the kth largest element in the sorted order, not the kth distinct element.

Can you solve it without sorting?

Example 1:
Input: nums = [3,2,1,5,6,4], k = 2
Output: 5

Example 2:
Input: nums = [3,2,3,1,2,4,5,5,6], k = 4
Output: 4

Constraints:
• 1 <= k <= nums.length <= 10⁵
• -10⁴ <= nums[i] <= 10⁴""",
    bruteForce: Solution(
      code: """def findKthLargest(nums, k):
    nums.sort(reverse=True)
    return nums[k - 1]""",
      timeComplexity: "O(n log n)",
      spaceComplexity: "O(1) or O(n) depending on sort",
      explanation: "Sort array in descending order and return element at index k-1. Simple but doesn't meet the 'without sorting' challenge.",
      steps: [
        "Sort nums array in descending order",
        "Return element at index k-1",
        "Note: Uses sorting despite challenge asking to avoid it"
      ],
    ),
    optimized: Solution(
      code: """def findKthLargest(nums, k):
    import heapq

    # Min heap of size k
    heap = []

    for num in nums:
        if len(heap) < k:
            heapq.heappush(heap, num)
        elif num > heap[0]:
            heapq.heapreplace(heap, num)

    return heap[0]  # Min of k largest = kth largest""",
      timeComplexity: "O(n log k)",
      spaceComplexity: "O(k)",
      explanation: "Maintain min heap of k largest elements. Root of heap is kth largest. More efficient than sorting for small k.",
      steps: [
        "Create empty min heap",
        "For each number in nums:",
        "  - If heap size < k, push number",
        "  - Else if number > heap minimum:",
        "    - Replace minimum with current number",
        "After processing all numbers:",
        "  - Heap contains k largest elements",
        "  - Root is minimum of these k = kth largest overall",
        "Return heap[0]",
        "Key: O(n log k) better than O(n log n) when k is small"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 621,
    title: "Task Scheduler",
    difficulty: Difficulty.medium,
    category: "Heap / Priority Queue",
    question: """Given a characters array tasks, representing the tasks a CPU needs to do, where each letter represents a different task. Tasks could be done in any order. Each task is done in one unit of time. For each unit of time, the CPU could complete either one task or just be idle.

However, there is a non-negative integer n that represents the cooldown period between two same tasks (the same letter in the array), that is that there must be at least n units of time between any two same tasks.

Return the least number of units of times that the CPU will take to finish all the given tasks.

Example 1:
Input: tasks = ["A","A","A","B","B","B"], n = 2
Output: 8
Explanation:
A -> B -> idle -> A -> B -> idle -> A -> B
There is at least 2 units of time between any two same tasks.

Example 2:
Input: tasks = ["A","A","A","B","B","B"], n = 0
Output: 6
Explanation: On this case any permutation of size 6 would work since n = 0.
["A","A","A","B","B","B"]
["A","B","A","B","A","B"]
["B","B","B","A","A","A"]

Example 3:
Input: tasks = ["A","A","A","A","A","A","B","C","D","E","F","G"], n = 2
Output: 16
Explanation:
One possible solution is
A -> B -> C -> A -> D -> E -> A -> F -> G -> A -> idle -> idle -> A -> idle -> idle -> A

Constraints:
• 1 <= task.length <= 10⁴
• tasks[i] is upper-case English letter.
• The integer n is in the range [0, 100].""",
    bruteForce: Solution(
      code: """def leastInterval(tasks, n):
    from collections import Counter

    count = Counter(tasks)
    time = 0
    available = []

    # Simulate scheduling
    while count:
        # Get all tasks that can be scheduled now
        candidates = []
        for task, freq in count.items():
            if task not in [t for t, _ in available]:
                candidates.append((freq, task))

        if candidates:
            # Schedule most frequent available task
            candidates.sort(reverse=True)
            freq, task = candidates[0]
            count[task] -= 1
            if count[task] == 0:
                del count[task]

            # Add to cooldown
            if n > 0:
                available.append((task, time + n))

        time += 1

        # Remove tasks out of cooldown
        available = [(t, cooldown) for t, cooldown in available if cooldown >= time]

    return time""",
      timeComplexity: "O(n * t) - t is total tasks",
      spaceComplexity: "O(26) = O(1)",
      explanation: "Simulate the scheduling process by tracking cooldowns. Schedule most frequent available task at each time unit. Slow due to simulation.",
      steps: [
        "Count frequency of each task",
        "Initialize time counter and available list",
        "While tasks remain:",
        "  - Find tasks not in cooldown",
        "  - Schedule most frequent available task",
        "  - Decrement its count",
        "  - Add to cooldown list",
        "  - Increment time",
        "  - Remove tasks out of cooldown",
        "Return total time",
        "Note: Simulating each time unit is slow"
      ],
    ),
    optimized: Solution(
      code: """def leastInterval(tasks, n):
    from collections import Counter
    import heapq

    count = Counter(tasks)
    max_heap = [-freq for freq in count.values()]
    heapq.heapify(max_heap)

    time = 0
    queue = []  # (available_time, -freq)

    while max_heap or queue:
        time += 1

        if max_heap:
            freq = -heapq.heappop(max_heap) - 1
            if freq > 0:
                queue.append((time + n, -freq))

        if queue and queue[0][0] == time:
            heapq.heappush(max_heap, queue.pop(0)[1])

    return time""",
      timeComplexity: "O(t) - t is total tasks",
      spaceComplexity: "O(26) = O(1)",
      explanation: "Use max heap to always schedule most frequent task. Use queue to track tasks in cooldown. Process time units efficiently without simulating all details.",
      steps: [
        "Count frequency of each task type",
        "Create max heap of frequencies (negated)",
        "Initialize time = 0 and cooldown queue",
        "While heap or queue not empty:",
        "  - Increment time",
        "  - If heap not empty:",
        "    - Pop most frequent task, execute once",
        "    - If remaining frequency > 0, add to cooldown queue",
        "  - If task in queue ready (available_time == time):",
        "    - Move from queue back to heap",
        "Return total time",
        "Key: Greedy scheduling with heap, O(t) time"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 355,
    title: "Design Twitter",
    difficulty: Difficulty.medium,
    category: "Heap / Priority Queue",
    question: """Design a simplified version of Twitter where users can post tweets, follow/unfollow another user, and is able to see the 10 most recent tweets in the user's news feed.

Implement the Twitter class:
• Twitter() Initializes your twitter object.
• void postTweet(int userId, int tweetId) Composes a new tweet with ID tweetId by the user userId. Each call to this function will be made with a unique tweetId.
• List<Integer> getNewsFeed(int userId) Retrieves the 10 most recent tweet IDs in the user's news feed. Each item in the news feed must be posted by users who the user followed or by the user themself. Tweets must be ordered from most recent to least recent.
• void follow(int followerId, int followeeId) The user with ID followerId started following the user with ID followeeId.
• void unfollow(int followerId, int followeeId) The user with ID followerId started unfollowing the user with ID followeeId.

Example 1:
Input
["Twitter", "postTweet", "getNewsFeed", "follow", "postTweet", "getNewsFeed", "unfollow", "getNewsFeed"]
[[], [1, 5], [1], [1, 2], [2, 6], [1], [1, 2], [1]]
Output
[null, null, [5], null, null, [6, 5], null, [5]]

Constraints:
• 1 <= userId, followeeId, tweetId <= 500
• All the tweets have unique IDs.
• At most 3 * 10⁴ calls will be made to postTweet, getNewsFeed, follow, and unfollow.""",
    bruteForce: Solution(
      code: """class Twitter:
    def __init__(self):
        self.tweets = []  # (timestamp, userId, tweetId)
        self.following = {}  # userId -> set of followeeIds
        self.time = 0

    def postTweet(self, userId, tweetId):
        self.tweets.append((self.time, userId, tweetId))
        self.time += 1

    def getNewsFeed(self, userId):
        # Get tweets from user and people they follow
        relevant_tweets = []
        followees = self.following.get(userId, set())

        for timestamp, uid, tid in self.tweets:
            if uid == userId or uid in followees:
                relevant_tweets.append((timestamp, tid))

        # Sort by timestamp descending
        relevant_tweets.sort(reverse=True)

        return [tid for _, tid in relevant_tweets[:10]]

    def follow(self, followerId, followeeId):
        if followerId not in self.following:
            self.following[followerId] = set()
        self.following[followerId].add(followeeId)

    def unfollow(self, followerId, followeeId):
        if followerId in self.following:
            self.following[followerId].discard(followeeId)""",
      timeComplexity: "O(n) postTweet, O(t log t) getNewsFeed",
      spaceComplexity: "O(t + u) - t tweets, u users",
      explanation: "Store all tweets in a list. For getNewsFeed, filter relevant tweets and sort. Inefficient as it processes all tweets every time.",
      steps: [
        "Initialize: Empty tweets list, following dict, time counter",
        "PostTweet: Append (timestamp, userId, tweetId) to tweets list",
        "GetNewsFeed:",
        "  - Get followees of userId",
        "  - Filter tweets from user and followees",
        "  - Sort by timestamp descending",
        "  - Return top 10 tweet IDs",
        "Follow: Add followeeId to follower's set",
        "Unfollow: Remove followeeId from follower's set",
        "Note: Sorting all relevant tweets on every feed request is slow"
      ],
    ),
    optimized: Solution(
      code: """class Twitter:
    def __init__(self):
        import heapq
        self.tweets = {}  # userId -> list of (timestamp, tweetId)
        self.following = {}  # userId -> set of followeeIds
        self.time = 0

    def postTweet(self, userId, tweetId):
        if userId not in self.tweets:
            self.tweets[userId] = []
        self.tweets[userId].append((self.time, tweetId))
        self.time += 1

    def getNewsFeed(self, userId):
        import heapq

        # Merge tweets from user and followees
        heap = []
        users = {userId} | self.following.get(userId, set())

        for uid in users:
            if uid in self.tweets and self.tweets[uid]:
                timestamp, tweetId = self.tweets[uid][-1]
                # Max heap: negate timestamp
                heapq.heappush(heap, (-timestamp, tweetId, uid, len(self.tweets[uid]) - 1))

        result = []
        while heap and len(result) < 10:
            neg_time, tweetId, uid, index = heapq.heappop(heap)
            result.append(tweetId)

            if index > 0:
                timestamp, tweetId = self.tweets[uid][index - 1]
                heapq.heappush(heap, (-timestamp, tweetId, uid, index - 1))

        return result

    def follow(self, followerId, followeeId):
        if followerId != followeeId:  # Can't follow self
            if followerId not in self.following:
                self.following[followerId] = set()
            self.following[followerId].add(followeeId)

    def unfollow(self, followerId, followeeId):
        if followerId in self.following:
            self.following[followerId].discard(followeeId)""",
      timeComplexity: "O(1) post, O(k log u) feed - k=10, u users",
      spaceComplexity: "O(t + u)",
      explanation: "Store tweets per user. For feed, use heap to merge k most recent from each relevant user. Only process what's needed for top 10.",
      steps: [
        "Initialize: tweets dict (userId -> tweets), following dict, time",
        "PostTweet: Append (timestamp, tweetId) to user's tweet list",
        "GetNewsFeed:",
        "  - Create max heap",
        "  - For user and each followee, add their most recent tweet to heap",
        "  - While heap not empty and result < 10:",
        "    - Pop most recent tweet, add to result",
        "    - Push next tweet from same user to heap",
        "  - Return result",
        "Follow/Unfollow: Manage followee sets",
        "Key: Heap merges sorted lists efficiently, only get 10 tweets"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 295,
    title: "Find Median from Data Stream",
    difficulty: Difficulty.hard,
    category: "Heap / Priority Queue",
    question: """The median is the middle value in an ordered integer list. If the size of the list is even, there is no middle value, and the median is the mean of the two middle values.

Implement the MedianFinder class:
• MedianFinder() initializes the MedianFinder object.
• void addNum(int num) adds the integer num from the data stream to the data structure.
• double findMedian() returns the median of all elements so far.

Example 1:
Input
["MedianFinder", "addNum", "addNum", "findMedian", "addNum", "findMedian"]
[[], [1], [2], [], [3], []]
Output
[null, null, null, 1.5, null, 2.0]

Explanation
MedianFinder medianFinder = new MedianFinder();
medianFinder.addNum(1);    // arr = [1]
medianFinder.addNum(2);    // arr = [1, 2]
medianFinder.findMedian(); // return 1.5 (i.e., (1 + 2) / 2)
medianFinder.addNum(3);    // arr = [1, 2, 3]
medianFinder.findMedian(); // return 2.0

Constraints:
• -10⁵ <= num <= 10⁵
• There will be at least one element in the data structure before calling findMedian.
• At most 5 * 10⁴ calls will be made to addNum and findMedian.""",
    bruteForce: Solution(
      code: """class MedianFinder:
    def __init__(self):
        self.nums = []

    def addNum(self, num):
        self.nums.append(num)

    def findMedian(self):
        self.nums.sort()
        n = len(self.nums)

        if n % 2 == 1:
            return float(self.nums[n // 2])
        else:
            return (self.nums[n // 2 - 1] + self.nums[n // 2]) / 2.0""",
      timeComplexity: "O(1) addNum, O(n log n) findMedian",
      spaceComplexity: "O(n)",
      explanation: "Store all numbers in a list. For findMedian, sort the list and return middle element(s). Sorting on every findMedian call is very inefficient.",
      steps: [
        "Initialize: Create empty list",
        "AddNum: Append number to list (O(1))",
        "FindMedian:",
        "  - Sort entire list (O(n log n))",
        "  - If odd length, return middle element",
        "  - If even length, return average of two middle elements",
        "Note: Sorting every time is very slow for frequent queries"
      ],
    ),
    optimized: Solution(
      code: """class MedianFinder:
    def __init__(self):
        import heapq
        self.small = []  # Max heap (left half)
        self.large = []  # Min heap (right half)

    def addNum(self, num):
        import heapq

        # Add to max heap (small) - negate for max heap
        heapq.heappush(self.small, -num)

        # Balance: ensure max of small <= min of large
        if self.small and self.large and (-self.small[0] > self.large[0]):
            val = -heapq.heappop(self.small)
            heapq.heappush(self.large, val)

        # Balance sizes: small can have at most 1 more than large
        if len(self.small) > len(self.large) + 1:
            val = -heapq.heappop(self.small)
            heapq.heappush(self.large, val)

        if len(self.large) > len(self.small):
            val = heapq.heappop(self.large)
            heapq.heappush(self.small, -val)

    def findMedian(self):
        if len(self.small) > len(self.large):
            return float(-self.small[0])
        else:
            return (-self.small[0] + self.large[0]) / 2.0""",
      timeComplexity: "O(log n) addNum, O(1) findMedian",
      spaceComplexity: "O(n)",
      explanation: "Use two heaps: max heap for smaller half, min heap for larger half. Keep heaps balanced so median is always at heap tops. Efficient for frequent median queries.",
      steps: [
        "Initialize: Two heaps - small (max heap) and large (min heap)",
        "AddNum:",
        "  - Push to small heap (max heap of smaller half)",
        "  - Rebalance: if max of small > min of large, move to large",
        "  - Rebalance sizes: small can have at most 1 more element",
        "  - Move elements between heaps to maintain balance",
        "FindMedian:",
        "  - If small has more elements: return its max (-small[0])",
        "  - Otherwise: return average of both heap tops",
        "Key: Two heaps keep median accessible in O(1), add in O(log n)"
      ],
    ),
  ),

];
