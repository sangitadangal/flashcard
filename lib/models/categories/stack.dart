import '../leetcode_question.dart';

// NeetCode 150 - Stack Category
// 7 questions with complete solutions

final List<LeetCodeQuestion> stackQuestions = [

  LeetCodeQuestion(
    id: 20,
    title: "Valid Parentheses",
    difficulty: Difficulty.easy,
    category: "Stack",
    question: """Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

An input string is valid if:
1. Open brackets must be closed by the same type of brackets.
2. Open brackets must be closed in the correct order.
3. Every close bracket has a corresponding open bracket of the same type.

Example 1:
Input: s = "()"
Output: true

Example 2:
Input: s = "()[]{}"
Output: true

Example 3:
Input: s = "(]"
Output: false

Example 4:
Input: s = "([])"
Output: true

Constraints:
• 1 <= s.length <= 10⁴
• s consists of parentheses only '()[]{}'.""",
    bruteForce: Solution(
      code: """def isValid(s):
    # Keep removing valid pairs until no more can be removed
    while '()' in s or '[]' in s or '{}' in s:
        s = s.replace('()', '')
        s = s.replace('[]', '')
        s = s.replace('{}', '')

    return len(s) == 0""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(n)",
      explanation: "Repeatedly remove adjacent matching pairs from the string until no more pairs can be removed. If the string becomes empty, all brackets were properly matched.",
      steps: [
        "Loop while string contains any valid pair: '()', '[]', or '{}'",
        "Remove all occurrences of '()' from string",
        "Remove all occurrences of '[]' from string",
        "Remove all occurrences of '{}' from string",
        "Continue until no more pairs can be removed",
        "Check if resulting string is empty",
        "Return True if empty (all brackets matched), False otherwise"
      ],
    ),
    optimized: Solution(
      code: """def isValid(s):
    stack = []
    pairs = {')': '(', ']': '[', '}': '{'}

    for char in s:
        if char in pairs:  # Closing bracket
            if not stack or stack[-1] != pairs[char]:
                return False
            stack.pop()
        else:  # Opening bracket
            stack.append(char)

    return len(stack) == 0""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Use a stack to track opening brackets. When we encounter a closing bracket, check if it matches the most recent opening bracket (top of stack). If all brackets match properly, stack will be empty at the end.",
      steps: [
        "Initialize empty stack and pairs mapping (closing -> opening)",
        "Iterate through each character in string",
        "If character is a closing bracket (in pairs map):",
        "  - Check if stack is empty or top doesn't match - return False",
        "  - Pop from stack (matched pair found)",
        "If character is an opening bracket:",
        "  - Push it onto stack",
        "After processing all characters, check if stack is empty",
        "Return True if empty (all matched), False otherwise"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 155,
    title: "Min Stack",
    difficulty: Difficulty.medium,
    category: "Stack",
    question: """Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.

Implement the MinStack class:
• MinStack() initializes the stack object.
• void push(int val) pushes the element val onto the stack.
• void pop() removes the element on the top of the stack.
• int top() gets the top element of the stack.
• int getMin() retrieves the minimum element in the stack.

You must implement a solution with O(1) time complexity for each function.

Example 1:
Input
["MinStack","push","push","push","getMin","pop","top","getMin"]
[[],[-2],[0],[-3],[],[],[],[]]

Output
[null,null,null,null,-3,null,0,-2]

Explanation
MinStack minStack = new MinStack();
minStack.push(-2);
minStack.push(0);
minStack.push(-3);
minStack.getMin(); // return -3
minStack.pop();
minStack.top();    // return 0
minStack.getMin(); // return -2

Constraints:
• -2³¹ <= val <= 2³¹ - 1
• Methods pop, top and getMin operations will always be called on non-empty stacks.
• At most 3 * 10⁴ calls will be made to push, pop, top, and getMin.""",
    bruteForce: Solution(
      code: """class MinStack:
    def __init__(self):
        self.stack = []

    def push(self, val):
        self.stack.append(val)

    def pop(self):
        self.stack.pop()

    def top(self):
        return self.stack[-1]

    def getMin(self):
        return min(self.stack)  # O(n) operation""",
      timeComplexity: "O(n) for getMin, O(1) for others",
      spaceComplexity: "O(n)",
      explanation: "Use a single list as the stack. For getMin, scan through entire stack to find minimum value. This makes getMin operation O(n) instead of required O(1).",
      steps: [
        "Initialize: Create empty list 'stack'",
        "Push: Append value to end of list",
        "Pop: Remove last element from list",
        "Top: Return last element (stack[-1])",
        "GetMin: Use min() function to scan entire stack",
        "Note: This violates O(1) requirement for getMin"
      ],
    ),
    optimized: Solution(
      code: """class MinStack:
    def __init__(self):
        self.stack = []
        self.min_stack = []

    def push(self, val):
        self.stack.append(val)
        # Push current min to min_stack
        if not self.min_stack:
            self.min_stack.append(val)
        else:
            self.min_stack.append(min(val, self.min_stack[-1]))

    def pop(self):
        self.stack.pop()
        self.min_stack.pop()

    def top(self):
        return self.stack[-1]

    def getMin(self):
        return self.min_stack[-1]""",
      timeComplexity: "O(1) for all operations",
      spaceComplexity: "O(n)",
      explanation: "Use two stacks: one for values and one for tracking minimums. The min_stack stores the minimum value at each level, so the top of min_stack is always the current minimum.",
      steps: [
        "Initialize: Create two empty lists - 'stack' and 'min_stack'",
        "Push: Append value to stack, and append min(value, current_min) to min_stack",
        "Pop: Pop from both stack and min_stack simultaneously",
        "Top: Return top of main stack",
        "GetMin: Return top of min_stack (O(1) operation)",
        "Key insight: min_stack[i] stores minimum of stack[0..i]",
        "Both stacks stay synchronized in size"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 150,
    title: "Evaluate Reverse Polish Notation",
    difficulty: Difficulty.medium,
    category: "Stack",
    question: """You are given an array of strings tokens that represents an arithmetic expression in a Reverse Polish Notation.

Evaluate the expression. Return an integer that represents the value of the expression.

Note that:
• The valid operators are '+', '-', '*', and '/'.
• Each operand may be an integer or another expression.
• The division between two integers always truncates toward zero.
• There will not be any division by zero.
• The input represents a valid arithmetic expression in a reverse polish notation.
• The answer and all the intermediate calculations can be represented in a 32-bit integer.

Example 1:
Input: tokens = ["2","1","+","3","*"]
Output: 9
Explanation: ((2 + 1) * 3) = 9

Example 2:
Input: tokens = ["4","13","5","/","+"]
Output: 6
Explanation: (4 + (13 / 5)) = 6

Example 3:
Input: tokens = ["10","6","9","3","+","-11","*","/","*","17","+","5","+"]
Output: 22
Explanation: ((10 * (6 / ((9 + 3) * -11))) + 17) + 5

Constraints:
• 1 <= tokens.length <= 10⁴
• tokens[i] is either an operator: "+", "-", "*", or "/", or an integer in the range [-200, 200].""",
    bruteForce: Solution(
      code: """def evalRPN(tokens):
    # In RPN, there's no simpler approach than using a stack
    # This is already the optimal solution
    stack = []

    for token in tokens:
        if token in ['+', '-', '*', '/']:
            b = stack.pop()
            a = stack.pop()

            if token == '+':
                result = a + b
            elif token == '-':
                result = a - b
            elif token == '*':
                result = a * b
            else:  # token == '/'
                result = int(a / b)  # Truncate toward zero

            stack.append(result)
        else:
            stack.append(int(token))

    return stack[0]""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "RPN is designed to be evaluated with a stack. Process tokens left to right: push numbers onto stack, when encountering an operator, pop two operands, apply operation, and push result back.",
      steps: [
        "Initialize empty stack",
        "Iterate through each token in tokens array",
        "If token is an operator (+, -, *, /):",
        "  - Pop two operands from stack (b first, then a)",
        "  - Apply operation: a operator b",
        "  - For division, use int(a/b) to truncate toward zero",
        "  - Push result back onto stack",
        "If token is a number:",
        "  - Convert to integer and push onto stack",
        "After processing all tokens, stack contains one element - the final result",
        "Return stack[0]"
      ],
    ),
    optimized: Solution(
      code: """def evalRPN(tokens):
    stack = []
    operators = {
        '+': lambda a, b: a + b,
        '-': lambda a, b: a - b,
        '*': lambda a, b: a * b,
        '/': lambda a, b: int(a / b)
    }

    for token in tokens:
        if token in operators:
            b = stack.pop()
            a = stack.pop()
            stack.append(operators[token](a, b))
        else:
            stack.append(int(token))

    return stack[0]""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Same stack-based approach but using a dictionary of lambda functions for cleaner operator handling. This is the natural and optimal solution for RPN evaluation.",
      steps: [
        "Initialize empty stack",
        "Create operators dictionary mapping symbols to lambda functions",
        "Iterate through each token",
        "If token is in operators dictionary:",
        "  - Pop b (second operand), then pop a (first operand)",
        "  - Apply operation using operators[token](a, b)",
        "  - Push result onto stack",
        "If token is a number, convert to int and push",
        "Return final result from stack[0]",
        "Note: Dictionary lookup and lambda makes code cleaner"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 22,
    title: "Generate Parentheses",
    difficulty: Difficulty.medium,
    category: "Stack",
    question: """Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.

Example 1:
Input: n = 3
Output: ["((()))","(()())","(())()","()(())","()()()"]

Example 2:
Input: n = 1
Output: ["()"]

Constraints:
• 1 <= n <= 8""",
    bruteForce: Solution(
      code: """def generateParenthesis(n):
    def isValid(s):
        count = 0
        for char in s:
            if char == '(':
                count += 1
            else:
                count -= 1
            if count < 0:
                return False
        return count == 0

    def generate(s, length):
        if length == 0:
            if isValid(s):
                result.append(s)
            return

        generate(s + '(', length - 1)
        generate(s + ')', length - 1)

    result = []
    generate('', 2 * n)
    return result""",
      timeComplexity: "O(2^(2n) * n)",
      spaceComplexity: "O(2^(2n) * n)",
      explanation: "Generate all possible combinations of 2n characters where each character is either '(' or ')'. Then filter out invalid combinations using a validation function that checks if parentheses are properly balanced.",
      steps: [
        "Create isValid helper function to check if string has balanced parentheses",
        "Create recursive generate function that builds all 2^(2n) combinations",
        "Base case: when length reaches 0, check if string is valid",
        "If valid, add to result list",
        "Recursive case: try adding '(' and try adding ')'",
        "Start recursion with empty string and length 2n",
        "Return result list",
        "Note: Very inefficient as it generates many invalid strings"
      ],
    ),
    optimized: Solution(
      code: """def generateParenthesis(n):
    result = []

    def backtrack(s, open_count, close_count):
        # Base case: built valid string
        if len(s) == 2 * n:
            result.append(s)
            return

        # Add '(' if we haven't used all n opening brackets
        if open_count < n:
            backtrack(s + '(', open_count + 1, close_count)

        # Add ')' only if it doesn't exceed opening brackets
        if close_count < open_count:
            backtrack(s + ')', open_count, close_count + 1)

    backtrack('', 0, 0)
    return result""",
      timeComplexity: "O(4^n / sqrt(n)) - Catalan number",
      spaceComplexity: "O(n) - recursion depth",
      explanation: "Use backtracking to build only valid strings. Add opening bracket if we haven't used all n. Add closing bracket only if it won't make string invalid (close_count < open_count). This generates only valid combinations.",
      steps: [
        "Initialize empty result list",
        "Create backtrack helper function with parameters: string, open_count, close_count",
        "Base case: if string length equals 2n, add to result and return",
        "If open_count < n, we can add '(' - recursively call with open_count + 1",
        "If close_count < open_count, we can add ')' - recursively call with close_count + 1",
        "Key insight: Never add ')' if it would exceed number of '(' so far",
        "Start backtracking with empty string and counts of 0",
        "Return result list containing only valid combinations"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 739,
    title: "Daily Temperatures",
    difficulty: Difficulty.medium,
    category: "Stack",
    question: """Given an array of integers temperatures represents the daily temperatures, return an array answer such that answer[i] is the number of days you have to wait after the ith day to get a warmer temperature. If there is no future day for which this is possible, keep answer[i] == 0 instead.

Example 1:
Input: temperatures = [73,74,75,71,69,72,76,73]
Output: [1,1,4,2,1,1,0,0]

Example 2:
Input: temperatures = [30,40,50,60]
Output: [1,1,1,0]

Example 3:
Input: temperatures = [30,60,90]
Output: [1,1,0]

Constraints:
• 1 <= temperatures.length <= 10⁵
• 30 <= temperatures[i] <= 100""",
    bruteForce: Solution(
      code: """def dailyTemperatures(temperatures):
    n = len(temperatures)
    result = [0] * n

    for i in range(n):
        for j in range(i + 1, n):
            if temperatures[j] > temperatures[i]:
                result[i] = j - i
                break

    return result""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(n)",
      explanation: "For each day, scan forward through all future days to find the first day with a warmer temperature. Calculate the difference in days and store in result.",
      steps: [
        "Initialize result array with all zeros, same length as temperatures",
        "For each day i from 0 to n-1:",
        "  - Look at all future days j from i+1 to n-1",
        "  - If temperatures[j] > temperatures[i]:",
        "    - Set result[i] = j - i (days to wait)",
        "    - Break inner loop (found first warmer day)",
        "  - If no warmer day found, result[i] remains 0",
        "Return result array"
      ],
    ),
    optimized: Solution(
      code: """def dailyTemperatures(temperatures):
    n = len(temperatures)
    result = [0] * n
    stack = []  # Stack stores indices

    for i in range(n):
        # While current temp is warmer than temp at stack top
        while stack and temperatures[i] > temperatures[stack[-1]]:
            prev_index = stack.pop()
            result[prev_index] = i - prev_index

        stack.append(i)

    return result""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Use a monotonic decreasing stack that stores indices of days waiting for warmer weather. When we find a warmer day, pop all indices from stack where current temperature is warmer, and record the wait time.",
      steps: [
        "Initialize result array with zeros and empty stack",
        "Stack stores indices of days still waiting for warmer temperature",
        "Iterate through temperatures with index i",
        "While stack is not empty AND current temp > temp at stack top:",
        "  - Pop index from stack (found its warmer day)",
        "  - Set result[prev_index] = i - prev_index",
        "Push current index i onto stack",
        "After loop, remaining indices in stack have no warmer day (result stays 0)",
        "Return result array",
        "Key: Each index pushed and popped at most once - O(n)"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 853,
    title: "Car Fleet",
    difficulty: Difficulty.medium,
    category: "Stack",
    question: """There are n cars at given miles away from target mile target on a one-lane road.

You are given two integer arrays position and speed, both of length n, where position[i] is the position of the ith car and speed[i] is the speed of the ith car (in miles per hour).

A car cannot pass another car, but it can catch up and then travel next to it at the speed of the slower car.

A car fleet is a non-empty set of cars driving at the same position and same speed. Note that a single car is also a car fleet.

If a car catches up to a car fleet at the target mile, it will still be considered as part of the car fleet.

Return the number of car fleets that will arrive at the destination.

Example 1:
Input: target = 12, position = [10,8,0,5,3], speed = [2,4,1,1,3]
Output: 3
Explanation:
• Car at position 10 (speed 2) arrives at time (12-10)/2 = 1
• Car at position 8 (speed 4) arrives at time (12-8)/4 = 1
• Car at position 0 (speed 1) arrives at time (12-0)/1 = 12
• Car at position 5 (speed 1) arrives at time (12-5)/1 = 7
• Car at position 3 (speed 3) arrives at time (12-3)/3 = 3
Sorted by position: 10, 8, 5, 3, 0
Times: 1, 1, 7, 3, 12
Car at position 10 and 8 form fleet (both arrive at time 1).
Car at position 5 forms a fleet alone.
Car at position 3 catches up to car at 5.
Car at position 0 forms a fleet alone.
Total: 3 fleets

Example 2:
Input: target = 10, position = [3], speed = [3]
Output: 1

Example 3:
Input: target = 100, position = [0,2,4], speed = [4,2,1]
Output: 1

Constraints:
• n == position.length == speed.length
• 1 <= n <= 10⁵
• 0 < target <= 10⁶
• 0 <= position[i] < target
• All values of position are unique.
• 0 < speed[i] <= 10⁶""",
    bruteForce: Solution(
      code: """def carFleet(target, position, speed):
    # Pair position with speed and sort by position descending
    cars = sorted(zip(position, speed), reverse=True)

    fleets = []

    for pos, spd in cars:
        # Calculate time to reach target
        time = (target - pos) / spd

        # Check if this car catches up to previous fleet
        if not fleets or time > fleets[-1]:
            # New fleet
            fleets.append(time)
        # else: car catches up to previous fleet (merge)

    return len(fleets)""",
      timeComplexity: "O(n log n)",
      spaceComplexity: "O(n)",
      explanation: "Sort cars by position (closest to target first). Calculate arrival time for each car. If a car takes longer than the car ahead, it forms a new fleet. Otherwise, it catches up and merges with the fleet ahead.",
      steps: [
        "Pair each position with its speed using zip",
        "Sort pairs by position in descending order (closest to target first)",
        "Initialize empty fleets list to store arrival times",
        "For each car (from front to back):",
        "  - Calculate time to reach target: (target - position) / speed",
        "  - If fleets is empty OR time > last fleet's time:",
        "    - This car can't catch up, forms new fleet",
        "    - Append time to fleets list",
        "  - Otherwise, car catches up to previous fleet (don't add to list)",
        "Return number of fleets (length of fleets list)"
      ],
    ),
    optimized: Solution(
      code: """def carFleet(target, position, speed):
    # Pair and sort by position descending
    cars = sorted(zip(position, speed), reverse=True)

    stack = []

    for pos, spd in cars:
        time = (target - pos) / spd

        # If this car is slower than previous (takes more time)
        # it forms a new fleet
        if not stack or time > stack[-1]:
            stack.append(time)
        # else: catches up to car ahead, joins its fleet

    return len(stack)""",
      timeComplexity: "O(n log n)",
      spaceComplexity: "O(n)",
      explanation: "Same approach as brute force, but conceptually using a stack. Sort cars by position descending. For each car, calculate arrival time. Use monotonic stack: only push if current time > stack top (new fleet). Length of stack is number of fleets.",
      steps: [
        "Pair positions with speeds and sort by position descending",
        "Initialize empty stack",
        "Iterate through sorted cars (from closest to target to farthest)",
        "Calculate arrival time: (target - position) / speed",
        "If stack is empty OR time > stack[-1]:",
        "  - Current car is slower, forms new fleet",
        "  - Push time onto stack",
        "Otherwise:",
        "  - Current car catches up to fleet ahead",
        "  - Don't push (implicitly merges with previous fleet)",
        "Return stack length (number of distinct fleets)",
        "Note: Stack maintains arrival times of fleet leaders in decreasing order"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 84,
    title: "Largest Rectangle in Histogram",
    difficulty: Difficulty.hard,
    category: "Stack",
    question: """Given an array of integers heights representing the histogram's bar height where the width of each bar is 1, return the area of the largest rectangle in the histogram.

Example 1:
Input: heights = [2,1,5,6,2,3]
Output: 10
Explanation: The above is a histogram where width of each bar is 1.
The largest rectangle is shown in the red area, which has an area = 10 units.

Example 2:
Input: heights = [2,4]
Output: 4

Constraints:
• 1 <= heights.length <= 10⁵
• 0 <= heights[i] <= 10⁴""",
    bruteForce: Solution(
      code: """def largestRectangleArea(heights):
    max_area = 0

    for i in range(len(heights)):
        min_height = heights[i]

        for j in range(i, len(heights)):
            min_height = min(min_height, heights[j])
            width = j - i + 1
            area = min_height * width
            max_area = max(max_area, area)

    return max_area""",
      timeComplexity: "O(n²)",
      spaceComplexity: "O(1)",
      explanation: "For each starting position i, expand to the right tracking the minimum height encountered. For each expansion, calculate area as minimum_height × width and update maximum.",
      steps: [
        "Initialize max_area to 0",
        "For each starting index i:",
        "  - Initialize min_height to heights[i]",
        "  - For each ending index j from i onwards:",
        "    - Update min_height to min(min_height, heights[j])",
        "    - Calculate width as j - i + 1",
        "    - Calculate area as min_height × width",
        "    - Update max_area if current area is larger",
        "Return max_area after checking all rectangles"
      ],
    ),
    optimized: Solution(
      code: """def largestRectangleArea(heights):
    stack = []  # Stores (index, height)
    max_area = 0

    for i, h in enumerate(heights):
        start = i

        # Pop while current height is less than stack top
        while stack and stack[-1][1] > h:
            index, height = stack.pop()
            area = height * (i - index)
            max_area = max(max_area, area)
            start = index  # Can extend back to this index

        stack.append((start, h))

    # Process remaining bars in stack
    for index, height in stack:
        area = height * (len(heights) - index)
        max_area = max(max_area, area)

    return max_area""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Use monotonic increasing stack storing (index, height) pairs. When we encounter a shorter bar, pop taller bars and calculate their maximum rectangles. Each popped bar's rectangle extends from its start index to current position.",
      steps: [
        "Initialize empty stack (stores index-height pairs) and max_area",
        "For each bar at index i with height h:",
        "  - Set start = i (potential start of rectangle)",
        "  - While stack not empty AND top height > current height:",
        "    - Pop bar from stack",
        "    - Calculate area for popped bar: height × (i - index)",
        "    - Update max_area",
        "    - Update start to popped bar's index (can extend back)",
        "  - Push (start, h) to stack",
        "After loop, process remaining bars in stack:",
        "  - For each bar, it can extend to end of array",
        "  - Calculate area: height × (len(heights) - index)",
        "  - Update max_area",
        "Return max_area"
      ],
    ),
  ),

];
