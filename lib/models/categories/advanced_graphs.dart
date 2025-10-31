import '../leetcode_question.dart';

// NeetCode 150 - Advanced Graphs Category
// 6 questions with complete solutions

final List<LeetCodeQuestion> advancedGraphsQuestions = [

  LeetCodeQuestion(
    id: 261,
    title: "Graph Valid Tree",
    difficulty: Difficulty.medium,
    category: "Advanced Graphs",
    question: """You have a graph of n nodes labeled from 0 to n - 1. You are given an integer n and a list of edges where edges[i] = [ai, bi] indicates that there is an undirected edge between nodes ai and bi in the graph.

Return true if the edges of the given graph make up a valid tree, and false otherwise.

Example 1:
Input: n = 5, edges = [[0,1],[0,2],[0,3],[1,4]]
Output: true

Example 2:
Input: n = 5, edges = [[0,1],[1,2],[2,3],[1,3],[1,4]]
Output: false

Constraints:
• 1 <= n <= 2000
• 0 <= edges.length <= 5000
• edges[i].length == 2
• 0 <= ai, bi < n
• ai != bi
• There are no self-loops or repeated edges.""",
    bruteForce: Solution(
      code: """def validTree(n, edges):
    # Tree must have exactly n-1 edges
    if len(edges) != n - 1:
        return False

    # Build adjacency list
    graph = {i: [] for i in range(n)}
    for u, v in edges:
        graph[u].append(v)
        graph[v].append(u)

    # Check if connected using DFS
    visited = set()

    def dfs(node, parent):
        visited.add(node)
        for neighbor in graph[node]:
            if neighbor == parent:
                continue
            if neighbor in visited:
                return False  # Cycle detected
            if not dfs(neighbor, node):
                return False
        return True

    # Start DFS from node 0
    if not dfs(0, -1):
        return False

    # Check if all nodes visited (connected)
    return len(visited) == n""",
      timeComplexity: "O(n + e)",
      spaceComplexity: "O(n + e)",
      explanation: "Valid tree has n-1 edges, is connected, and has no cycles. Check edge count, run DFS to detect cycles and verify all nodes reachable.",
      steps: [
        "Check if edge count equals n-1 (necessary for tree)",
        "Build adjacency list from edges",
        "Define DFS that detects cycles:",
        "  - Track parent to avoid false cycle detection",
        "  - If neighbor already visited and not parent, cycle exists",
        "Run DFS from node 0",
        "Check if all n nodes were visited (connected)",
        "Return true only if no cycles and all nodes connected"
      ],
    ),
    optimized: Solution(
      code: """def validTree(n, edges):
    if len(edges) != n - 1:
        return False

    # Union-Find
    parent = list(range(n))

    def find(x):
        if parent[x] != x:
            parent[x] = find(parent[x])
        return parent[x]

    def union(x, y):
        root_x = find(x)
        root_y = find(y)

        if root_x == root_y:
            return False  # Cycle

        parent[root_x] = root_y
        return True

    # Process all edges
    for u, v in edges:
        if not union(u, v):
            return False

    return True""",
      timeComplexity: "O(n * α(n)) ≈ O(n)",
      spaceComplexity: "O(n)",
      explanation: "Use Union-Find. If edge count is n-1 and no cycles (all unions succeed), it's a valid tree. Simpler than DFS approach.",
      steps: [
        "Check edge count is exactly n-1",
        "Initialize Union-Find parent array",
        "Define find with path compression",
        "Define union that returns False if cycle detected",
        "Process all edges:",
        "  - Try to union endpoints",
        "  - If union fails, cycle exists, return False",
        "If all unions succeed, valid tree, return True",
        "Key: Edge count check + Union-Find is elegant solution"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 323,
    title: "Number of Connected Components in an Undirected Graph",
    difficulty: Difficulty.medium,
    category: "Advanced Graphs",
    question: """You have a graph of n nodes. You are given an integer n and an array edges where edges[i] = [ai, bi] indicates that there is an edge between ai and bi in the graph.

Return the number of connected components in the graph.

Example 1:
Input: n = 5, edges = [[0,1],[1,2],[3,4]]
Output: 2

Example 2:
Input: n = 5, edges = [[0,1],[1,2],[2,3],[3,4]]
Output: 1

Constraints:
• 1 <= n <= 2000
• 0 <= edges.length <= 5000
• edges[i].length == 2
• 0 <= ai, bi < n
• ai != bi
• There are no repeated edges.""",
    bruteForce: Solution(
      code: """def countComponents(n, edges):
    # Build adjacency list
    graph = {i: [] for i in range(n)}
    for u, v in edges:
        graph[u].append(v)
        graph[v].append(u)

    visited = set()
    count = 0

    def dfs(node):
        visited.add(node)
        for neighbor in graph[node]:
            if neighbor not in visited:
                dfs(neighbor)

    for i in range(n):
        if i not in visited:
            dfs(i)
            count += 1

    return count""",
      timeComplexity: "O(n + e)",
      spaceComplexity: "O(n + e)",
      explanation: "Use DFS to explore each component. For each unvisited node, run DFS to mark entire component, then increment counter.",
      steps: [
        "Build adjacency list from edges",
        "Initialize visited set and component counter",
        "Define DFS to mark all nodes in component",
        "For each node from 0 to n-1:",
        "  - If not visited, start new component",
        "  - Run DFS to mark all nodes in this component",
        "  - Increment component count",
        "Return total component count"
      ],
    ),
    optimized: Solution(
      code: """def countComponents(n, edges):
    parent = list(range(n))

    def find(x):
        if parent[x] != x:
            parent[x] = find(parent[x])
        return parent[x]

    def union(x, y):
        root_x = find(x)
        root_y = find(y)

        if root_x != root_y:
            parent[root_x] = root_y

    # Union all edges
    for u, v in edges:
        union(u, v)

    # Count unique roots
    return len(set(find(i) for i in range(n)))""",
      timeComplexity: "O(n * α(n)) ≈ O(n)",
      spaceComplexity: "O(n)",
      explanation: "Use Union-Find to merge connected nodes. Count unique roots at the end. Each unique root represents one component.",
      steps: [
        "Initialize Union-Find parent array",
        "Define find with path compression",
        "Define union to merge components",
        "Process all edges, union their endpoints",
        "After all unions, count unique roots:",
        "  - Apply find to all nodes",
        "  - Count distinct root values",
        "Return count of unique roots",
        "Key: Union-Find naturally tracks components"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 269,
    title: "Alien Dictionary",
    difficulty: Difficulty.hard,
    category: "Advanced Graphs",
    question: """There is a new alien language that uses the English alphabet. However, the order among the letters is unknown to you.

You are given a list of strings words from the alien language's dictionary, where the strings in words are sorted lexicographically by the rules of this new language.

Return a string of the unique letters in the new alien language sorted in lexicographically increasing order by the new language's rules. If there is no solution, return "". If there are multiple solutions, return any of them.

Example 1:
Input: words = ["wrt","wrf","er","ett","rftt"]
Output: "wertf"

Example 2:
Input: words = ["z","x"]
Output: "zx"

Example 3:
Input: words = ["z","x","z"]
Output: ""
Explanation: The order is invalid, so return "".

Constraints:
• 1 <= words.length <= 100
• 1 <= words[i].length <= 100
• words[i] consists of only lowercase English letters.""",
    bruteForce: Solution(
      code: """def alienOrder(words):
    # Build graph by comparing adjacent words
    graph = {c: set() for word in words for c in word}

    for i in range(len(words) - 1):
        w1, w2 = words[i], words[i + 1]
        min_len = min(len(w1), len(w2))

        # Check invalid case: prefix comes after longer word
        if len(w1) > len(w2) and w1[:min_len] == w2[:min_len]:
            return ""

        # Find first differing character
        for j in range(min_len):
            if w1[j] != w2[j]:
                graph[w1[j]].add(w2[j])
                break

    # Topological sort using DFS
    visited = {}  # 0=unvisited, 1=visiting, 2=visited
    result = []

    def dfs(char):
        if char in visited:
            return visited[char] != 1  # False if cycle

        visited[char] = 1  # Visiting

        for neighbor in graph[char]:
            if not dfs(neighbor):
                return False

        visited[char] = 2  # Visited
        result.append(char)
        return True

    for char in graph:
        if not dfs(char):
            return ""  # Cycle detected

    return ''.join(reversed(result))""",
      timeComplexity: "O(C) - C is total characters",
      spaceComplexity: "O(1) - max 26 letters",
      explanation: "Build directed graph from word comparisons, then topological sort. Edge from c1 to c2 means c1 comes before c2. Detect invalid orderings.",
      steps: [
        "Create graph with all characters as nodes",
        "Compare adjacent words to build edges:",
        "  - Find first differing character",
        "  - Add edge from char in w1 to char in w2",
        "  - Check invalid case: longer word before its prefix",
        "Perform topological sort using DFS:",
        "  - Use tri-color marking for cycle detection",
        "  - Add to result in post-order",
        "Reverse result to get topological order",
        "Return empty string if cycle detected"
      ],
    ),
    optimized: Solution(
      code: """def alienOrder(words):
    # Build graph and in-degree
    graph = {c: set() for word in words for c in word}
    in_degree = {c: 0 for word in words for c in word}

    for i in range(len(words) - 1):
        w1, w2 = words[i], words[i + 1]
        min_len = min(len(w1), len(w2))

        if len(w1) > len(w2) and w1[:min_len] == w2[:min_len]:
            return ""

        for j in range(min_len):
            if w1[j] != w2[j]:
                if w2[j] not in graph[w1[j]]:
                    graph[w1[j]].add(w2[j])
                    in_degree[w2[j]] += 1
                break

    # Kahn's algorithm (BFS topological sort)
    from collections import deque
    queue = deque([c for c in in_degree if in_degree[c] == 0])
    result = []

    while queue:
        char = queue.popleft()
        result.append(char)

        for neighbor in graph[char]:
            in_degree[neighbor] -= 1
            if in_degree[neighbor] == 0:
                queue.append(neighbor)

    if len(result) != len(graph):
        return ""  # Cycle exists

    return ''.join(result)""",
      timeComplexity: "O(C)",
      spaceComplexity: "O(1)",
      explanation: "Use Kahn's algorithm (BFS) for topological sort. Cleaner than DFS for this problem. Check if all characters processed to detect cycles.",
      steps: [
        "Build graph and in-degree from word comparisons",
        "Check invalid prefix case",
        "Initialize queue with characters having in-degree 0",
        "BFS topological sort:",
        "  - Dequeue character, add to result",
        "  - Decrease in-degree of neighbors",
        "  - Add neighbors with in-degree 0 to queue",
        "If result length < graph size, cycle exists",
        "Return result string or empty if cycle",
        "Key: BFS gives natural ordering without reversal"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 778,
    title: "Swim in Rising Water",
    difficulty: Difficulty.hard,
    category: "Advanced Graphs",
    question: """You are given an n x n integer matrix grid where each value grid[i][j] represents the elevation at that point (i, j).

The rain starts to fall. At time t, the depth of the water everywhere is t. You can swim from a square to another 4-directionally adjacent square if and only if the elevation of both squares individually are at most t. You can swim infinite distances in zero time. Of course, you must stay within the boundaries of the grid during your swim.

Return the least time until you can reach the bottom right square (n - 1, n - 1) if you start at the top left square (0, 0).

Example 1:
Input: grid = [[0,2],[1,3]]
Output: 3
Explanation: At time 0, you are in grid location (0, 0). You cannot go anywhere else because 4-directionally adjacent neighbors have a higher elevation than t = 0.
At time 3, the grid is completely flooded.

Example 2:
Input: grid = [[0,1,2,3,4],[24,23,22,21,5],[12,13,14,15,16],[11,17,18,19,20],[10,9,8,7,6]]
Output: 16

Constraints:
• n == grid.length
• n == grid[i].length
• 1 <= n <= 50
• 0 <= grid[i][j] < n²
• Each value grid[i][j] is unique.""",
    bruteForce: Solution(
      code: """def swimInWater(grid):
    n = len(grid)

    def canReach(time):
        if grid[0][0] > time:
            return False

        visited = set()
        stack = [(0, 0)]

        while stack:
            i, j = stack.pop()

            if i == n - 1 and j == n - 1:
                return True

            if (i, j) in visited:
                continue

            visited.add((i, j))

            for di, dj in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                ni, nj = i + di, j + dj
                if (0 <= ni < n and 0 <= nj < n and
                    (ni, nj) not in visited and
                    grid[ni][nj] <= time):
                    stack.append((ni, nj))

        return False

    # Binary search on time
    left, right = 0, n * n - 1

    while left < right:
        mid = (left + right) // 2
        if canReach(mid):
            right = mid
        else:
            left = mid + 1

    return left""",
      timeComplexity: "O(n² * log(n²))",
      spaceComplexity: "O(n²)",
      explanation: "Binary search on time value. For each time, check if destination reachable using DFS. Find minimum time where path exists.",
      steps: [
        "Define canReach(time) using DFS:",
        "  - Check if can reach (n-1, n-1) with max elevation <= time",
        "  - Can only visit cells with elevation <= time",
        "Binary search on time from 0 to n²-1:",
        "  - If canReach(mid), try smaller time",
        "  - Otherwise, need larger time",
        "Return minimum time where destination reachable"
      ],
    ),
    optimized: Solution(
      code: """def swimInWater(grid):
    import heapq
    n = len(grid)

    # Min heap: (max_elevation_so_far, row, col)
    heap = [(grid[0][0], 0, 0)]
    visited = set()

    while heap:
        time, i, j = heapq.heappop(heap)

        if (i, j) in visited:
            continue

        visited.add((i, j))

        if i == n - 1 and j == n - 1:
            return time

        for di, dj in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
            ni, nj = i + di, j + dj
            if (0 <= ni < n and 0 <= nj < n and
                (ni, nj) not in visited):
                heapq.heappush(heap, (max(time, grid[ni][nj]), ni, nj))

    return -1""",
      timeComplexity: "O(n² * log(n²))",
      spaceComplexity: "O(n²)",
      explanation: "Use Dijkstra-like approach with min heap. Track minimum time needed to reach each cell. Time for a cell is max elevation encountered on path to it.",
      steps: [
        "Initialize min heap with starting position and its elevation",
        "Use visited set to avoid reprocessing",
        "While heap not empty:",
        "  - Pop cell with minimum time",
        "  - If already visited, skip",
        "  - Mark as visited",
        "  - If destination reached, return time",
        "  - For each unvisited neighbor:",
        "    - Push (max(current_time, neighbor_elevation), neighbor)",
        "Key: Greedy approach, always extend path with minimum time increase"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 332,
    title: "Reconstruct Itinerary",
    difficulty: Difficulty.hard,
    category: "Advanced Graphs",
    question: """You are given a list of airline tickets where tickets[i] = [fromi, toi] represent the departure and the arrival airports of one flight. Reconstruct the itinerary in order and return it.

All of the tickets belong to a man who departs from "JFK", thus, the itinerary must begin with "JFK". If there are multiple valid itineraries, you should return the itinerary that has the smallest lexical order when read as a single string.

For example, the itinerary ["JFK", "LGA"] has a smaller lexical order than ["JFK", "LGB"].

You may assume all tickets form at least one valid itinerary. You must use all the tickets once and only once.

Example 1:
Input: tickets = [["MUC","LHR"],["JFK","MUC"],["SFO","SJC"],["LHR","SFO"]]
Output: ["JFK","MUC","LHR","SFO","SJC"]

Example 2:
Input: tickets = [["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]]
Output: ["JFK","ATL","JFK","SFO","ATL","SFO"]

Constraints:
• 1 <= tickets.length <= 300
• tickets[i].length == 2
• fromi.length == 3
• toi.length == 3
• fromi and toi consist of uppercase English letters.
• fromi != toi""",
    bruteForce: Solution(
      code: """def findItinerary(tickets):
    from collections import defaultdict

    graph = defaultdict(list)
    for src, dst in tickets:
        graph[src].append(dst)

    # Sort destinations for lexical order
    for src in graph:
        graph[src].sort()

    result = []

    def dfs(airport, path, remaining):
        if remaining == 0:
            result.append(path[:])
            return True

        if airport not in graph:
            return False

        for i, next_airport in enumerate(graph[airport]):
            graph[airport].pop(i)
            if dfs(next_airport, path + [next_airport], remaining - 1):
                return True
            graph[airport].insert(i, next_airport)

        return False

    dfs("JFK", ["JFK"], len(tickets))
    return result[0] if result else []""",
      timeComplexity: "O(E²) - E is number of tickets",
      spaceComplexity: "O(E)",
      explanation: "Use backtracking with sorted destinations. Try each destination, backtrack if can't use all tickets. Inefficient due to list operations.",
      steps: [
        "Build adjacency list from tickets",
        "Sort destinations for each airport (lexical order)",
        "Define DFS backtracking:",
        "  - If used all tickets, found solution",
        "  - Try each destination from current airport",
        "  - Remove ticket, recurse, restore if failed",
        "Start from JFK with all tickets remaining",
        "Return first valid itinerary found",
        "Note: List pop/insert is inefficient"
      ],
    ),
    optimized: Solution(
      code: """def findItinerary(tickets):
    from collections import defaultdict
    import heapq

    graph = defaultdict(list)
    for src, dst in tickets:
        heapq.heappush(graph[src], dst)

    result = []

    def dfs(airport):
        while graph[airport]:
            next_airport = heapq.heappop(graph[airport])
            dfs(next_airport)
        result.append(airport)

    dfs("JFK")
    return result[::-1]""",
      timeComplexity: "O(E * log E)",
      spaceComplexity: "O(E)",
      explanation: "Hierholzer's algorithm for Eulerian path. Use min heap for lexical order. Build path in reverse (post-order), then reverse result.",
      steps: [
        "Build graph with min heaps for lexical ordering",
        "Define DFS that processes edges greedily:",
        "  - While current airport has outgoing edges:",
        "    - Pop smallest destination (min heap)",
        "    - Recursively visit that destination",
        "  - After exhausting edges, add airport to result",
        "Start DFS from JFK",
        "Reverse result to get correct order",
        "Key: Eulerian path algorithm, elegant and efficient"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 1584,
    title: "Min Cost to Connect All Points",
    difficulty: Difficulty.medium,
    category: "Advanced Graphs",
    question: """You are given an array points representing integer coordinates of some points on a 2D-plane, where points[i] = [xi, yi].

The cost of connecting two points [xi, yi] and [xj, yj] is the manhattan distance between them: |xi - xj| + |yi - yj|, where |val| denotes the absolute value of val.

Return the minimum cost to make all points connected. All points are connected if there is exactly one simple path between any two points.

Example 1:
Input: points = [[0,0],[2,2],[3,10],[5,2],[7,0]]
Output: 20

Example 2:
Input: points = [[3,12],[-2,5],[-4,1]]
Output: 18

Constraints:
• 1 <= points.length <= 1000
• -10⁶ <= xi, yi <= 10⁶
• All pairs (xi, yi) are distinct.""",
    bruteForce: Solution(
      code: """def minCostConnectPoints(points):
    n = len(points)

    # Build complete graph with all edges
    edges = []
    for i in range(n):
        for j in range(i + 1, n):
            cost = abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1])
            edges.append((cost, i, j))

    # Sort edges by cost
    edges.sort()

    # Kruskal's algorithm with Union-Find
    parent = list(range(n))

    def find(x):
        if parent[x] != x:
            parent[x] = find(parent[x])
        return parent[x]

    def union(x, y):
        root_x = find(x)
        root_y = find(y)
        if root_x != root_y:
            parent[root_x] = root_y
            return True
        return False

    total_cost = 0
    edges_used = 0

    for cost, u, v in edges:
        if union(u, v):
            total_cost += cost
            edges_used += 1
            if edges_used == n - 1:
                break

    return total_cost""",
      timeComplexity: "O(n² * log(n²))",
      spaceComplexity: "O(n²)",
      explanation: "Kruskal's algorithm: build all n² edges, sort by cost, add edges greedily using Union-Find. Creates and sorts many edges.",
      steps: [
        "Build list of all possible edges with costs (n² edges)",
        "Calculate Manhattan distance for each edge",
        "Sort all edges by cost",
        "Initialize Union-Find",
        "Process edges in sorted order:",
        "  - If endpoints in different components, add edge",
        "  - Union the components",
        "  - Add cost to total",
        "Stop when n-1 edges added (spanning tree complete)",
        "Return total cost"
      ],
    ),
    optimized: Solution(
      code: """def minCostConnectPoints(points):
    import heapq
    n = len(points)

    visited = set()
    min_heap = [(0, 0)]  # (cost, point_index)
    total_cost = 0

    while len(visited) < n:
        cost, i = heapq.heappop(min_heap)

        if i in visited:
            continue

        visited.add(i)
        total_cost += cost

        # Add edges to unvisited neighbors
        for j in range(n):
            if j not in visited:
                dist = abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1])
                heapq.heappush(min_heap, (dist, j))

    return total_cost""",
      timeComplexity: "O(n² * log n)",
      spaceComplexity: "O(n²)",
      explanation: "Prim's algorithm: start from any point, greedily add closest unvisited point. Use min heap to track frontier. More efficient than Kruskal's for dense graphs.",
      steps: [
        "Initialize min heap with starting point (cost 0, index 0)",
        "Track visited points and total cost",
        "While not all points visited:",
        "  - Pop minimum cost point from heap",
        "  - If already visited, skip",
        "  - Mark as visited, add cost to total",
        "  - For each unvisited point, calculate distance",
        "  - Add (distance, point) to heap",
        "Return total cost",
        "Key: Prim's builds MST incrementally, better for dense graphs"
      ],
    ),
  ),

];
