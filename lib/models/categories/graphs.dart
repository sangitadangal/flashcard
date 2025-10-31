import '../leetcode_question.dart';

// NeetCode 150 - Graphs Category
// 13 questions with complete solutions

final List<LeetCodeQuestion> graphsQuestions = [

  LeetCodeQuestion(
    id: 200,
    title: "Number of Islands",
    difficulty: Difficulty.medium,
    category: "Graphs",
    question: """Given an m x n 2D binary grid grid which represents a map of '1's (land) and '0's (water), return the number of islands.

An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

Example 1:
Input: grid = [
  ["1","1","1","1","0"],
  ["1","1","0","1","0"],
  ["1","1","0","0","0"],
  ["0","0","0","0","0"]
]
Output: 1

Example 2:
Input: grid = [
  ["1","1","0","0","0"],
  ["1","1","0","0","0"],
  ["0","0","1","0","0"],
  ["0","0","0","1","1"]
]
Output: 3

Constraints:
• m == grid.length
• n == grid[i].length
• 1 <= m, n <= 300
• grid[i][j] is '0' or '1'.""",
    bruteForce: Solution(
      code: """def numIslands(grid):
    if not grid:
        return 0

    m, n = len(grid), len(grid[0])
    visited = [[False] * n for _ in range(m)]
    count = 0

    def dfs(i, j):
        if (i < 0 or i >= m or j < 0 or j >= n or
            visited[i][j] or grid[i][j] == '0'):
            return

        visited[i][j] = True
        dfs(i+1, j)
        dfs(i-1, j)
        dfs(i, j+1)
        dfs(i, j-1)

    for i in range(m):
        for j in range(n):
            if grid[i][j] == '1' and not visited[i][j]:
                dfs(i, j)
                count += 1

    return count""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(m * n)",
      explanation: "Use DFS with separate visited matrix to track explored cells. For each unvisited land cell, start DFS to mark entire island, then increment counter.",
      steps: [
        "Handle empty grid edge case",
        "Get dimensions m and n",
        "Create m x n visited matrix initialized to False",
        "Initialize island count to 0",
        "Define DFS function to explore island from (i, j)",
        "For each cell in grid:",
        "  - If it's land ('1') and not visited, start DFS and increment count",
        "Return total count"
      ],
    ),
    optimized: Solution(
      code: """def numIslands(grid):
    if not grid:
        return 0

    m, n = len(grid), len(grid[0])
    count = 0

    def dfs(i, j):
        if i < 0 or i >= m or j < 0 or j >= n or grid[i][j] == '0':
            return

        grid[i][j] = '0'  # Mark as visited
        dfs(i+1, j)
        dfs(i-1, j)
        dfs(i, j+1)
        dfs(i, j-1)

    for i in range(m):
        for j in range(n):
            if grid[i][j] == '1':
                dfs(i, j)
                count += 1

    return count""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(1) - excluding recursion stack",
      explanation: "Optimize space by modifying grid in-place instead of using separate visited matrix. Mark visited land cells as '0' during DFS traversal.",
      steps: [
        "Handle empty grid",
        "Get grid dimensions",
        "Initialize island counter",
        "Define DFS that marks visited cells as '0' in-place",
        "Check bounds and if current cell is water",
        "Mark current cell as visited (change '1' to '0')",
        "Recursively explore all 4 directions",
        "For each unvisited land cell, run DFS and increment count",
        "Return count",
        "Key: In-place modification saves O(m*n) space"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 133,
    title: "Clone Graph",
    difficulty: Difficulty.medium,
    category: "Graphs",
    question: """Given a reference of a node in a connected undirected graph.

Return a deep copy (clone) of the graph.

Each node in the graph contains a value (int) and a list (List[Node]) of its neighbors.

class Node {
    public int val;
    public List<Node> neighbors;
}

Test case format:
For simplicity, each node's value is the same as the node's index (1-indexed). For example, the first node with val == 1, the second node with val == 2, and so on. The graph is represented in the test case using an adjacency list.

An adjacency list is a collection of unordered lists used to represent a finite graph. Each list describes the set of neighbors of a node in the graph.

The given node will always be the first node with val = 1. You must return the copy of the given node as a reference to the cloned graph.

Example 1:
Input: adjList = [[2,4],[1,3],[2,4],[1,3]]
Output: [[2,4],[1,3],[2,4],[1,3]]

Example 2:
Input: adjList = [[]]
Output: [[]]

Example 3:
Input: adjList = []
Output: []

Constraints:
• The number of nodes in the graph is in the range [0, 100].
• 1 <= Node.val <= 100
• Node.val is unique for each node.
• There are no repeated edges and no self-loops in the graph.
• The Graph is connected and all nodes can be visited starting from the given node.""",
    bruteForce: Solution(
      code: """def cloneGraph(node):
    if not node:
        return None

    # First pass: create all nodes
    visited = {}
    queue = [node]
    seen = {node}

    while queue:
        curr = queue.pop(0)
        visited[curr] = Node(curr.val)

        for neighbor in curr.neighbors:
            if neighbor not in seen:
                seen.add(neighbor)
                queue.append(neighbor)

    # Second pass: connect neighbors
    for original, clone in visited.items():
        for neighbor in original.neighbors:
            clone.neighbors.append(visited[neighbor])

    return visited[node]""",
      timeComplexity: "O(V + E)",
      spaceComplexity: "O(V)",
      explanation: "Two-pass approach: first create all node clones, then connect neighbors. Uses BFS to discover all nodes, then iterates through mapping to set up edges.",
      steps: [
        "Handle null node case",
        "First pass: Create all node clones using BFS",
        "  - Maintain visited map: original -> clone",
        "  - BFS to discover all nodes",
        "  - Create clone for each discovered node",
        "Second pass: Connect neighbors",
        "  - For each original-clone pair",
        "  - For each neighbor of original",
        "  - Add corresponding clone to clone's neighbors",
        "Return clone of input node"
      ],
    ),
    optimized: Solution(
      code: """def cloneGraph(node):
    if not node:
        return None

    visited = {}

    def dfs(node):
        if node in visited:
            return visited[node]

        clone = Node(node.val)
        visited[node] = clone

        for neighbor in node.neighbors:
            clone.neighbors.append(dfs(neighbor))

        return clone

    return dfs(node)""",
      timeComplexity: "O(V + E)",
      spaceComplexity: "O(V)",
      explanation: "Single-pass DFS approach. Clone nodes on-the-fly while exploring. Use visited map to avoid duplicates and handle cycles.",
      steps: [
        "Handle null node",
        "Create visited map: original -> clone",
        "Define DFS function:",
        "  - If node already cloned, return its clone",
        "  - Create clone of current node",
        "  - Add to visited map immediately",
        "  - For each neighbor, recursively get/create clone and add to neighbors",
        "  - Return clone",
        "Call DFS on input node",
        "Return result",
        "Key: Single pass, handles cycles with visited map"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 695,
    title: "Max Area of Island",
    difficulty: Difficulty.medium,
    category: "Graphs",
    question: """You are given an m x n binary matrix grid. An island is a group of 1's (representing land) connected 4-directionally (horizontal or vertical.) You may assume all four edges of the grid are surrounded by water.

The area of an island is the number of cells with a value 1 in the island.

Return the maximum area of an island in grid. If there is no island, return 0.

Example 1:
Input: grid = [[0,0,1,0,0,0,0,1,0,0,0,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,1,1,0,1,0,0,0,0,0,0,0,0],[0,1,0,0,1,1,0,0,1,0,1,0,0],[0,1,0,0,1,1,0,0,1,1,1,0,0],[0,0,0,0,0,0,0,0,0,0,1,0,0],[0,0,0,0,0,0,0,1,1,1,0,0,0],[0,0,0,0,0,0,0,1,1,0,0,0,0]]
Output: 6

Example 2:
Input: grid = [[0,0,0,0,0,0,0,0]]
Output: 0

Constraints:
• m == grid.length
• n == grid[i].length
• 1 <= m, n <= 50
• grid[i][j] is either 0 or 1.""",
    bruteForce: Solution(
      code: """def maxAreaOfIsland(grid):
    if not grid:
        return 0

    m, n = len(grid), len(grid[0])
    visited = [[False] * n for _ in range(m)]
    max_area = 0

    def dfs(i, j):
        if (i < 0 or i >= m or j < 0 or j >= n or
            visited[i][j] or grid[i][j] == 0):
            return 0

        visited[i][j] = True
        area = 1

        area += dfs(i+1, j)
        area += dfs(i-1, j)
        area += dfs(i, j+1)
        area += dfs(i, j-1)

        return area

    for i in range(m):
        for j in range(n):
            if grid[i][j] == 1 and not visited[i][j]:
                max_area = max(max_area, dfs(i, j))

    return max_area""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(m * n)",
      explanation: "Use DFS with separate visited matrix. For each unvisited land cell, calculate island area by summing 1 (current cell) plus areas from all 4 directions.",
      steps: [
        "Handle empty grid",
        "Create visited matrix",
        "Initialize max_area to 0",
        "Define DFS that returns area of island:",
        "  - Check bounds, visited status, and if water",
        "  - Mark as visited",
        "  - Start area at 1 (current cell)",
        "  - Add areas from all 4 directions",
        "  - Return total area",
        "For each cell, if unvisited land, run DFS and update max",
        "Return max_area"
      ],
    ),
    optimized: Solution(
      code: """def maxAreaOfIsland(grid):
    if not grid:
        return 0

    m, n = len(grid), len(grid[0])
    max_area = 0

    def dfs(i, j):
        if i < 0 or i >= m or j < 0 or j >= n or grid[i][j] == 0:
            return 0

        grid[i][j] = 0  # Mark as visited
        return 1 + dfs(i+1, j) + dfs(i-1, j) + dfs(i, j+1) + dfs(i, j-1)

    for i in range(m):
        for j in range(n):
            if grid[i][j] == 1:
                max_area = max(max_area, dfs(i, j))

    return max_area""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(1) - excluding recursion",
      explanation: "Optimize by modifying grid in-place. Mark visited cells as 0. DFS returns 1 + sum of areas from 4 directions in single expression.",
      steps: [
        "Handle empty grid",
        "Initialize max_area",
        "Define DFS returning island area:",
        "  - Check bounds and if water (0)",
        "  - Mark current as visited (set to 0)",
        "  - Return 1 + sum of DFS calls in 4 directions",
        "For each land cell, update max with DFS result",
        "Return max_area",
        "Key: In-place marking + concise area calculation"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 417,
    title: "Pacific Atlantic Water Flow",
    difficulty: Difficulty.medium,
    category: "Graphs",
    question: """There is an m x n rectangular island that borders both the Pacific Ocean and Atlantic Ocean. The Pacific Ocean touches the island's left and top edges, and the Atlantic Ocean touches the island's right and bottom edges.

The island is partitioned into a grid of square cells. You are given an m x n integer matrix heights where heights[r][c] represents the height above sea level of the cell at coordinate (r, c).

The island receives a lot of rain, and the rain water can flow to neighboring cells directly north, south, east, and west if the neighboring cell's height is less than or equal to the current cell's height. Water can flow from any cell adjacent to an ocean into the ocean.

Return a 2D list of grid coordinates result where result[i] = [ri, ci] denotes that rain water can flow from cell (ri, ci) to both the Pacific and Atlantic oceans.

Example 1:
Input: heights = [[1,2,2,3,5],[3,2,3,4,4],[2,4,5,3,1],[6,7,1,4,5],[5,1,1,2,4]]
Output: [[0,4],[1,3],[1,4],[2,2],[3,0],[3,1],[4,0]]

Example 2:
Input: heights = [[1]]
Output: [[0,0]]

Constraints:
• m == heights.length
• n == heights[r].length
• 1 <= m, n <= 200
• 0 <= heights[r][c] <= 10⁵""",
    bruteForce: Solution(
      code: """def pacificAtlantic(heights):
    if not heights:
        return []

    m, n = len(heights), len(heights[0])
    result = []

    def canReachOcean(i, j, ocean):
        visited = set()
        stack = [(i, j)]

        while stack:
            r, c = stack.pop()

            if (r, c) in visited:
                continue

            visited.add((r, c))

            # Check if reached ocean
            if ocean == 'pacific' and (r == 0 or c == 0):
                return True
            if ocean == 'atlantic' and (r == m-1 or c == n-1):
                return True

            # Try all 4 directions (water flows to lower or equal)
            for dr, dc in [(0,1), (0,-1), (1,0), (-1,0)]:
                nr, nc = r + dr, c + dc
                if (0 <= nr < m and 0 <= nc < n and
                    heights[nr][nc] <= heights[r][c]):
                    stack.append((nr, nc))

        return False

    for i in range(m):
        for j in range(n):
            if canReachOcean(i, j, 'pacific') and canReachOcean(i, j, 'atlantic'):
                result.append([i, j])

    return result""",
      timeComplexity: "O(m * n * m * n) = O((mn)²)",
      spaceComplexity: "O(m * n)",
      explanation: "For each cell, run separate DFS to check if it can reach Pacific and Atlantic. Very inefficient as it repeats work for each cell.",
      steps: [
        "For each cell in grid:",
        "  - Run DFS to check if can reach Pacific",
        "  - Run DFS to check if can reach Atlantic",
        "  - If both true, add to result",
        "DFS checks if can reach ocean by following water flow",
        "Water flows from higher to lower/equal cells",
        "Return result",
        "Note: Runs 2 DFS per cell, very slow"
      ],
    ),
    optimized: Solution(
      code: """def pacificAtlantic(heights):
    if not heights:
        return []

    m, n = len(heights), len(heights[0])
    pacific = set()
    atlantic = set()

    def dfs(i, j, visited):
        visited.add((i, j))

        for dr, dc in [(0,1), (0,-1), (1,0), (-1,0)]:
            ni, nj = i + dr, j + dc
            if (0 <= ni < m and 0 <= nj < n and
                (ni, nj) not in visited and
                heights[ni][nj] >= heights[i][j]):  # Flow backward
                dfs(ni, nj, visited)

    # DFS from Pacific border
    for i in range(m):
        dfs(i, 0, pacific)
    for j in range(n):
        dfs(0, j, pacific)

    # DFS from Atlantic border
    for i in range(m):
        dfs(i, n-1, atlantic)
    for j in range(n):
        dfs(m-1, j, atlantic)

    # Find intersection
    return [[i, j] for i in range(m) for j in range(n)
            if (i, j) in pacific and (i, j) in atlantic]""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(m * n)",
      explanation: "Reverse approach: start from ocean borders and flow backward (to higher/equal cells). Find cells reachable from both oceans using intersection of two sets.",
      steps: [
        "Create sets for Pacific-reachable and Atlantic-reachable cells",
        "Define DFS that flows backward (to higher/equal heights)",
        "Start DFS from all Pacific border cells (top row, left column)",
        "Start DFS from all Atlantic border cells (bottom row, right column)",
        "Both DFS mark all reachable cells in respective sets",
        "Return cells present in both sets (intersection)",
        "Key: Reverse flow from borders, single DFS per ocean, O(mn) total"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 130,
    title: "Surrounded Regions",
    difficulty: Difficulty.medium,
    category: "Graphs",
    question: """Given an m x n matrix board containing 'X' and 'O', capture all regions that are 4-directionally surrounded by 'X'.

A region is captured by flipping all 'O's into 'X's in that surrounded region.

Example 1:
Input: board = [["X","X","X","X"],["X","O","O","X"],["X","X","O","X"],["X","O","X","X"]]
Output: [["X","X","X","X"],["X","X","X","X"],["X","X","X","X"],["X","O","X","X"]]

Example 2:
Input: board = [["X"]]
Output: [["X"]]

Constraints:
• m == board.length
• n == board[i].length
• 1 <= m, n <= 200
• board[i][j] is 'X' or 'O'.""",
    bruteForce: Solution(
      code: """def solve(board):
    if not board:
        return

    m, n = len(board), len(board[0])

    def isSurrounded(i, j, visited):
        if i < 0 or i >= m or j < 0 or j >= n:
            return False  # Reached border

        if board[i][j] == 'X' or (i, j) in visited:
            return True

        visited.add((i, j))

        top = isSurrounded(i-1, j, visited)
        bottom = isSurrounded(i+1, j, visited)
        left = isSurrounded(i, j-1, visited)
        right = isSurrounded(i, j+1, visited)

        return top and bottom and left and right

    for i in range(m):
        for j in range(n):
            if board[i][j] == 'O':
                visited = set()
                if isSurrounded(i, j, visited):
                    for r, c in visited:
                        board[r][c] = 'X'""",
      timeComplexity: "O((mn)²)",
      spaceComplexity: "O(m * n)",
      explanation: "For each 'O', run DFS to check if entire region is surrounded. If surrounded, flip all cells in region. Inefficient due to repeated work.",
      steps: [
        "For each 'O' cell:",
        "  - Run DFS to check if region reaches border",
        "  - Track visited cells in region",
        "  - If region surrounded (doesn't reach border), flip all to 'X'",
        "DFS returns False if reaches border, True if surrounded",
        "Note: Checks same regions multiple times"
      ],
    ),
    optimized: Solution(
      code: """def solve(board):
    if not board:
        return

    m, n = len(board), len(board[0])

    def dfs(i, j):
        if i < 0 or i >= m or j < 0 or j >= n or board[i][j] != 'O':
            return

        board[i][j] = 'T'  # Temporary mark
        dfs(i+1, j)
        dfs(i-1, j)
        dfs(i, j+1)
        dfs(i, j-1)

    # Mark border-connected 'O's as 'T'
    for i in range(m):
        dfs(i, 0)
        dfs(i, n-1)
    for j in range(n):
        dfs(0, j)
        dfs(m-1, j)

    # Flip surrounded 'O's to 'X', restore 'T's to 'O'
    for i in range(m):
        for j in range(n):
            if board[i][j] == 'O':
                board[i][j] = 'X'
            elif board[i][j] == 'T':
                board[i][j] = 'O'""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(1) - excluding recursion",
      explanation: "Reverse approach: mark all border-connected 'O's (these can't be surrounded). Then flip remaining 'O's to 'X' and restore marked cells back to 'O'.",
      steps: [
        "Define DFS to mark cells as 'T' (temporary)",
        "Run DFS from all border cells to mark border-connected regions",
        "  - Top and bottom rows",
        "  - Left and right columns",
        "After marking, iterate through board:",
        "  - 'O' cells are surrounded, flip to 'X'",
        "  - 'T' cells are border-connected, restore to 'O'",
        "Key: Single pass marking + single pass flipping, O(mn) time"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 207,
    title: "Course Schedule",
    difficulty: Difficulty.medium,
    category: "Graphs",
    question: """There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.

For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.

Return true if you can finish all courses. Otherwise, return false.

Example 1:
Input: numCourses = 2, prerequisites = [[1,0]]
Output: true
Explanation: There are a total of 2 courses to take. To take course 1 you should have finished course 0. So it is possible.

Example 2:
Input: numCourses = 2, prerequisites = [[1,0],[0,1]]
Output: false
Explanation: There are a total of 2 courses to take. To take course 1 you should have finished course 0, and to take course 0 you should also have finished course 1. So it is impossible.

Constraints:
• 1 <= numCourses <= 2000
• 0 <= prerequisites.length <= 5000
• prerequisites[i].length == 2
• 0 <= ai, bi < numCourses
• All the pairs prerequisites[i] are unique.""",
    bruteForce: Solution(
      code: """def canFinish(numCourses, prerequisites):
    # Build adjacency list
    graph = {i: [] for i in range(numCourses)}
    for course, prereq in prerequisites:
        graph[course].append(prereq)

    def hasCycle(node, visited, rec_stack):
        visited.add(node)
        rec_stack.add(node)

        for neighbor in graph[node]:
            if neighbor not in visited:
                if hasCycle(neighbor, visited, rec_stack):
                    return True
            elif neighbor in rec_stack:
                return True

        rec_stack.remove(node)
        return False

    visited = set()
    for course in range(numCourses):
        if course not in visited:
            if hasCycle(course, visited, set()):
                return False

    return True""",
      timeComplexity: "O(V + E)",
      spaceComplexity: "O(V + E)",
      explanation: "Detect cycle using DFS with recursion stack. If cycle exists, courses can't be completed. Uses both visited and recursion stack sets.",
      steps: [
        "Build adjacency list from prerequisites",
        "Define hasCycle using DFS with visited and recursion stack",
        "Mark node as visited and add to recursion stack",
        "For each neighbor:",
        "  - If not visited, recurse",
        "  - If in recursion stack, cycle detected",
        "Remove from recursion stack before returning",
        "Check all nodes for cycles",
        "Return False if cycle found, True otherwise"
      ],
    ),
    optimized: Solution(
      code: """def canFinish(numCourses, prerequisites):
    graph = {i: [] for i in range(numCourses)}
    for course, prereq in prerequisites:
        graph[course].append(prereq)

    # 0 = unvisited, 1 = visiting, 2 = visited
    state = [0] * numCourses

    def hasCycle(node):
        if state[node] == 1:  # Currently visiting = cycle
            return True
        if state[node] == 2:  # Already visited
            return False

        state[node] = 1  # Mark as visiting

        for neighbor in graph[node]:
            if hasCycle(neighbor):
                return True

        state[node] = 2  # Mark as visited
        return False

    for course in range(numCourses):
        if hasCycle(course):
            return False

    return True""",
      timeComplexity: "O(V + E)",
      spaceComplexity: "O(V + E)",
      explanation: "Optimized cycle detection using tri-color marking (unvisited, visiting, visited). Single array tracks state instead of two sets.",
      steps: [
        "Build adjacency list",
        "Create state array: 0=unvisited, 1=visiting, 2=visited",
        "Define hasCycle DFS:",
        "  - If node is visiting (1), cycle detected",
        "  - If node is visited (2), already processed",
        "  - Mark as visiting",
        "  - Check all neighbors recursively",
        "  - Mark as visited before returning",
        "Check all courses",
        "Return True if no cycles",
        "Key: Tri-color marking is cleaner and slightly more efficient"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 210,
    title: "Course Schedule II",
    difficulty: Difficulty.medium,
    category: "Graphs",
    question: """There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1. You are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.

For example, the pair [0, 1], indicates that to take course 0 you have to first take course 1.

Return the ordering of courses you should take to finish all courses. If there are many valid answers, return any of them. If it is impossible to finish all courses, return an empty array.

Example 1:
Input: numCourses = 2, prerequisites = [[1,0]]
Output: [0,1]
Explanation: There are a total of 2 courses to take. To take course 1 you should have finished course 0. So the correct course order is [0,1].

Example 2:
Input: numCourses = 4, prerequisites = [[1,0],[2,0],[3,1],[3,2]]
Output: [0,2,1,3]

Example 3:
Input: numCourses = 1, prerequisites = []
Output: [0]

Constraints:
• 1 <= numCourses <= 2000
• 0 <= prerequisites.length <= numCourses * (numCourses - 1)
• prerequisites[i].length == 2
• 0 <= ai, bi < numCourses
• ai != bi
• All the pairs [ai, bi] are distinct.""",
    bruteForce: Solution(
      code: """def findOrder(numCourses, prerequisites):
    graph = {i: [] for i in range(numCourses)}
    for course, prereq in prerequisites:
        graph[course].append(prereq)

    result = []
    state = [0] * numCourses  # 0=unvisited, 1=visiting, 2=visited

    def dfs(node):
        if state[node] == 1:
            return False  # Cycle
        if state[node] == 2:
            return True   # Already processed

        state[node] = 1

        for neighbor in graph[node]:
            if not dfs(neighbor):
                return False

        state[node] = 2
        result.append(node)  # Add after processing dependencies
        return True

    for course in range(numCourses):
        if not dfs(course):
            return []

    return result""",
      timeComplexity: "O(V + E)",
      spaceComplexity: "O(V + E)",
      explanation: "Use DFS with post-order addition to result. When a node finishes processing (all dependencies done), add it to result. Reverse post-order gives topological order.",
      steps: [
        "Build adjacency list",
        "Initialize result list and state array",
        "Define DFS that returns False if cycle detected",
        "Mark node as visiting",
        "Recursively process all neighbors",
        "After all neighbors processed, mark as visited",
        "Add node to result (post-order)",
        "Run DFS for all courses",
        "Return empty array if cycle, else return result",
        "Note: Result is already in topological order"
      ],
    ),
    optimized: Solution(
      code: """def findOrder(numCourses, prerequisites):
    # Build adjacency list and in-degree
    graph = {i: [] for i in range(numCourses)}
    in_degree = [0] * numCourses

    for course, prereq in prerequisites:
        graph[prereq].append(course)
        in_degree[course] += 1

    # Start with courses having no prerequisites
    from collections import deque
    queue = deque([i for i in range(numCourses) if in_degree[i] == 0])
    result = []

    while queue:
        course = queue.popleft()
        result.append(course)

        for neighbor in graph[course]:
            in_degree[neighbor] -= 1
            if in_degree[neighbor] == 0:
                queue.append(neighbor)

    return result if len(result) == numCourses else []""",
      timeComplexity: "O(V + E)",
      spaceComplexity: "O(V + E)",
      explanation: "Kahn's algorithm for topological sort using BFS. Start with courses having no prerequisites, process them, and add newly available courses to queue.",
      steps: [
        "Build adjacency list (prereq -> courses)",
        "Build in-degree array (count of prerequisites per course)",
        "Initialize queue with all courses having in-degree 0",
        "While queue not empty:",
        "  - Dequeue course and add to result",
        "  - For each dependent course, decrease in-degree",
        "  - If in-degree becomes 0, add to queue",
        "If result size equals numCourses, return it",
        "Otherwise cycle exists, return empty array",
        "Key: BFS topological sort, cleaner than DFS for this problem"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 684,
    title: "Redundant Connection",
    difficulty: Difficulty.medium,
    category: "Graphs",
    question: """In this problem, a tree is an undirected graph that is connected and has no cycles.

You are given a graph that started as a tree with n nodes labeled from 1 to n, with one additional edge added. The added edge has two different vertices chosen from 1 to n, and was not an edge that already existed. The graph is represented as an array edges of length n where edges[i] = [ai, bi] indicates that there is an edge between nodes ai and bi in the graph.

Return an edge that can be removed so that the resulting graph is a tree of n nodes. If there are multiple answers, return the answer that occurs last in the input.

Example 1:
Input: edges = [[1,2],[1,3],[2,3]]
Output: [2,3]

Example 2:
Input: edges = [[1,2],[2,3],[3,4],[1,4],[1,5]]
Output: [1,4]

Constraints:
• n == edges.length
• 3 <= n <= 1000
• edges[i].length == 2
• 1 <= ai < bi <= edges.length
• ai != bi
• There are no repeated edges.
• The given graph is connected.""",
    bruteForce: Solution(
      code: """def findRedundantConnection(edges):
    def hasCycle(n, edge_list):
        graph = {i: [] for i in range(1, n + 1)}
        for u, v in edge_list:
            graph[u].append(v)
            graph[v].append(u)

        visited = set()

        def dfs(node, parent):
            visited.add(node)
            for neighbor in graph[node]:
                if neighbor == parent:
                    continue
                if neighbor in visited:
                    return True
                if dfs(neighbor, node):
                    return True
            return False

        for i in range(1, n + 1):
            if i not in visited:
                if dfs(i, -1):
                    return True
        return False

    # Try removing each edge from end to start
    for i in range(len(edges) - 1, -1, -1):
        if not hasCycle(len(edges), edges[:i] + edges[i+1:]):
            return edges[i]

    return []""",
      timeComplexity: "O(n³)",
      spaceComplexity: "O(n)",
      explanation: "Try removing each edge from end to start, check if resulting graph has cycle. First edge whose removal eliminates cycle is the answer. Very slow.",
      steps: [
        "Define hasCycle function to check if graph has cycle using DFS",
        "For each edge from end to start:",
        "  - Create graph without this edge",
        "  - Check if cycle exists",
        "  - If no cycle, this is the redundant edge",
        "Return the redundant edge",
        "Note: Rebuilds graph and runs DFS for each edge, O(n³)"
      ],
    ),
    optimized: Solution(
      code: """def findRedundantConnection(edges):
    parent = list(range(len(edges) + 1))

    def find(x):
        if parent[x] != x:
            parent[x] = find(parent[x])  # Path compression
        return parent[x]

    def union(x, y):
        root_x = find(x)
        root_y = find(y)

        if root_x == root_y:
            return False  # Already connected = cycle

        parent[root_x] = root_y
        return True

    for u, v in edges:
        if not union(u, v):
            return [u, v]

    return []""",
      timeComplexity: "O(n * α(n)) ≈ O(n)",
      spaceComplexity: "O(n)",
      explanation: "Use Union-Find (Disjoint Set Union). Process edges in order. First edge that connects two already-connected nodes creates a cycle.",
      steps: [
        "Initialize parent array for Union-Find",
        "Define find with path compression",
        "Define union that returns False if nodes already connected",
        "For each edge in order:",
        "  - Try to union the two nodes",
        "  - If union returns False, nodes already in same set",
        "  - This edge creates cycle, return it",
        "Key: Union-Find efficiently tracks connected components",
        "First edge connecting same component is redundant"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 127,
    title: "Word Ladder",
    difficulty: Difficulty.hard,
    category: "Graphs",
    question: """A transformation sequence from word beginWord to word endWord using a dictionary wordList is a sequence of words beginWord -> s1 -> s2 -> ... -> sk such that:
• Every adjacent pair of words differs by a single letter.
• Every si for 1 <= i <= k is in wordList. Note that beginWord does not need to be in wordList.
• sk == endWord

Given two words, beginWord and endWord, and a dictionary wordList, return the number of words in the shortest transformation sequence from beginWord to endWord, or 0 if no such sequence exists.

Example 1:
Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log","cog"]
Output: 5
Explanation: One shortest transformation sequence is "hit" -> "hot" -> "dot" -> "dog" -> "cog", which is 5 words long.

Example 2:
Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log"]
Output: 0
Explanation: The endWord "cog" is not in wordList, therefore there is no valid transformation sequence.

Constraints:
• 1 <= beginWord.length <= 10
• endWord.length == beginWord.length
• 1 <= wordList.length <= 5000
• wordList[i].length == beginWord.length
• beginWord, endWord, and wordList[i] consist of lowercase English letters.
• beginWord != endWord
• All the words in wordList are unique.""",
    bruteForce: Solution(
      code: """def ladderLength(beginWord, endWord, wordList):
    if endWord not in wordList:
        return 0

    def differsByOne(w1, w2):
        diff = 0
        for i in range(len(w1)):
            if w1[i] != w2[i]:
                diff += 1
                if diff > 1:
                    return False
        return diff == 1

    # Build graph
    wordList.append(beginWord)
    graph = {word: [] for word in wordList}

    for i in range(len(wordList)):
        for j in range(i + 1, len(wordList)):
            if differsByOne(wordList[i], wordList[j]):
                graph[wordList[i]].append(wordList[j])
                graph[wordList[j]].append(wordList[i])

    # BFS
    from collections import deque
    queue = deque([(beginWord, 1)])
    visited = {beginWord}

    while queue:
        word, steps = queue.popleft()

        if word == endWord:
            return steps

        for neighbor in graph[word]:
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append((neighbor, steps + 1))

    return 0""",
      timeComplexity: "O(n² * m) - n words, m word length",
      spaceComplexity: "O(n² + n*m)",
      explanation: "Build explicit graph by comparing all word pairs. Then BFS to find shortest path. Building graph is expensive O(n²*m).",
      steps: [
        "Check if endWord in wordList",
        "Define differsByOne to check if two words differ by 1 char",
        "Build adjacency list by comparing all pairs O(n²*m)",
        "Add beginWord to wordList and graph",
        "Run BFS from beginWord:",
        "  - Track (word, steps)",
        "  - If reach endWord, return steps",
        "  - Add unvisited neighbors to queue",
        "Return 0 if endWord unreachable",
        "Note: O(n²) graph building is slow"
      ],
    ),
    optimized: Solution(
      code: """def ladderLength(beginWord, endWord, wordList):
    if endWord not in wordList:
        return 0

    wordSet = set(wordList)
    from collections import deque

    queue = deque([(beginWord, 1)])
    visited = {beginWord}

    while queue:
        word, steps = queue.popleft()

        if word == endWord:
            return steps

        # Try all possible one-character changes
        for i in range(len(word)):
            for c in 'abcdefghijklmnopqrstuvwxyz':
                next_word = word[:i] + c + word[i+1:]

                if next_word in wordSet and next_word not in visited:
                    visited.add(next_word)
                    queue.append((next_word, steps + 1))

    return 0""",
      timeComplexity: "O(n * m² * 26) = O(n * m²)",
      spaceComplexity: "O(n * m)",
      explanation: "Skip graph building. In BFS, generate all possible one-letter changes and check if in wordSet. More efficient for sparse graphs.",
      steps: [
        "Check endWord in wordList",
        "Convert wordList to set for O(1) lookup",
        "Initialize BFS queue with (beginWord, 1)",
        "While queue not empty:",
        "  - Dequeue current word and steps",
        "  - If endWord, return steps",
        "  - For each position in word:",
        "    - Try each letter a-z",
        "    - If resulting word in wordSet and not visited:",
        "      - Mark visited and add to queue with steps+1",
        "Return 0 if no path found",
        "Key: On-the-fly neighbor generation, no explicit graph"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 994,
    title: "Rotting Oranges",
    difficulty: Difficulty.medium,
    category: "Graphs",
    question: """You are given an m x n grid where each cell can have one of three values:

• 0 representing an empty cell,
• 1 representing a fresh orange, or
• 2 representing a rotten orange.

Every minute, any fresh orange that is 4-directionally adjacent to a rotten orange becomes rotten.

Return the minimum number of minutes that must elapse until no cell has a fresh orange. If this is impossible, return -1.

Example 1:
Input: grid = [[2,1,1],[1,1,0],[0,1,1]]
Output: 4

Example 2:
Input: grid = [[2,1,1],[0,1,1],[1,0,1]]
Output: -1
Explanation: The orange in the bottom left corner (row 2, column 0) is never rotten, because rotting only happens 4-directionally.

Example 3:
Input: grid = [[0,2]]
Output: 0
Explanation: Since there are already no fresh oranges at minute 0, the answer is just 0.

Constraints:
• m == grid.length
• n == grid[i].length
• 1 <= m, n <= 10
• grid[i][j] is 0, 1, or 2.""",
    bruteForce: Solution(
      code: """def orangesRotting(grid):
    m, n = len(grid), len(grid[0])
    fresh = 0
    minutes = 0

    # Count fresh oranges
    for i in range(m):
        for j in range(n):
            if grid[i][j] == 1:
                fresh += 1

    if fresh == 0:
        return 0

    # Simulate rotting minute by minute
    while True:
        new_rotten = []

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 2:
                    # Check 4 directions
                    for di, dj in [(0,1), (0,-1), (1,0), (-1,0)]:
                        ni, nj = i + di, j + dj
                        if 0 <= ni < m and 0 <= nj < n and grid[ni][nj] == 1:
                            new_rotten.append((ni, nj))

        if not new_rotten:
            break

        for i, j in new_rotten:
            grid[i][j] = 2
            fresh -= 1

        minutes += 1

    return minutes if fresh == 0 else -1""",
      timeComplexity: "O(m * n * (m * n))",
      spaceComplexity: "O(m * n)",
      explanation: "Simulate the rotting process minute by minute. Each minute, scan entire grid to find rotten oranges, then mark adjacent fresh oranges. Very inefficient.",
      steps: [
        "Count initial fresh oranges",
        "If no fresh oranges, return 0",
        "Loop until no new oranges rot:",
        "  - Scan entire grid for rotten oranges (2)",
        "  - For each rotten, check 4 adjacent cells",
        "  - Mark fresh adjacent oranges for rotting",
        "  - Rot marked oranges and decrement fresh count",
        "  - Increment minutes",
        "Return minutes if all fresh rotted, else -1",
        "Note: Scans grid O(mn) times, each scan O(mn)"
      ],
    ),
    optimized: Solution(
      code: """def orangesRotting(grid):
    from collections import deque

    m, n = len(grid), len(grid[0])
    queue = deque()
    fresh = 0

    # Find all rotten oranges and count fresh
    for i in range(m):
        for j in range(n):
            if grid[i][j] == 2:
                queue.append((i, j, 0))  # (row, col, time)
            elif grid[i][j] == 1:
                fresh += 1

    if fresh == 0:
        return 0

    minutes = 0

    # BFS from all rotten oranges
    while queue:
        i, j, time = queue.popleft()
        minutes = max(minutes, time)

        for di, dj in [(0,1), (0,-1), (1,0), (-1,0)]:
            ni, nj = i + di, j + dj

            if 0 <= ni < m and 0 <= nj < n and grid[ni][nj] == 1:
                grid[ni][nj] = 2
                fresh -= 1
                queue.append((ni, nj, time + 1))

    return minutes if fresh == 0 else -1""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(m * n)",
      explanation: "Multi-source BFS. Start BFS from all initially rotten oranges simultaneously. Each fresh orange is visited once when it rots.",
      steps: [
        "Initialize queue and fresh counter",
        "Scan grid once to:",
        "  - Add all rotten oranges to queue with time 0",
        "  - Count fresh oranges",
        "If no fresh oranges, return 0",
        "BFS from all rotten oranges:",
        "  - Process each rotten orange",
        "  - Check 4 adjacent cells",
        "  - If fresh, mark as rotten, decrement fresh, add to queue with time+1",
        "  - Track max time",
        "Return max time if all fresh rotted, else -1",
        "Key: Multi-source BFS, each cell visited once"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 286,
    title: "Walls and Gates",
    difficulty: Difficulty.medium,
    category: "Graphs",
    question: """You are given an m x n grid rooms initialized with these three possible values:

• -1 A wall or an obstacle.
• 0 A gate.
• INF Infinity means an empty room. We use the value 2³¹ - 1 = 2147483647 to represent INF as you may assume that the distance to a gate is less than 2147483647.

Fill each empty room with the distance to its nearest gate. If it is impossible to reach a gate, it should be filled with INF.

Example 1:
Input: rooms = [[2147483647,-1,0,2147483647],[2147483647,2147483647,2147483647,-1],[2147483647,-1,2147483647,-1],[0,-1,2147483647,2147483647]]
Output: [[3,-1,0,1],[2,2,1,-1],[1,-1,2,-1],[0,-1,3,4]]

Example 2:
Input: rooms = [[-1]]
Output: [[-1]]

Constraints:
• m == rooms.length
• n == rooms[i].length
• 1 <= m, n <= 250
• rooms[i][j] is -1, 0, or 2³¹ - 1.""",
    bruteForce: Solution(
      code: """def wallsAndGates(rooms):
    if not rooms:
        return

    m, n = len(rooms), len(rooms[0])
    INF = 2147483647

    def bfs(i, j):
        from collections import deque
        queue = deque([(i, j, 0)])
        visited = {(i, j)}
        min_dist = INF

        while queue:
            r, c, dist = queue.popleft()

            if rooms[r][c] == 0:
                min_dist = min(min_dist, dist)
                continue

            for dr, dc in [(0,1), (0,-1), (1,0), (-1,0)]:
                nr, nc = r + dr, c + dc

                if (0 <= nr < m and 0 <= nc < n and
                    (nr, nc) not in visited and rooms[nr][nc] != -1):
                    visited.add((nr, nc))
                    queue.append((nr, nc, dist + 1))

        return min_dist

    # For each empty room, BFS to find nearest gate
    for i in range(m):
        for j in range(n):
            if rooms[i][j] == INF:
                rooms[i][j] = bfs(i, j)""",
      timeComplexity: "O((mn)²)",
      spaceComplexity: "O(m * n)",
      explanation: "For each empty room, run BFS to find nearest gate. Very inefficient as each BFS can visit entire grid.",
      steps: [
        "For each cell with INF value:",
        "  - Run BFS to find nearest gate",
        "  - Track minimum distance found",
        "  - Update cell with distance",
        "BFS explores from empty room to gates",
        "Note: Runs BFS for each empty room, O((mn)²)"
      ],
    ),
    optimized: Solution(
      code: """def wallsAndGates(rooms):
    if not rooms:
        return

    from collections import deque
    m, n = len(rooms), len(rooms[0])
    INF = 2147483647
    queue = deque()

    # Add all gates to queue
    for i in range(m):
        for j in range(n):
            if rooms[i][j] == 0:
                queue.append((i, j))

    # Multi-source BFS from all gates
    while queue:
        i, j = queue.popleft()

        for di, dj in [(0,1), (0,-1), (1,0), (-1,0)]:
            ni, nj = i + di, j + dj

            if (0 <= ni < m and 0 <= nj < n and rooms[ni][nj] == INF):
                rooms[ni][nj] = rooms[i][j] + 1
                queue.append((ni, nj))""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(m * n)",
      explanation: "Multi-source BFS from all gates simultaneously. Each empty room is visited once and gets distance from nearest gate automatically.",
      steps: [
        "Find all gates and add to queue",
        "Run multi-source BFS:",
        "  - Process each cell in queue",
        "  - Check 4 adjacent cells",
        "  - If adjacent cell is INF (unvisited empty room):",
        "    - Set distance = current distance + 1",
        "    - Add to queue",
        "BFS ensures first visit to each cell is from nearest gate",
        "Key: Multi-source BFS, each cell visited once, O(mn) time"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 323,
    title: "Number of Connected Components in Undirected Graph",
    difficulty: Difficulty.medium,
    category: "Graphs",
    question: """You have a graph of n nodes labeled from 0 to n - 1. You are given an integer n and an array edges where edges[i] = [ai, bi] indicates that there is an undirected edge between nodes ai and bi in the graph.

Return the number of connected components in the graph.

Example 1:
Input: n = 5, edges = [[0,1],[1,2],[3,4]]
Output: 2

Example 2:
Input: n = 5, edges = [[0,1],[1,2],[2,3],[3,4]]
Output: 1

Constraints:
• 1 <= n <= 2000
• 1 <= edges.length <= 5000
• edges[i].length == 2
• 0 <= ai <= bi < n
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

    # Start DFS from each unvisited node
    for i in range(n):
        if i not in visited:
            dfs(i)
            count += 1

    return count""",
      timeComplexity: "O(V + E)",
      spaceComplexity: "O(V + E)",
      explanation: "Build adjacency list and use DFS to explore connected components. Each DFS marks all nodes in one component.",
      steps: [
        "Build adjacency list from edges",
        "Initialize visited set and component counter",
        "Define DFS to mark all nodes in component",
        "For each node:",
        "  - If not visited, start DFS",
        "  - DFS marks entire connected component",
        "  - Increment component count",
        "Return total components"
      ],
    ),
    optimized: Solution(
      code: """def countComponents(n, edges):
    parent = list(range(n))

    def find(x):
        if parent[x] != x:
            parent[x] = find(parent[x])  # Path compression
        return parent[x]

    def union(x, y):
        root_x = find(x)
        root_y = find(y)

        if root_x != root_y:
            parent[root_x] = root_y
            return True
        return False

    components = n

    for u, v in edges:
        if union(u, v):
            components -= 1

    return components""",
      timeComplexity: "O(E * α(n)) ≈ O(E)",
      spaceComplexity: "O(n)",
      explanation: "Use Union-Find. Start with n components (each node isolated). Each successful union merges two components, reducing count by 1.",
      steps: [
        "Initialize parent array for Union-Find",
        "Start with n components (each node is separate)",
        "Define find with path compression",
        "Define union that merges components",
        "For each edge:",
        "  - Try to union the two nodes",
        "  - If they were in different components, decrement count",
        "Return final component count",
        "Key: Union-Find is more efficient, no graph building needed"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 261,
    title: "Graph Valid Tree",
    difficulty: Difficulty.medium,
    category: "Graphs",
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

    visited = set()

    def hasCycle(node, parent):
        visited.add(node)

        for neighbor in graph[node]:
            if neighbor == parent:
                continue

            if neighbor in visited:
                return True  # Cycle detected

            if hasCycle(neighbor, node):
                return True

        return False

    # Check for cycles
    if hasCycle(0, -1):
        return False

    # Check if all nodes connected
    return len(visited) == n""",
      timeComplexity: "O(V + E)",
      spaceComplexity: "O(V + E)",
      explanation: "Valid tree must have: (1) exactly n-1 edges, (2) no cycles, (3) all nodes connected. Build graph, check for cycles with DFS, verify all nodes visited.",
      steps: [
        "Check if edges count equals n-1 (tree property)",
        "Build adjacency list",
        "Define DFS to detect cycles:",
        "  - Track parent to avoid false positive",
        "  - If visit already-visited node (not parent), cycle found",
        "Run DFS from node 0",
        "If cycle found, return False",
        "If not all nodes visited, graph disconnected, return False",
        "Otherwise valid tree, return True"
      ],
    ),
    optimized: Solution(
      code: """def validTree(n, edges):
    # Tree must have exactly n-1 edges
    if len(edges) != n - 1:
        return False

    # Build adjacency list
    graph = {i: [] for i in range(n)}
    for u, v in edges:
        graph[u].append(v)
        graph[v].append(u)

    # BFS to check connectivity
    from collections import deque
    visited = set([0])
    queue = deque([0])

    while queue:
        node = queue.popleft()

        for neighbor in graph[node]:
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append(neighbor)

    # If all nodes visited, no cycles (guaranteed by n-1 edges)
    return len(visited) == n""",
      timeComplexity: "O(V + E)",
      spaceComplexity: "O(V + E)",
      explanation: "Simplified approach: if exactly n-1 edges and all nodes connected, it's a valid tree (no cycle possible). Use BFS to verify connectivity.",
      steps: [
        "Check if edge count equals n-1",
        "Build adjacency list",
        "Run BFS from node 0 to count reachable nodes",
        "If all n nodes reached, graph is connected",
        "With n-1 edges and full connectivity, no cycles possible",
        "Return True if all nodes visited, False otherwise",
        "Key: n-1 edges + connectivity = valid tree",
        "No explicit cycle detection needed"
      ],
    ),
  ),

];
