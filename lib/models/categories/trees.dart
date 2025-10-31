import '../leetcode_question.dart';

// NeetCode 150 - Trees Category
// 15 questions with complete solutions

// Definition for a binary tree node:
// class TreeNode:
//     def __init__(self, val=0, left=None, right=None):
//         self.val = val
//         self.left = left
//         self.right = right

final List<LeetCodeQuestion> treesQuestions = [

  LeetCodeQuestion(
    id: 226,
    title: "Invert Binary Tree",
    difficulty: Difficulty.easy,
    category: "Trees",
    question: """Given the root of a binary tree, invert the tree, and return its root.

Example 1:
Input: root = [4,2,7,1,3,6,9]
Output: [4,7,2,9,6,3,1]

Example 2:
Input: root = [2,1,3]
Output: [2,3,1]

Example 3:
Input: root = []
Output: []

Constraints:
• The number of nodes in the tree is in the range [0, 100].
• -100 <= Node.val <= 100""",
    bruteForce: Solution(
      code: """def invertTree(root):
    if not root:
        return None

    # Create new tree with inverted structure
    new_root = TreeNode(root.val)

    if root.left:
        new_root.right = invertTree(root.left)
    if root.right:
        new_root.left = invertTree(root.right)

    return new_root""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Create a new tree by recursively building inverted nodes. For each node, create a new node and recursively attach left child to new right and right child to new left.",
      steps: [
        "Base case: if root is None, return None",
        "Create new node with same value as root",
        "If original root has left child, recursively invert it and attach to new_root.right",
        "If original root has right child, recursively invert it and attach to new_root.left",
        "Return new_root",
        "Note: Creates entirely new tree, uses O(n) extra space"
      ],
    ),
    optimized: Solution(
      code: """def invertTree(root):
    if not root:
        return None

    # Swap children
    root.left, root.right = root.right, root.left

    # Recursively invert subtrees
    invertTree(root.left)
    invertTree(root.right)

    return root""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(h) - h is height, for recursion",
      explanation: "Invert tree in-place by swapping left and right children at each node, then recursively inverting the subtrees. No extra space needed except recursion stack.",
      steps: [
        "Base case: if root is None, return None",
        "Swap left and right children of current node",
        "Recursively invert left subtree",
        "Recursively invert right subtree",
        "Return root (now inverted)",
        "Key: In-place modification, O(h) space for recursion stack"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 104,
    title: "Maximum Depth of Binary Tree",
    difficulty: Difficulty.easy,
    category: "Trees",
    question: """Given the root of a binary tree, return its maximum depth.

A binary tree's maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.

Example 1:
Input: root = [3,9,20,null,null,15,7]
Output: 3

Example 2:
Input: root = [1,null,2]
Output: 2

Constraints:
• The number of nodes in the tree is in the range [0, 10⁴].
• -100 <= Node.val <= 100""",
    bruteForce: Solution(
      code: """def maxDepth(root):
    if not root:
        return 0

    # Level-order traversal (BFS)
    from collections import deque
    queue = deque([root])
    depth = 0

    while queue:
        depth += 1
        level_size = len(queue)

        for i in range(level_size):
            node = queue.popleft()
            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)

    return depth""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(w) - w is max width",
      explanation: "Use level-order traversal (BFS) with a queue. Process the tree level by level, incrementing depth counter for each level. Space depends on tree width.",
      steps: [
        "Base case: if root is None, return 0",
        "Import deque and initialize queue with root",
        "Initialize depth counter to 0",
        "While queue is not empty:",
        "  - Increment depth",
        "  - Get current level size",
        "  - Process all nodes in current level",
        "  - Add children of each node to queue",
        "Return depth",
        "Note: Uses queue, space depends on tree width"
      ],
    ),
    optimized: Solution(
      code: """def maxDepth(root):
    if not root:
        return 0

    left_depth = maxDepth(root.left)
    right_depth = maxDepth(root.right)

    return 1 + max(left_depth, right_depth)""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(h) - h is height, for recursion",
      explanation: "Recursive DFS approach. The depth of a tree is 1 plus the maximum depth of its subtrees. Base case returns 0 for empty tree.",
      steps: [
        "Base case: if root is None, return 0",
        "Recursively find depth of left subtree",
        "Recursively find depth of right subtree",
        "Return 1 (current node) + max(left_depth, right_depth)",
        "Key: Simple recursive definition, O(h) space for call stack"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 543,
    title: "Diameter of Binary Tree",
    difficulty: Difficulty.easy,
    category: "Trees",
    question: """Given the root of a binary tree, return the length of the diameter of the tree.

The diameter of a binary tree is the length of the longest path between any two nodes in a tree. This path may or may not pass through the root.

The length of a path between two nodes is represented by the number of edges between them.

Example 1:
Input: root = [1,2,3,4,5]
Output: 3
Explanation: 3 is the length of the path [4,2,1,3] or [5,2,1,3].

Example 2:
Input: root = [1,2]
Output: 1

Constraints:
• The number of nodes in the tree is in the range [1, 10⁴].
• -100 <= Node.val <= 100""",
    bruteForce: Solution(
      code: """def diameterOfBinaryTree(root):
    def height(node):
        if not node:
            return 0
        return 1 + max(height(node.left), height(node.right))

    if not root:
        return 0

    # Diameter could be:
    # 1. Through root: left_height + right_height
    # 2. In left subtree
    # 3. In right subtree

    left_height = height(root.left)
    right_height = height(root.right)
    through_root = left_height + right_height

    left_diameter = diameterOfBinaryTree(root.left)
    right_diameter = diameterOfBinaryTree(root.right)

    return max(through_root, left_diameter, right_diameter)""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(h)",
      explanation: "For each node, calculate diameter that passes through it (left_height + right_height) and recursively check left and right subtrees. The height function is called repeatedly, leading to O(n²) time.",
      steps: [
        "Define helper function height(node) to calculate tree height",
        "Base case: if root is None, return 0",
        "Calculate three possibilities:",
        "  1. Diameter through root: height(left) + height(right)",
        "  2. Diameter in left subtree: recursively find",
        "  3. Diameter in right subtree: recursively find",
        "Return maximum of three possibilities",
        "Note: Recalculates heights multiple times, O(n²)"
      ],
    ),
    optimized: Solution(
      code: """def diameterOfBinaryTree(root):
    diameter = 0

    def height(node):
        nonlocal diameter

        if not node:
            return 0

        left_height = height(node.left)
        right_height = height(node.right)

        # Update diameter at this node
        diameter = max(diameter, left_height + right_height)

        return 1 + max(left_height, right_height)

    height(root)
    return diameter""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(h)",
      explanation: "Calculate height and diameter in a single DFS traversal. At each node, update global diameter with left_height + right_height, then return height for parent's calculation.",
      steps: [
        "Initialize diameter variable to 0",
        "Define recursive height function that also updates diameter",
        "Base case: if node is None, return 0",
        "Recursively calculate left and right heights",
        "Update diameter: max(current_diameter, left_height + right_height)",
        "  (This represents longest path through current node)",
        "Return height of current node: 1 + max(left_height, right_height)",
        "Call height(root) to traverse tree",
        "Return diameter",
        "Key: Single traversal, O(n) time"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 110,
    title: "Balanced Binary Tree",
    difficulty: Difficulty.easy,
    category: "Trees",
    question: """Given a binary tree, determine if it is height-balanced.

A height-balanced binary tree is a binary tree in which the depth of the two subtrees of every node never differs by more than one.

Example 1:
Input: root = [3,9,20,null,null,15,7]
Output: true

Example 2:
Input: root = [1,2,2,3,3,null,null,4,4]
Output: false

Example 3:
Input: root = []
Output: true

Constraints:
• The number of nodes in the tree is in the range [0, 5000].
• -10⁴ <= Node.val <= 10⁴""",
    bruteForce: Solution(
      code: """def isBalanced(root):
    def height(node):
        if not node:
            return 0
        return 1 + max(height(node.left), height(node.right))

    if not root:
        return True

    left_height = height(root.left)
    right_height = height(root.right)

    if abs(left_height - right_height) > 1:
        return False

    return isBalanced(root.left) and isBalanced(root.right)""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(h)",
      explanation: "For each node, calculate heights of left and right subtrees and check if difference is <= 1. Recursively check all subtrees. Height is recalculated multiple times, leading to O(n²).",
      steps: [
        "Define helper function height(node) to calculate tree height",
        "Base case: if root is None, return True (empty tree is balanced)",
        "Calculate height of left subtree",
        "Calculate height of right subtree",
        "Check if absolute difference > 1:",
        "  - If yes, return False (not balanced)",
        "Recursively check if left subtree is balanced",
        "Recursively check if right subtree is balanced",
        "Return True only if both subtrees are balanced",
        "Note: Recalculates heights, O(n²) time"
      ],
    ),
    optimized: Solution(
      code: """def isBalanced(root):
    def check_height(node):
        if not node:
            return 0

        left_height = check_height(node.left)
        if left_height == -1:
            return -1  # Left subtree not balanced

        right_height = check_height(node.right)
        if right_height == -1:
            return -1  # Right subtree not balanced

        # Check if current node is balanced
        if abs(left_height - right_height) > 1:
            return -1  # Not balanced

        return 1 + max(left_height, right_height)

    return check_height(root) != -1""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(h)",
      explanation: "Single DFS traversal that returns height if balanced, -1 if unbalanced. Early termination when imbalance is detected. Combines height calculation with balance check.",
      steps: [
        "Define check_height function that returns height or -1 if unbalanced",
        "Base case: if node is None, return 0",
        "Recursively check left subtree height",
        "If left returns -1, propagate imbalance up (return -1)",
        "Recursively check right subtree height",
        "If right returns -1, propagate imbalance up (return -1)",
        "Check if current node is balanced: abs(left - right) <= 1",
        "If not balanced, return -1",
        "If balanced, return 1 + max(left_height, right_height)",
        "Tree is balanced if check_height(root) != -1",
        "Key: Single pass, early termination, O(n) time"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 100,
    title: "Same Tree",
    difficulty: Difficulty.easy,
    category: "Trees",
    question: """Given the roots of two binary trees p and q, write a function to check if they are the same or not.

Two binary trees are considered the same if they are structurally identical, and the nodes have the same value.

Example 1:
Input: p = [1,2,3], q = [1,2,3]
Output: true

Example 2:
Input: p = [1,2], q = [1,null,2]
Output: false

Example 3:
Input: p = [1,2,1], q = [1,1,2]
Output: false

Constraints:
• The number of nodes in both trees is in the range [0, 100].
• -10⁴ <= Node.val <= 10⁴""",
    bruteForce: Solution(
      code: """def isSameTree(p, q):
    # Serialize both trees to arrays
    def serialize(node):
        if not node:
            return [None]
        return [node.val] + serialize(node.left) + serialize(node.right)

    p_arr = serialize(p)
    q_arr = serialize(q)

    return p_arr == q_arr""",
      timeComplexity: "O(n + m)",
      spaceComplexity: "O(n + m)",
      explanation: "Serialize both trees to arrays (preorder traversal with None markers), then compare the arrays. Uses extra space to store both serializations.",
      steps: [
        "Define serialize function to convert tree to array",
        "  - Base case: None becomes [None]",
        "  - Recursively serialize: [value] + left + right",
        "Serialize tree p to array",
        "Serialize tree q to array",
        "Compare arrays for equality",
        "Return True if arrays are equal, False otherwise",
        "Note: Uses O(n+m) extra space for arrays"
      ],
    ),
    optimized: Solution(
      code: """def isSameTree(p, q):
    # Both null
    if not p and not q:
        return True

    # One null, one not null
    if not p or not q:
        return False

    # Values different
    if p.val != q.val:
        return False

    # Recursively check subtrees
    return isSameTree(p.left, q.left) and isSameTree(p.right, q.right)""",
      timeComplexity: "O(min(n, m))",
      spaceComplexity: "O(min(h1, h2)) - recursion depth",
      explanation: "Recursively compare nodes. Base cases: both null (same), one null (different), different values (different). Recursively check left and right subtrees.",
      steps: [
        "Base case 1: if both p and q are None, return True",
        "Base case 2: if only one is None, return False",
        "Check if current node values are different",
        "  - If different, return False",
        "Recursively check left subtrees: isSameTree(p.left, q.left)",
        "Recursively check right subtrees: isSameTree(p.right, q.right)",
        "Return True only if both subtree checks return True",
        "Key: Direct comparison, O(min(h1,h2)) space for recursion"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 572,
    title: "Subtree of Another Tree",
    difficulty: Difficulty.easy,
    category: "Trees",
    question: """Given the roots of two binary trees root and subRoot, return true if there is a subtree of root with the same structure and node values of subRoot and false otherwise.

A subtree of a binary tree tree is a tree that consists of a node in tree and all of this node's descendants. The tree tree could also be considered as a subtree of itself.

Example 1:
Input: root = [3,4,5,1,2], subRoot = [4,1,2]
Output: true

Example 2:
Input: root = [3,4,5,1,2,null,null,null,null,0], subRoot = [4,1,2]
Output: false

Constraints:
• The number of nodes in the root tree is in the range [1, 2000].
• The number of nodes in the subRoot tree is in the range [1, 1000].
• -10⁴ <= root.val <= 10⁴
• -10⁴ <= subRoot.val <= 10⁴""",
    bruteForce: Solution(
      code: """def isSubtree(root, subRoot):
    def serialize(node):
        if not node:
            return "#"
        return "^" + str(node.val) + " " + serialize(node.left) + " " + serialize(node.right) + "END"

    root_str = serialize(root)
    sub_str = serialize(subRoot)

    return sub_str in root_str""",
      timeComplexity: "O(n * m) - string search",
      spaceComplexity: "O(n + m)",
      explanation: "Serialize both trees to strings with markers for structure, then check if subRoot's string is a substring of root's string. Simple but uses extra space.",
      steps: [
        "Define serialize function to convert tree to unique string",
        "  Use special markers: ^ for start, dollar for end, # for null",
        "  Format: ^value left right dollar",
        "Serialize main tree to root_str",
        "Serialize subtree to sub_str",
        "Check if sub_str is substring of root_str",
        "Return True if substring found, False otherwise",
        "Note: String matching takes O(n*m) time"
      ],
    ),
    optimized: Solution(
      code: """def isSubtree(root, subRoot):
    def isSameTree(p, q):
        if not p and not q:
            return True
        if not p or not q:
            return False
        if p.val != q.val:
            return False
        return isSameTree(p.left, q.left) and isSameTree(p.right, q.right)

    if not root:
        return False

    # Check if trees are same starting from current root
    if isSameTree(root, subRoot):
        return True

    # Check left and right subtrees
    return isSubtree(root.left, subRoot) or isSubtree(root.right, subRoot)""",
      timeComplexity: "O(n * m) - worst case",
      spaceComplexity: "O(h) - recursion depth",
      explanation: "For each node in root, check if the tree starting at that node is identical to subRoot. Use isSameTree helper function. Recursively check all nodes.",
      steps: [
        "Define isSameTree helper function (from Same Tree problem)",
        "Base case: if root is None, return False",
        "Check if current tree (starting at root) matches subRoot",
        "  - Use isSameTree(root, subRoot)",
        "  - If True, return True (found match)",
        "Recursively check if subRoot is in left subtree",
        "Recursively check if subRoot is in right subtree",
        "Return True if found in either subtree",
        "Key: Check every node as potential subtree root, O(h) space"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 235,
    title: "Lowest Common Ancestor of a Binary Search Tree",
    difficulty: Difficulty.medium,
    category: "Trees",
    question: """Given a binary search tree (BST), find the lowest common ancestor (LCA) node of two given nodes in the BST.

According to the definition of LCA on Wikipedia: "The lowest common ancestor is defined between two nodes p and q as the lowest node in T that has both p and q as descendants (where we allow a node to be a descendant of itself)."

Example 1:
Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8
Output: 6
Explanation: The LCA of nodes 2 and 8 is 6.

Example 2:
Input: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 4
Output: 2
Explanation: The LCA of nodes 2 and 4 is 2, since a node can be a descendant of itself.

Example 3:
Input: root = [2,1], p = 2, q = 1
Output: 2

Constraints:
• The number of nodes in the tree is in the range [2, 10⁵].
• -10⁹ <= Node.val <= 10⁹
• All Node.val are unique.
• p != q
• p and q will exist in the BST.""",
    bruteForce: Solution(
      code: """def lowestCommonAncestor(root, p, q):
    def findPath(node, target, path):
        if not node:
            return False
        path.append(node)
        if node == target:
            return True
        if findPath(node.left, target, path) or findPath(node.right, target, path):
            return True
        path.pop()
        return False

    # Find paths to both nodes
    path_p = []
    path_q = []
    findPath(root, p, path_p)
    findPath(root, q, path_q)

    # Find divergence point
    lca = None
    for i in range(min(len(path_p), len(path_q))):
        if path_p[i] == path_q[i]:
            lca = path_p[i]
        else:
            break

    return lca""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Find paths from root to both nodes, then find the last common node in both paths. Doesn't use BST property.",
      steps: [
        "Define findPath function to find path from root to target",
        "  - Returns list of nodes from root to target",
        "Find path from root to p: path_p",
        "Find path from root to q: path_q",
        "Initialize lca to None",
        "Iterate through both paths simultaneously",
        "While nodes at index i are same, update lca",
        "When paths diverge, stop",
        "Return lca (last common node)",
        "Note: Doesn't use BST property, works for any binary tree"
      ],
    ),
    optimized: Solution(
      code: """def lowestCommonAncestor(root, p, q):
    current = root

    while current:
        # Both nodes in left subtree
        if p.val < current.val and q.val < current.val:
            current = current.left
        # Both nodes in right subtree
        elif p.val > current.val and q.val > current.val:
            current = current.right
        else:
            # Split point: current is LCA
            return current

    return None""",
      timeComplexity: "O(h) - h is height",
      spaceComplexity: "O(1)",
      explanation: "Use BST property: if both nodes are smaller, LCA is in left subtree; if both are larger, LCA is in right subtree; otherwise, current node is LCA (split point).",
      steps: [
        "Start at root",
        "While current node exists:",
        "  - If both p and q are less than current, go left",
        "  - If both p and q are greater than current, go right",
        "  - Otherwise, current is the split point (LCA)",
        "    - One is on left, one is on right, OR",
        "    - Current equals p or q",
        "Return current node",
        "Key: Uses BST property for O(h) time, O(1) space"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 102,
    title: "Binary Tree Level Order Traversal",
    difficulty: Difficulty.medium,
    category: "Trees",
    question: """Given the root of a binary tree, return the level order traversal of its nodes' values. (i.e., from left to right, level by level).

Example 1:
Input: root = [3,9,20,null,null,15,7]
Output: [[3],[9,20],[15,7]]

Example 2:
Input: root = [1]
Output: [[1]]

Example 3:
Input: root = []
Output: []

Constraints:
• The number of nodes in the tree is in the range [0, 2000].
• -1000 <= Node.val <= 1000""",
    bruteForce: Solution(
      code: """def levelOrder(root):
    if not root:
        return []

    result = []

    def traverse(node, level):
        if not node:
            return

        # Ensure result has a list for this level
        if level >= len(result):
            result.append([])

        result[level].append(node.val)

        traverse(node.left, level + 1)
        traverse(node.right, level + 1)

    traverse(root, 0)
    return result""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Use DFS with level parameter. For each node, add its value to the appropriate level in the result. Recursively traverse left and right with incremented level.",
      steps: [
        "Handle edge case: if root is None, return []",
        "Initialize empty result list",
        "Define recursive traverse function with node and level parameters",
        "Base case: if node is None, return",
        "Ensure result has a list for current level",
        "  - If level >= len(result), append new empty list",
        "Append node's value to result[level]",
        "Recursively traverse left child with level + 1",
        "Recursively traverse right child with level + 1",
        "Return result"
      ],
    ),
    optimized: Solution(
      code: """def levelOrder(root):
    if not root:
        return []

    from collections import deque
    result = []
    queue = deque([root])

    while queue:
        level_size = len(queue)
        current_level = []

        for i in range(level_size):
            node = queue.popleft()
            current_level.append(node.val)

            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)

        result.append(current_level)

    return result""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(w) - w is max width",
      explanation: "Use BFS with queue. Process tree level by level. For each level, process all nodes currently in queue, collect their values, and add their children for next level.",
      steps: [
        "Handle edge case: if root is None, return []",
        "Import deque and initialize with root",
        "Initialize empty result list",
        "While queue is not empty:",
        "  - Get current level size: len(queue)",
        "  - Create empty list for current level values",
        "  - For each node in current level:",
        "    - Dequeue node and add value to current_level",
        "    - Enqueue left child if exists",
        "    - Enqueue right child if exists",
        "  - Append current_level to result",
        "Return result",
        "Key: Classic BFS, space depends on tree width"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 199,
    title: "Binary Tree Right Side View",
    difficulty: Difficulty.medium,
    category: "Trees",
    question: """Given the root of a binary tree, imagine yourself standing on the right side of it, return the values of the nodes you can see ordered from top to bottom.

Example 1:
Input: root = [1,2,3,null,5,null,4]
Output: [1,3,4]

Example 2:
Input: root = [1,null,3]
Output: [1,3]

Example 3:
Input: root = []
Output: []

Constraints:
• The number of nodes in the tree is in the range [0, 100].
• -100 <= Node.val <= 100""",
    bruteForce: Solution(
      code: """def rightSideView(root):
    if not root:
        return []

    from collections import deque
    result = []
    queue = deque([root])

    while queue:
        level_size = len(queue)

        for i in range(level_size):
            node = queue.popleft()

            # Last node in this level
            if i == level_size - 1:
                result.append(node.val)

            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)

    return result""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(w) - w is max width",
      explanation: "Use level-order traversal (BFS). For each level, add the last node's value to result (rightmost visible node).",
      steps: [
        "Handle edge case: if root is None, return []",
        "Initialize queue with root and empty result",
        "While queue is not empty:",
        "  - Get level size",
        "  - Process all nodes in current level",
        "  - For the last node in level (i == level_size - 1):",
        "    - Add its value to result",
        "  - Enqueue children of all nodes",
        "Return result",
        "Key: Rightmost node at each level"
      ],
    ),
    optimized: Solution(
      code: """def rightSideView(root):
    result = []

    def dfs(node, level):
        if not node:
            return

        # First time visiting this level
        if level == len(result):
            result.append(node.val)

        # Visit right first to get rightmost node
        dfs(node.right, level + 1)
        dfs(node.left, level + 1)

    dfs(root, 0)
    return result""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(h) - recursion depth",
      explanation: "Use DFS, visiting right subtree before left. For each level, the first node we visit is the rightmost visible node. Add to result only when visiting a level for the first time.",
      steps: [
        "Initialize empty result list",
        "Define recursive dfs function with node and level",
        "Base case: if node is None, return",
        "Check if this is first visit to this level:",
        "  - If level == len(result), add node.val to result",
        "Visit right subtree first with level + 1",
        "Visit left subtree with level + 1",
        "Start DFS from root at level 0",
        "Return result",
        "Key: Right-first DFS, O(h) space for recursion"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 1448,
    title: "Count Good Nodes in Binary Tree",
    difficulty: Difficulty.medium,
    category: "Trees",
    question: """Given a binary tree root, a node X in the tree is named good if in the path from root to X there are no nodes with a value greater than X.

Return the number of good nodes in the binary tree.

Example 1:
Input: root = [3,1,4,3,null,1,5]
Output: 4
Explanation: Nodes in blue are good.
Root Node (3) is always a good node.
Node 4 -> (3,4) is the maximum value in the path starting from the root.
Node 5 -> (3,4,5) is the maximum value in the path
Node 3 -> (3,1,3) is the maximum value in the path.

Example 2:
Input: root = [3,3,null,4,2]
Output: 3
Explanation: Node 2 -> (3, 3, 2) is not good, because "3" is higher than it.

Example 3:
Input: root = [1]
Output: 1
Explanation: Root is considered as good.

Constraints:
• The number of nodes in the binary tree is in the range [1, 10⁵].
• Each node's value is between [-10⁴, 10⁴].""",
    bruteForce: Solution(
      code: """def goodNodes(root):
    def findPath(node, target, path):
        if not node:
            return False
        path.append(node.val)
        if node == target:
            return True
        if findPath(node.left, target, path) or findPath(node.right, target, path):
            return True
        path.pop()
        return False

    def getAllNodes(node, nodes):
        if not node:
            return
        nodes.append(node)
        getAllNodes(node.left, nodes)
        getAllNodes(node.right, nodes)

    all_nodes = []
    getAllNodes(root, all_nodes)

    count = 0
    for node in all_nodes:
        path = []
        findPath(root, node, path)
        if node.val >= max(path):
            count += 1

    return count""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(n)",
      explanation: "For each node, find the path from root to that node, then check if the node's value is >= all values in path. Inefficient due to repeated path finding.",
      steps: [
        "Collect all nodes in the tree into a list",
        "For each node:",
        "  - Find path from root to this node",
        "  - Check if node.val >= max(path)",
        "  - If yes, increment count",
        "Return count",
        "Note: Finding path for each node makes this O(n²)"
      ],
    ),
    optimized: Solution(
      code: """def goodNodes(root):
    def dfs(node, max_so_far):
        if not node:
            return 0

        count = 0
        if node.val >= max_so_far:
            count = 1

        new_max = max(max_so_far, node.val)
        count += dfs(node.left, new_max)
        count += dfs(node.right, new_max)

        return count

    return dfs(root, float('-inf'))""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(h)",
      explanation: "Use DFS passing down the maximum value seen so far in the path. A node is good if its value >= max_so_far. Update max for recursive calls to children.",
      steps: [
        "Define recursive dfs function with node and max_so_far parameters",
        "Base case: if node is None, return 0",
        "Initialize count to 0",
        "Check if current node is good: node.val >= max_so_far",
        "  - If yes, set count = 1",
        "Update max for children: new_max = max(max_so_far, node.val)",
        "Recursively count good nodes in left subtree with new_max",
        "Recursively count good nodes in right subtree with new_max",
        "Return total count",
        "Start DFS with max_so_far = -infinity",
        "Key: Single DFS pass with max tracking, O(n) time"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 98,
    title: "Validate Binary Search Tree",
    difficulty: Difficulty.medium,
    category: "Trees",
    question: """Given the root of a binary tree, determine if it is a valid binary search tree (BST).

A valid BST is defined as follows:
• The left subtree of a node contains only nodes with keys less than the node's key.
• The right subtree of a node contains only nodes with keys greater than the node's key.
• Both the left and right subtrees must also be binary search trees.

Example 1:
Input: root = [2,1,3]
Output: true

Example 2:
Input: root = [5,1,4,null,null,3,6]
Output: false
Explanation: The root node's value is 5 but its right child's value is 4.

Constraints:
• The number of nodes in the tree is in the range [1, 10⁴].
• -2³¹ <= Node.val <= 2³¹ - 1""",
    bruteForce: Solution(
      code: """def isValidBST(root):
    def getValues(node):
        if not node:
            return []
        return getValues(node.left) + [node.val] + getValues(node.right)

    def isBST(node):
        if not node:
            return True

        left_vals = getValues(node.left)
        right_vals = getValues(node.right)

        # Check all left values < node.val
        for val in left_vals:
            if val >= node.val:
                return False

        # Check all right values > node.val
        for val in right_vals:
            if val <= node.val:
                return False

        return isBST(node.left) and isBST(node.right)

    return isBST(root)""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(n)",
      explanation: "For each node, collect all values in left and right subtrees and verify they satisfy BST property. Recalculates values multiple times, leading to O(n²).",
      steps: [
        "Define getValues to collect all values in a subtree",
        "Define isBST to check if tree rooted at node is valid BST",
        "For each node:",
        "  - Get all values in left subtree",
        "  - Get all values in right subtree",
        "  - Verify all left values < node.val",
        "  - Verify all right values > node.val",
        "  - Recursively check left and right subtrees",
        "Return isBST(root)",
        "Note: Repeatedly collects values, O(n²) time"
      ],
    ),
    optimized: Solution(
      code: """def isValidBST(root):
    def validate(node, min_val, max_val):
        if not node:
            return True

        # Check if current node violates BST property
        if node.val <= min_val or node.val >= max_val:
            return False

        # Validate left and right subtrees with updated bounds
        return (validate(node.left, min_val, node.val) and
                validate(node.right, node.val, max_val))

    return validate(root, float('-inf'), float('inf'))""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(h)",
      explanation: "Use DFS with valid range for each node. For left child, max becomes parent's value. For right child, min becomes parent's value. Each node must be within its valid range.",
      steps: [
        "Define validate function with node, min_val, and max_val",
        "Base case: if node is None, return True",
        "Check if node.val violates range:",
        "  - If node.val <= min_val or node.val >= max_val, return False",
        "Validate left subtree:",
        "  - Keep min_val same, update max_val to node.val",
        "Validate right subtree:",
        "  - Update min_val to node.val, keep max_val same",
        "Return True only if both subtrees are valid",
        "Start with range (-infinity, +infinity)",
        "Key: Range-based validation, O(n) time, O(h) space"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 230,
    title: "Kth Smallest Element in a BST",
    difficulty: Difficulty.medium,
    category: "Trees",
    question: """Given the root of a binary search tree, and an integer k, return the kth smallest value (1-indexed) of all the values of the nodes in the tree.

Example 1:
Input: root = [3,1,4,null,2], k = 1
Output: 1

Example 2:
Input: root = [5,3,6,2,4,null,null,1], k = 3
Output: 3

Constraints:
• The number of nodes in the tree is n.
• 1 <= k <= n <= 10⁴
• 0 <= Node.val <= 10⁴

Follow up: If the BST is modified often (i.e., we can do insert and delete operations) and you need to find the kth smallest frequently, how would you optimize?""",
    bruteForce: Solution(
      code: """def kthSmallest(root, k):
    def inorder(node):
        if not node:
            return []
        return inorder(node.left) + [node.val] + inorder(node.right)

    values = inorder(root)
    return values[k - 1]""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Perform inorder traversal to get all values in sorted order, then return the kth element. Collects all values even if k is small.",
      steps: [
        "Define inorder function to collect values in sorted order",
        "  - Base case: if node is None, return []",
        "  - Return: left values + [node.val] + right values",
        "Call inorder(root) to get all values sorted",
        "Return element at index k-1 (0-indexed)",
        "Note: Processes entire tree even for small k"
      ],
    ),
    optimized: Solution(
      code: """def kthSmallest(root, k):
    count = 0
    result = None

    def inorder(node):
        nonlocal count, result

        if not node or result is not None:
            return

        # Traverse left
        inorder(node.left)

        # Process current node
        count += 1
        if count == k:
            result = node.val
            return

        # Traverse right
        inorder(node.right)

    inorder(root)
    return result""",
      timeComplexity: "O(h + k) - h is height",
      spaceComplexity: "O(h)",
      explanation: "Perform inorder traversal with early termination. Count nodes as we visit them in sorted order. Stop once we reach the kth node. More efficient than collecting all values.",
      steps: [
        "Initialize count = 0 and result = None",
        "Define inorder function that updates count and result",
        "Base case: if node is None or result found, return",
        "Traverse left subtree first (smaller values)",
        "Process current node:",
        "  - Increment count",
        "  - If count == k, set result = node.val and return",
        "Traverse right subtree (larger values)",
        "Start inorder traversal from root",
        "Return result",
        "Key: Early termination after k nodes, O(h+k) time"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 105,
    title: "Construct Binary Tree from Preorder and Inorder Traversal",
    difficulty: Difficulty.medium,
    category: "Trees",
    question: """Given two integer arrays preorder and inorder where preorder is the preorder traversal of a binary tree and inorder is the inorder traversal of the same tree, construct and return the binary tree.

Example 1:
Input: preorder = [3,9,20,15,7], inorder = [9,3,15,20,7]
Output: [3,9,20,null,null,15,7]

Example 2:
Input: preorder = [-1], inorder = [-1]
Output: [-1]

Constraints:
• 1 <= preorder.length <= 3000
• inorder.length == preorder.length
• -3000 <= preorder[i], inorder[i] <= 3000
• preorder and inorder consist of unique values.
• Each value of inorder also appears in preorder.
• preorder is guaranteed to be the preorder traversal of the tree.
• inorder is guaranteed to be the inorder traversal of the tree.""",
    bruteForce: Solution(
      code: """def buildTree(preorder, inorder):
    if not preorder or not inorder:
        return None

    # First element of preorder is root
    root_val = preorder[0]
    root = TreeNode(root_val)

    # Find root in inorder (linear search)
    root_index = inorder.index(root_val)

    # Split arrays
    left_inorder = inorder[:root_index]
    right_inorder = inorder[root_index + 1:]

    left_size = len(left_inorder)
    left_preorder = preorder[1:1 + left_size]
    right_preorder = preorder[1 + left_size:]

    # Recursively build subtrees
    root.left = buildTree(left_preorder, left_inorder)
    root.right = buildTree(right_preorder, right_inorder)

    return root""",
      timeComplexity: "O(n²) - linear search for each node",
      spaceComplexity: "O(n)",
      explanation: "Use first element of preorder as root. Find root in inorder using linear search to split into left and right subtrees. Recursively build subtrees. Linear search makes it O(n²).",
      steps: [
        "Base case: if preorder or inorder empty, return None",
        "First element of preorder is root value",
        "Create root node with this value",
        "Find root's index in inorder using index() - O(n) linear search",
        "Split inorder into left and right subtrees based on root index",
        "Calculate left subtree size",
        "Split preorder into left and right based on left size",
        "Recursively build left subtree",
        "Recursively build right subtree",
        "Return root",
        "Note: Linear search in each recursive call gives O(n²)"
      ],
    ),
    optimized: Solution(
      code: """def buildTree(preorder, inorder):
    # Create hashmap for O(1) lookups
    inorder_map = {val: i for i, val in enumerate(inorder)}
    preorder_index = 0

    def build(left, right):
        nonlocal preorder_index

        if left > right:
            return None

        # Get root value and create node
        root_val = preorder[preorder_index]
        root = TreeNode(root_val)
        preorder_index += 1

        # Find root index in inorder (O(1) with hashmap)
        root_index = inorder_map[root_val]

        # Build left and right subtrees
        root.left = build(left, root_index - 1)
        root.right = build(root_index + 1, right)

        return root

    return build(0, len(inorder) - 1)""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Use hashmap for O(1) lookup of root position in inorder. Use global preorder index that increments as we process nodes. Recursively build using index ranges instead of array slicing.",
      steps: [
        "Create hashmap: inorder value -> index for O(1) lookups",
        "Initialize preorder_index to 0 (track current root in preorder)",
        "Define recursive build function with left and right bounds",
        "Base case: if left > right, return None",
        "Get current root from preorder[preorder_index]",
        "Create root node and increment preorder_index",
        "Find root's index in inorder using hashmap - O(1)",
        "Recursively build left subtree: build(left, root_index - 1)",
        "Recursively build right subtree: build(root_index + 1, right)",
        "Return root",
        "Start with build(0, len(inorder) - 1)",
        "Key: Hashmap optimization makes it O(n)"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 124,
    title: "Binary Tree Maximum Path Sum",
    difficulty: Difficulty.hard,
    category: "Trees",
    question: """A path in a binary tree is a sequence of nodes where each pair of adjacent nodes in the sequence has an edge connecting them. A node can only appear in the sequence at most once. Note that the path does not need to pass through the root.

The path sum of a path is the sum of the node's values in the path.

Given the root of a binary tree, return the maximum path sum of any non-empty path.

Example 1:
Input: root = [1,2,3]
Output: 6
Explanation: The optimal path is 2 -> 1 -> 3 with a path sum of 2 + 1 + 3 = 6.

Example 2:
Input: root = [-10,9,20,null,null,15,7]
Output: 42
Explanation: The optimal path is 15 -> 20 -> 7 with a path sum of 15 + 20 + 7 = 42.

Constraints:
• The number of nodes in the tree is in the range [1, 3 * 10⁴].
• -1000 <= Node.val <= 1000""",
    bruteForce: Solution(
      code: """def maxPathSum(root):
    def allPaths(node):
        if not node:
            return []

        paths = [[node.val]]

        left_paths = allPaths(node.left)
        right_paths = allPaths(node.right)

        # Paths extending through current node
        for lp in left_paths:
            paths.append(lp + [node.val])
            for rp in right_paths:
                paths.append(lp + [node.val] + rp)

        for rp in right_paths:
            paths.append([node.val] + rp)

        return paths

    all_paths = allPaths(root)
    return max(sum(path) for path in all_paths)""",
      timeComplexity: "O(n²) or worse",
      spaceComplexity: "O(n²) or worse",
      explanation: "Generate all possible paths in the tree, calculate sum of each path, and return maximum. Extremely inefficient due to exponential number of paths.",
      steps: [
        "Define allPaths function to generate all paths through a node",
        "For each node:",
        "  - Generate paths from left subtree",
        "  - Generate paths from right subtree",
        "  - Combine: left + current, current + right, left + current + right",
        "Collect all paths in the entire tree",
        "Calculate sum of each path",
        "Return maximum sum",
        "Note: Exponential number of paths, very inefficient"
      ],
    ),
    optimized: Solution(
      code: """def maxPathSum(root):
    max_sum = float('-inf')

    def maxGain(node):
        nonlocal max_sum

        if not node:
            return 0

        # Max gain from left and right subtrees (ignore negative)
        left_gain = max(maxGain(node.left), 0)
        right_gain = max(maxGain(node.right), 0)

        # Path through current node
        path_sum = node.val + left_gain + right_gain

        # Update global max
        max_sum = max(max_sum, path_sum)

        # Return max gain if continuing path through parent
        return node.val + max(left_gain, right_gain)

    maxGain(root)
    return max_sum""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(h)",
      explanation: "Use DFS to calculate maximum path sum. At each node, consider path through it (left + node + right) for global max, but return only one branch (node + max(left, right)) for parent's calculation. Ignore negative contributions.",
      steps: [
        "Initialize max_sum to -infinity",
        "Define maxGain function that returns max path sum ending at node",
        "Base case: if node is None, return 0",
        "Recursively get max gain from left subtree",
        "Recursively get max gain from right subtree",
        "Ignore negative gains: max(gain, 0)",
        "Calculate path sum through current node: node.val + left + right",
        "Update global max_sum with this path sum",
        "For parent's calculation, return node.val + max(left, right)",
        "  (Can only extend one branch to parent)",
        "Call maxGain(root) and return max_sum",
        "Key: Single DFS pass, O(n) time, O(h) space"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 297,
    title: "Serialize and Deserialize Binary Tree",
    difficulty: Difficulty.hard,
    category: "Trees",
    question: """Serialization is the process of converting a data structure or object into a sequence of bits so that it can be stored in a file or memory buffer, or transmitted across a network connection link to be reconstructed later in the same or another computer environment.

Design an algorithm to serialize and deserialize a binary tree. There is no restriction on how your serialization/deserialization algorithm should work. You just need to ensure that a binary tree can be serialized to a string and this string can be deserialized to the original tree structure.

Clarification: The input/output format is the same as how LeetCode serializes a binary tree. You do not necessarily need to follow this format, so please be creative and come up with different approaches yourself.

Example 1:
Input: root = [1,2,3,null,null,4,5]
Output: [1,2,3,null,null,4,5]

Example 2:
Input: root = []
Output: []

Constraints:
• The number of nodes in the tree is in the range [0, 10⁴].
• -1000 <= Node.val <= 1000""",
    bruteForce: Solution(
      code: """class Codec:
    def serialize(self, root):
        \"\"\"Level-order traversal serialization\"\"\"
        if not root:
            return ""

        from collections import deque
        result = []
        queue = deque([root])

        while queue:
            node = queue.popleft()
            if node:
                result.append(str(node.val))
                queue.append(node.left)
                queue.append(node.right)
            else:
                result.append("null")

        # Remove trailing nulls
        while result and result[-1] == "null":
            result.pop()

        return ",".join(result)

    def deserialize(self, data):
        \"\"\"Level-order reconstruction\"\"\"
        if not data:
            return None

        from collections import deque
        values = data.split(",")
        root = TreeNode(int(values[0]))
        queue = deque([root])
        i = 1

        while queue and i < len(values):
            node = queue.popleft()

            if i < len(values) and values[i] != "null":
                node.left = TreeNode(int(values[i]))
                queue.append(node.left)
            i += 1

            if i < len(values) and values[i] != "null":
                node.right = TreeNode(int(values[i]))
                queue.append(node.right)
            i += 1

        return root""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Use level-order traversal (BFS) for both serialization and deserialization. Serialize stores values level by level with 'null' markers. Deserialize rebuilds using queue.",
      steps: [
        "Serialize:",
        "  - Use BFS with queue",
        "  - For each node, append value to result",
        "  - For null nodes, append 'null'",
        "  - Remove trailing nulls",
        "  - Join with commas",
        "Deserialize:",
        "  - Split string by commas",
        "  - Create root from first value",
        "  - Use queue for level-order reconstruction",
        "  - For each node, set left and right children from values",
        "  - Skip 'null' values",
        "Return root"
      ],
    ),
    optimized: Solution(
      code: """class Codec:
    def serialize(self, root):
        \"\"\"Preorder DFS serialization\"\"\"
        result = []

        def dfs(node):
            if not node:
                result.append("N")
                return
            result.append(str(node.val))
            dfs(node.left)
            dfs(node.right)

        dfs(root)
        return ",".join(result)

    def deserialize(self, data):
        \"\"\"Preorder DFS deserialization\"\"\"
        values = data.split(",")
        self.index = 0

        def dfs():
            if values[self.index] == "N":
                self.index += 1
                return None

            node = TreeNode(int(values[self.index]))
            self.index += 1
            node.left = dfs()
            node.right = dfs()
            return node

        return dfs()""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(h) - recursion depth",
      explanation: "Use preorder DFS for both operations. Serialize using recursive DFS with 'N' for null nodes. Deserialize by rebuilding in preorder: create node, build left, build right. More elegant than BFS.",
      steps: [
        "Serialize:",
        "  - Recursive DFS preorder traversal",
        "  - Append 'N' for null nodes",
        "  - Append node value for non-null",
        "  - Recursively serialize left and right",
        "  - Join with commas",
        "Deserialize:",
        "  - Split string by commas",
        "  - Use index to track current position",
        "  - Recursive DFS:",
        "    - If 'N', increment index and return None",
        "    - Create node with current value",
        "    - Recursively build left subtree",
        "    - Recursively build right subtree",
        "  - Return node",
        "Key: Preorder traversal simplifies logic, O(h) space"
      ],
    ),
  ),

];
