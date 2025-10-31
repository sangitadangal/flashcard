import '../leetcode_question.dart';

// NeetCode 150 - Math & Geometry Category
// 8 questions with complete solutions

final List<LeetCodeQuestion> mathGeometryQuestions = [

  LeetCodeQuestion(
    id: 48,
    title: "Rotate Image",
    difficulty: Difficulty.medium,
    category: "Math & Geometry",
    question: """You are given an n x n 2D matrix representing an image, rotate the image by 90 degrees (clockwise).

You have to rotate the image in-place, which means you have to modify the input 2D matrix directly. DO NOT allocate another 2D matrix and do the rotation.

Example 1:
Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
Output: [[7,4,1],[8,5,2],[9,6,3]]

Example 2:
Input: matrix = [[5,1,9,11],[2,4,8,10],[13,3,6,7],[15,14,12,16]]
Output: [[15,13,2,5],[14,3,4,1],[12,6,8,9],[16,7,10,11]]

Constraints:
• n == matrix.length == matrix[i].length
• 1 <= n <= 20
• -1000 <= matrix[i][j] <= 1000""",
    bruteForce: Solution(
      code: """def rotate(matrix):
    n = len(matrix)
    # Create copy
    copy = [[matrix[i][j] for j in range(n)] for i in range(n)]

    # Rotate: new[i][j] = old[n-1-j][i]
    for i in range(n):
        for j in range(n):
            matrix[i][j] = copy[n - 1 - j][i]""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(n²)",
      explanation: "Create a copy of matrix, then fill original using rotation formula. Uses extra space.",
      steps: [
        "Create a copy of the matrix",
        "For each position (i, j):",
        "  - Calculate source position: (n-1-j, i)",
        "  - Copy value from copy[n-1-j][i] to matrix[i][j]",
        "Note: Uses O(n²) extra space for copy"
      ],
    ),
    optimized: Solution(
      code: """def rotate(matrix):
    n = len(matrix)

    # Step 1: Transpose (flip along diagonal)
    for i in range(n):
        for j in range(i, n):
            matrix[i][j], matrix[j][i] = matrix[j][i], matrix[i][j]

    # Step 2: Reverse each row
    for i in range(n):
        matrix[i].reverse()""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(1)",
      explanation: "Two-step in-place rotation: (1) transpose matrix (swap along diagonal), (2) reverse each row. Achieves 90° clockwise rotation.",
      steps: [
        "Step 1: Transpose the matrix",
        "  - For each cell (i,j) where j >= i:",
        "    - Swap matrix[i][j] with matrix[j][i]",
        "Step 2: Reverse each row",
        "  - For each row, reverse it in-place",
        "Result: 90° clockwise rotation",
        "Key: Transpose + reverse = rotation, O(1) space",
        "Mathematical insight: row i becomes column n-1-i"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 54,
    title: "Spiral Matrix",
    difficulty: Difficulty.medium,
    category: "Math & Geometry",
    question: """Given an m x n matrix, return all elements of the matrix in spiral order.

Example 1:
Input: matrix = [[1,2,3],[4,5,6],[7,8,9]]
Output: [1,2,3,6,9,8,7,4,5]

Example 2:
Input: matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
Output: [1,2,3,4,8,12,11,10,9,5,6,7]

Constraints:
• m == matrix.length
• n == matrix[i].length
• 1 <= m, n <= 10
• -100 <= matrix[i][j] <= 100""",
    bruteForce: Solution(
      code: """def spiralOrder(matrix):
    if not matrix:
        return []

    m, n = len(matrix), len(matrix[0])
    visited = [[False] * n for _ in range(m)]
    result = []

    # Directions: right, down, left, up
    directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
    dir_idx = 0
    r, c = 0, 0

    for _ in range(m * n):
        result.append(matrix[r][c])
        visited[r][c] = True

        # Try to continue in current direction
        dr, dc = directions[dir_idx]
        nr, nc = r + dr, c + dc

        # Change direction if needed
        if (nr < 0 or nr >= m or nc < 0 or nc >= n or visited[nr][nc]):
            dir_idx = (dir_idx + 1) % 4
            dr, dc = directions[dir_idx]
            nr, nc = r + dr, c + dc

        r, c = nr, nc

    return result""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(m * n)",
      explanation: "Simulate spiral traversal with direction tracking and visited matrix. Uses extra space for visited tracking.",
      steps: [
        "Create visited matrix",
        "Define 4 directions: right, down, left, up",
        "Start at (0,0), direction = right",
        "For each of m×n cells:",
        "  - Add current cell to result",
        "  - Mark as visited",
        "  - Try to move in current direction",
        "  - If blocked or visited, rotate direction clockwise",
        "Return result",
        "Note: O(m×n) extra space for visited"
      ],
    ),
    optimized: Solution(
      code: """def spiralOrder(matrix):
    if not matrix:
        return []

    m, n = len(matrix), len(matrix[0])
    result = []

    top, bottom = 0, m - 1
    left, right = 0, n - 1

    while top <= bottom and left <= right:
        # Traverse right
        for col in range(left, right + 1):
            result.append(matrix[top][col])
        top += 1

        # Traverse down
        for row in range(top, bottom + 1):
            result.append(matrix[row][right])
        right -= 1

        # Traverse left (if still valid)
        if top <= bottom:
            for col in range(right, left - 1, -1):
                result.append(matrix[bottom][col])
            bottom -= 1

        # Traverse up (if still valid)
        if left <= right:
            for row in range(bottom, top - 1, -1):
                result.append(matrix[row][left])
            left += 1

    return result""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(1)",
      explanation: "Layer-by-layer approach. Maintain four boundaries (top, bottom, left, right). Process outer layer, then shrink boundaries and repeat.",
      steps: [
        "Initialize four boundaries: top, bottom, left, right",
        "While boundaries valid:",
        "  - Traverse top row from left to right",
        "  - Move top boundary down",
        "  - Traverse right column from top to bottom",
        "  - Move right boundary left",
        "  - If rows remaining, traverse bottom row right to left",
        "  - Move bottom boundary up",
        "  - If columns remaining, traverse left column bottom to top",
        "  - Move left boundary right",
        "Return result",
        "Key: Layer-by-layer with boundary tracking, O(1) space"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 73,
    title: "Set Matrix Zeroes",
    difficulty: Difficulty.medium,
    category: "Math & Geometry",
    question: """Given an m x n integer matrix matrix, if an element is 0, set its entire row and column to 0's.

You must do it in place.

Example 1:
Input: matrix = [[1,1,1],[1,0,1],[1,1,1]]
Output: [[1,0,1],[0,0,0],[1,0,1]]

Example 2:
Input: matrix = [[0,1,2,0],[3,4,5,2],[1,3,1,5]]
Output: [[0,0,0,0],[0,4,5,0],[0,3,1,0]]

Constraints:
• m == matrix.length
• n == matrix[0].length
• 1 <= m, n <= 200
• -2³¹ <= matrix[i][j] <= 2³¹ - 1

Follow up:
• A straightforward solution using O(mn) space is probably a bad idea.
• A simple improvement uses O(m + n) space, but still not the best solution.
• Could you devise a constant space solution?""",
    bruteForce: Solution(
      code: """def setZeroes(matrix):
    m, n = len(matrix), len(matrix[0])

    # Track rows and columns to zero
    zero_rows = set()
    zero_cols = set()

    # Find all zeros
    for i in range(m):
        for j in range(n):
            if matrix[i][j] == 0:
                zero_rows.add(i)
                zero_cols.add(j)

    # Set rows to zero
    for row in zero_rows:
        for j in range(n):
            matrix[row][j] = 0

    # Set columns to zero
    for col in zero_cols:
        for i in range(m):
            matrix[i][col] = 0""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(m + n)",
      explanation: "Use sets to track which rows and columns should be zeroed. Then make two passes to zero them out.",
      steps: [
        "Create sets for zero_rows and zero_cols",
        "First pass: find all zeros",
        "  - If matrix[i][j] == 0:",
        "    - Add i to zero_rows",
        "    - Add j to zero_cols",
        "Second pass: zero out rows in zero_rows",
        "Third pass: zero out columns in zero_cols",
        "Note: O(m + n) extra space"
      ],
    ),
    optimized: Solution(
      code: """def setZeroes(matrix):
    m, n = len(matrix), len(matrix[0])
    first_row_zero = False
    first_col_zero = False

    # Check if first row has zero
    for j in range(n):
        if matrix[0][j] == 0:
            first_row_zero = True

    # Check if first column has zero
    for i in range(m):
        if matrix[i][0] == 0:
            first_col_zero = True

    # Use first row and column as markers
    for i in range(1, m):
        for j in range(1, n):
            if matrix[i][j] == 0:
                matrix[i][0] = 0
                matrix[0][j] = 0

    # Zero out cells based on markers
    for i in range(1, m):
        for j in range(1, n):
            if matrix[i][0] == 0 or matrix[0][j] == 0:
                matrix[i][j] = 0

    # Handle first row
    if first_row_zero:
        for j in range(n):
            matrix[0][j] = 0

    # Handle first column
    if first_col_zero:
        for i in range(m):
            matrix[i][0] = 0""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(1)",
      explanation: "Use first row and column as markers for which rows/columns to zero. Handle first row/column separately since they're used for storage.",
      steps: [
        "Check if first row should be zeroed (has any zero)",
        "Check if first column should be zeroed (has any zero)",
        "Use first row and column to mark zeros:",
        "  - For each cell (i,j) where i,j >= 1:",
        "    - If cell is 0, mark matrix[i][0] = 0 and matrix[0][j] = 0",
        "Zero out cells based on markers:",
        "  - If matrix[i][0] or matrix[0][j] is 0, set matrix[i][j] = 0",
        "Handle first row if needed",
        "Handle first column if needed",
        "Key: Use matrix itself for storage, O(1) extra space"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 202,
    title: "Happy Number",
    difficulty: Difficulty.easy,
    category: "Math & Geometry",
    question: """Write an algorithm to determine if a number n is happy.

A happy number is a number defined by the following process:

• Starting with any positive integer, replace the number by the sum of the squares of its digits.
• Repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1.
• Those numbers for which this process ends in 1 are happy.

Return true if n is a happy number, and false if not.

Example 1:
Input: n = 19
Output: true
Explanation:
1² + 9² = 82
8² + 2² = 68
6² + 8² = 100
1² + 0² + 0² = 1

Example 2:
Input: n = 2
Output: false

Constraints:
• 1 <= n <= 2³¹ - 1""",
    bruteForce: Solution(
      code: """def isHappy(n):
    seen = set()

    while n != 1:
        if n in seen:
            return False  # Cycle detected

        seen.add(n)

        # Calculate sum of squares of digits
        total = 0
        while n > 0:
            digit = n % 10
            total += digit * digit
            n //= 10

        n = total

    return True""",
      timeComplexity: "O(log n)",
      spaceComplexity: "O(log n)",
      explanation: "Track all seen numbers in a set. If we see a number twice, we're in a cycle. Keep computing sum of digit squares until we reach 1 or find cycle.",
      steps: [
        "Create set to track seen numbers",
        "While n != 1:",
        "  - If n in seen, return False (cycle)",
        "  - Add n to seen",
        "  - Calculate sum of squares of digits",
        "  - Update n to this sum",
        "If loop exits, n == 1, return True",
        "Note: O(log n) iterations, O(log n) space for seen"
      ],
    ),
    optimized: Solution(
      code: """def isHappy(n):
    def getSumOfSquares(num):
        total = 0
        while num > 0:
            digit = num % 10
            total += digit * digit
            num //= 10
        return total

    # Floyd's cycle detection (slow and fast pointers)
    slow = n
    fast = getSumOfSquares(n)

    while fast != 1 and slow != fast:
        slow = getSumOfSquares(slow)
        fast = getSumOfSquares(getSumOfSquares(fast))

    return fast == 1""",
      timeComplexity: "O(log n)",
      spaceComplexity: "O(1)",
      explanation: "Floyd's cycle detection (tortoise and hare). Slow pointer moves one step, fast moves two steps. If there's a cycle, they'll meet. If fast reaches 1, it's happy.",
      steps: [
        "Helper function to get sum of squares of digits",
        "Initialize slow and fast pointers",
        "While fast != 1 and slow != fast:",
        "  - Move slow one step",
        "  - Move fast two steps",
        "If fast == 1, happy number",
        "If slow == fast, cycle detected, not happy",
        "Key: Floyd's algorithm, O(1) space instead of set",
        "Same time complexity, better space"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 66,
    title: "Plus One",
    difficulty: Difficulty.easy,
    category: "Math & Geometry",
    question: """You are given a large integer represented as an integer array digits, where each digits[i] is the ith digit of the integer. The digits are ordered from most significant to least significant in left-to-right order. The large integer does not contain any leading 0's.

Increment the large integer by one and return the resulting array of digits.

Example 1:
Input: digits = [1,2,3]
Output: [1,2,4]
Explanation: The array represents the integer 123. Incrementing by one gives 123 + 1 = 124. Thus, the result should be [1,2,4].

Example 2:
Input: digits = [4,3,2,1]
Output: [4,3,2,2]
Explanation: The array represents the integer 4321. Incrementing by one gives 4321 + 1 = 4322. Thus, the result should be [4,3,2,2].

Example 3:
Input: digits = [9]
Output: [1,0]
Explanation: The array represents the integer 9. Incrementing by one gives 9 + 1 = 10. Thus, the result should be [1,0].

Constraints:
• 1 <= digits.length <= 100
• 0 <= digits[i] <= 9
• digits does not contain any leading 0's.""",
    bruteForce: Solution(
      code: """def plusOne(digits):
    # Convert to number, add one, convert back
    num = 0
    for digit in digits:
        num = num * 10 + digit

    num += 1

    # Convert back to array
    result = []
    if num == 0:
        return [0]

    while num > 0:
        result.append(num % 10)
        num //= 10

    return result[::-1]""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Convert digits array to integer, add one, convert back to array. Simple but can overflow for very large numbers.",
      steps: [
        "Convert digits to integer",
        "Add 1 to the integer",
        "Convert back to digits array",
        "Reverse (since we build from least significant)",
        "Note: Works but can overflow for large numbers",
        "Not suitable for arbitrary precision"
      ],
    ),
    optimized: Solution(
      code: """def plusOne(digits):
    n = len(digits)

    # Traverse from right to left
    for i in range(n - 1, -1, -1):
        if digits[i] < 9:
            digits[i] += 1
            return digits

        digits[i] = 0

    # All digits were 9, need new leading 1
    return [1] + digits""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Simulate addition with carry. Start from rightmost digit. If digit < 9, increment and done. If digit = 9, set to 0 and carry to next. If all 9s, prepend 1.",
      steps: [
        "Traverse from right to left (least to most significant)",
        "For each digit:",
        "  - If digit < 9:",
        "    - Increment it and return (no carry needed)",
        "  - If digit == 9:",
        "    - Set to 0 (carry continues)",
        "If loop completes, all digits were 9",
        "  - Return [1] + digits (e.g., [9,9,9] -> [1,0,0,0])",
        "Key: Early return optimization, O(1) extra space",
        "Handles arbitrary precision correctly"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 50,
    title: "Pow(x, n)",
    difficulty: Difficulty.medium,
    category: "Math & Geometry",
    question: """Implement pow(x, n), which calculates x raised to the power n (i.e., x^n).

Example 1:
Input: x = 2.00000, n = 10
Output: 1024.00000

Example 2:
Input: x = 2.10000, n = 3
Output: 9.26100

Example 3:
Input: x = 2.00000, n = -2
Output: 0.25000
Explanation: 2^(-2) = 1/(2^2) = 1/4 = 0.25

Constraints:
• -100.0 < x < 100.0
• -2³¹ <= n <= 2³¹-1
• n is an integer.
• Either x is not zero or n > 0.
• -10⁴ <= x^n <= 10⁴""",
    bruteForce: Solution(
      code: """def myPow(x, n):
    if n == 0:
        return 1

    if n < 0:
        x = 1 / x
        n = -n

    result = 1
    for _ in range(n):
        result *= x

    return result""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Multiply x by itself n times. Simple but very slow for large n. Times out for large inputs.",
      steps: [
        "Handle n == 0, return 1",
        "If n negative, convert to positive and use 1/x",
        "Initialize result to 1",
        "Loop n times, multiply result by x",
        "Return result",
        "Note: O(n) multiplications, too slow"
      ],
    ),
    optimized: Solution(
      code: """def myPow(x, n):
    def power(x, n):
        if n == 0:
            return 1

        half = power(x, n // 2)

        if n % 2 == 0:
            return half * half
        else:
            return half * half * x

    if n < 0:
        x = 1 / x
        n = -n

    return power(x, n)""",
      timeComplexity: "O(log n)",
      spaceComplexity: "O(log n)",
      explanation: "Binary exponentiation (exponentiation by squaring). Key insight: x^n = (x^(n/2))^2. Recursively compute half power, then square. If n odd, multiply by x.",
      steps: [
        "Handle negative exponent by converting to 1/x",
        "Recursive function:",
        "  - Base case: n == 0, return 1",
        "  - Compute half = power(x, n//2) recursively",
        "  - If n even: return half * half",
        "  - If n odd: return half * half * x",
        "Key: Divide exponent by 2 each step",
        "Reduces O(n) to O(log n)",
        "Classic divide-and-conquer approach"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 43,
    title: "Multiply Strings",
    difficulty: Difficulty.medium,
    category: "Math & Geometry",
    question: """Given two non-negative integers num1 and num2 represented as strings, return the product of num1 and num2, also represented as a string.

Note: You must not use any built-in BigInteger library or convert the inputs to integer directly.

Example 1:
Input: num1 = "2", num2 = "3"
Output: "6"

Example 2:
Input: num1 = "123", num2 = "456"
Output: "56088"

Constraints:
• 1 <= num1.length, num2.length <= 200
• num1 and num2 consist of digits only.
• Both num1 and num2 do not contain any leading zero, except the number 0 itself.""",
    bruteForce: Solution(
      code: """def multiply(num1, num2):
    if num1 == "0" or num2 == "0":
        return "0"

    # Simulate multiplication digit by digit
    result = "0"

    for i in range(len(num2) - 1, -1, -1):
        digit2 = int(num2[i])
        temp = ""
        carry = 0

        # Multiply num1 by single digit
        for j in range(len(num1) - 1, -1, -1):
            digit1 = int(num1[j])
            prod = digit1 * digit2 + carry
            temp = str(prod % 10) + temp
            carry = prod // 10

        if carry:
            temp = str(carry) + temp

        # Add zeros for position
        temp += "0" * (len(num2) - 1 - i)

        # Add to result
        result = addStrings(result, temp)

    return result

def addStrings(num1, num2):
    result = ""
    carry = 0
    i, j = len(num1) - 1, len(num2) - 1

    while i >= 0 or j >= 0 or carry:
        digit1 = int(num1[i]) if i >= 0 else 0
        digit2 = int(num2[j]) if j >= 0 else 0

        total = digit1 + digit2 + carry
        result = str(total % 10) + result
        carry = total // 10

        i -= 1
        j -= 1

    return result""",
      timeComplexity: "O(n * m)",
      spaceComplexity: "O(n + m)",
      explanation: "Simulate grade-school multiplication. For each digit in num2, multiply entire num1, then add to running sum with proper positioning.",
      steps: [
        "Handle zero case",
        "For each digit in num2 (right to left):",
        "  - Multiply entire num1 by this digit",
        "  - Track carry",
        "  - Append zeros for position (like shifting in decimal)",
        "  - Add result to running total using string addition",
        "Helper function addStrings adds two numbers as strings",
        "Note: Multiple string additions make this somewhat slow"
      ],
    ),
    optimized: Solution(
      code: """def multiply(num1, num2):
    if num1 == "0" or num2 == "0":
        return "0"

    m, n = len(num1), len(num2)
    result = [0] * (m + n)

    # Multiply each digit and accumulate
    for i in range(m - 1, -1, -1):
        for j in range(n - 1, -1, -1):
            digit1 = int(num1[i])
            digit2 = int(num2[j])

            # Position in result array
            pos1 = i + j
            pos2 = i + j + 1

            # Multiply and add to current value
            product = digit1 * digit2 + result[pos2]

            result[pos2] = product % 10
            result[pos1] += product // 10

    # Convert to string, skip leading zeros
    result_str = "".join(map(str, result))
    return result_str.lstrip("0") or "0"""",
      timeComplexity: "O(m * n)",
      spaceComplexity: "O(m + n)",
      explanation: "Direct position-based multiplication. Use array to store result digits. For digits at positions i and j, their product contributes to positions i+j and i+j+1.",
      steps: [
        "Handle zero case",
        "Create result array of size m + n",
        "For each digit i in num1 and digit j in num2:",
        "  - Multiply digit1 * digit2",
        "  - Add to position i+j+1 in result",
        "  - Carry to position i+j",
        "Convert result array to string",
        "Remove leading zeros",
        "Key: Direct position calculation, single pass",
        "More efficient than multiple string additions"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 2013,
    title: "Detect Squares",
    difficulty: Difficulty.medium,
    category: "Math & Geometry",
    question: """You are given a stream of points on the X-Y plane. Design an algorithm that:

• Adds new points from the stream into a data structure. Duplicate points are allowed and should be treated as different points.
• Given a query point, counts the number of ways to choose three points from the data structure such that the three points and the query point form an axis-aligned square with positive area.

An axis-aligned square is a square whose edges are all the same length and are either parallel or perpendicular to the x-axis and y-axis.

Implement the DetectSquares class:

• DetectSquares() Initializes the object with an empty data structure.
• void add(int[] point) Adds a new point point = [x, y] to the data structure.
• int count(int[] point) Counts the number of ways to form axis-aligned squares with point point = [x, y] as described above.

Example 1:
Input
["DetectSquares", "add", "add", "add", "count", "count", "add", "count"]
[[], [[3, 10]], [[11, 2]], [[3, 2]], [[11, 10]], [[14, 8]], [[11, 2]], [[11, 10]]]
Output
[null, null, null, null, 1, 0, null, 2]

Explanation
DetectSquares detectSquares = new DetectSquares();
detectSquares.add([3, 10]);
detectSquares.add([11, 2]);
detectSquares.add([3, 2]);
detectSquares.count([11, 10]); // return 1. You can choose:
                                //   - The first, second, and third points
detectSquares.count([14, 8]);  // return 0. The query point cannot form a square with any points in the data structure.
detectSquares.add([11, 2]);    // Adding duplicate point
detectSquares.count([11, 10]); // return 2. You can choose:
                                //   - The first, second, and third points
                                //   - The first, third, and fourth points

Constraints:
• point.length == 2
• 0 <= x, y <= 1000
• At most 3000 calls in total will be made to add and count.""",
    bruteForce: Solution(
      code: """class DetectSquares:
    def __init__(self):
        self.points = []

    def add(self, point):
        self.points.append(point)

    def count(self, point):
        px, py = point
        count = 0

        # Try all possible diagonal corners
        for x, y in self.points:
            if x == px or y == py:
                continue  # Not a diagonal

            side_length = abs(x - px)
            if side_length != abs(y - py):
                continue  # Not a square

            # Count points at the other two corners
            corner1 = [px, y]
            corner2 = [x, py]

            count1 = self.points.count(corner1)
            count2 = self.points.count(corner2)

            count += count1 * count2

        return count""",
      timeComplexity: "O(n) per count call",
      spaceComplexity: "O(n)",
      explanation: "Store all points in list. For count query, try each point as diagonal corner, verify it forms square, count occurrences of other two corners.",
      steps: [
        "add: append point to list",
        "count:",
        "  - For each stored point (x, y):",
        "    - Check if it could be diagonal corner",
        "    - Verify equal side lengths (forms square)",
        "    - Calculate positions of other 2 corners",
        "    - Count occurrences of each corner in points list",
        "    - Multiply counts and add to result",
        "Note: list.count() is O(n), called O(n) times = O(n²)"
      ],
    ),
    optimized: Solution(
      code: """class DetectSquares:
    def __init__(self):
        from collections import defaultdict
        self.point_count = defaultdict(int)
        self.points_by_x = defaultdict(list)

    def add(self, point):
        x, y = point
        self.point_count[(x, y)] += 1
        self.points_by_x[x].append(y)

    def count(self, point):
        px, py = point
        total = 0

        # For each point with same x coordinate
        for y in self.points_by_x.get(px, []):
            if y == py:
                continue

            side_length = abs(y - py)

            # Check for squares on both sides
            for sign in [1, -1]:
                diagonal_x = px + sign * side_length

                # Count points at the other two corners
                point1 = (diagonal_x, y)
                point2 = (diagonal_x, py)

                total += (self.point_count[point1] *
                         self.point_count[point2])

        return total""",
      timeComplexity: "O(n) per count call",
      spaceComplexity: "O(n)",
      explanation: "Use hashmap to track point counts and organize points by x-coordinate. For count, only check points with same x-coordinate, then verify square conditions.",
      steps: [
        "Data structure: point_count hashmap, points_by_x hashmap",
        "add: increment count, add to x-coordinate list",
        "count:",
        "  - For each point (px, y') with same x as query:",
        "    - Calculate side_length = |y' - py|",
        "    - Check both possible diagonal corners (left and right)",
        "    - For each diagonal x = px ± side_length:",
        "      - Count points at (diagonal_x, y') and (diagonal_x, py)",
        "      - Multiply counts, add to total",
        "Key: HashMap for O(1) count lookup",
        "Organize by x-coordinate to reduce search space"
      ],
    ),
  ),

];
