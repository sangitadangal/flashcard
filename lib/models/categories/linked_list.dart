import '../leetcode_question.dart';

// NeetCode 150 - Linked List Category
// 11 questions with complete solutions

final List<LeetCodeQuestion> linkedListQuestions = [

  LeetCodeQuestion(
    id: 206,
    title: "Reverse Linked List",
    difficulty: Difficulty.easy,
    category: "Linked List",
    question: """Given the head of a singly linked list, reverse the list, and return the reversed list.

Example 1:
Input: head = [1,2,3,4,5]
Output: [5,4,3,2,1]

Example 2:
Input: head = [1,2]
Output: [2,1]

Example 3:
Input: head = []
Output: []

Constraints:
• The number of nodes in the list is the range [0, 5000].
• -5000 <= Node.val <= 5000

Follow up: A linked list can be reversed either iteratively or recursively. Could you implement both?

Definition for singly-linked list:
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next""",
    bruteForce: Solution(
      code: """def reverseList(head):
    # Store values in array
    values = []
    current = head
    while current:
        values.append(current.val)
        current = current.next

    # Rebuild list in reverse
    if not values:
        return None

    new_head = ListNode(values[-1])
    current = new_head
    for i in range(len(values) - 2, -1, -1):
        current.next = ListNode(values[i])
        current = current.next

    return new_head""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Extract all values into an array, then create a new linked list with values in reverse order. This uses extra space to store all values.",
      steps: [
        "Create empty array to store values",
        "Traverse linked list and append each value to array",
        "Handle empty list case - return None",
        "Create new head node with last value from array",
        "Iterate backwards through array (excluding last element)",
        "For each value, create new node and link it",
        "Return new head",
        "Note: Uses O(n) extra space for array"
      ],
    ),
    optimized: Solution(
      code: """def reverseList(head):
    prev = None
    current = head

    while current:
        next_node = current.next  # Save next node
        current.next = prev       # Reverse the link
        prev = current            # Move prev forward
        current = next_node       # Move current forward

    return prev""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Iteratively reverse the links in-place using three pointers: prev, current, and next. For each node, reverse its next pointer to point to the previous node.",
      steps: [
        "Initialize prev = None (will become new tail)",
        "Initialize current = head",
        "Loop while current is not None:",
        "  - Save next node: next_node = current.next",
        "  - Reverse link: current.next = prev",
        "  - Move prev forward: prev = current",
        "  - Move current forward: current = next_node",
        "When loop ends, prev points to new head",
        "Return prev",
        "Key: Reverse links in-place with O(1) space"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 21,
    title: "Merge Two Sorted Lists",
    difficulty: Difficulty.easy,
    category: "Linked List",
    question: """You are given the heads of two sorted linked lists list1 and list2.

Merge the two lists into one sorted list. The list should be made by splicing together the nodes of the first two lists.

Return the head of the merged linked list.

Example 1:
Input: list1 = [1,2,4], list2 = [1,3,4]
Output: [1,1,2,3,4,4]

Example 2:
Input: list1 = [], list2 = []
Output: []

Example 3:
Input: list1 = [], list2 = [0]
Output: [0]

Constraints:
• The number of nodes in both lists is in the range [0, 50].
• -100 <= Node.val <= 100
• Both list1 and list2 are sorted in non-decreasing order.""",
    bruteForce: Solution(
      code: """def mergeTwoLists(list1, list2):
    # Collect all values
    values = []

    current = list1
    while current:
        values.append(current.val)
        current = current.next

    current = list2
    while current:
        values.append(current.val)
        current = current.next

    # Sort values
    values.sort()

    # Build new list
    if not values:
        return None

    head = ListNode(values[0])
    current = head
    for i in range(1, len(values)):
        current.next = ListNode(values[i])
        current = current.next

    return head""",
      timeComplexity: "O(n log n)",
      spaceComplexity: "O(n)",
      explanation: "Extract all values from both lists into an array, sort the array, then build a new linked list from sorted values. This doesn't leverage that the input lists are already sorted.",
      steps: [
        "Create empty array to collect all values",
        "Traverse list1 and append all values to array",
        "Traverse list2 and append all values to array",
        "Sort the array",
        "Handle empty array case - return None",
        "Create new linked list from sorted values",
        "Return head of new list",
        "Note: Sorting takes O(n log n), doesn't use pre-sorted property"
      ],
    ),
    optimized: Solution(
      code: """def mergeTwoLists(list1, list2):
    # Create dummy node
    dummy = ListNode(0)
    current = dummy

    # Merge while both lists have nodes
    while list1 and list2:
        if list1.val <= list2.val:
            current.next = list1
            list1 = list1.next
        else:
            current.next = list2
            list2 = list2.next
        current = current.next

    # Attach remaining nodes
    if list1:
        current.next = list1
    if list2:
        current.next = list2

    return dummy.next""",
      timeComplexity: "O(n + m)",
      spaceComplexity: "O(1)",
      explanation: "Use a dummy node to simplify edge cases. Compare nodes from both lists and attach the smaller one to the result. When one list is exhausted, attach the remainder of the other list.",
      steps: [
        "Create dummy node to act as placeholder for result head",
        "Initialize current pointer to dummy",
        "While both lists have remaining nodes:",
        "  - Compare values of current nodes from both lists",
        "  - Attach the smaller node to current.next",
        "  - Advance the pointer in the list we took from",
        "  - Move current pointer forward",
        "After loop, one or both lists may be empty",
        "Attach remaining nodes from whichever list is non-empty",
        "Return dummy.next (actual head of merged list)"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 143,
    title: "Reorder List",
    difficulty: Difficulty.medium,
    category: "Linked List",
    question: """You are given the head of a singly linked-list. The list can be represented as:
L0 → L1 → … → Ln - 1 → Ln

Reorder the list to be on the following form:
L0 → Ln → L1 → Ln - 1 → L2 → Ln - 2 → …

You may not modify the values in the list's nodes. Only nodes themselves may be changed.

Example 1:
Input: head = [1,2,3,4]
Output: [1,4,2,3]

Example 2:
Input: head = [1,2,3,4,5]
Output: [1,5,2,4,3]

Constraints:
• The number of nodes in the list is in the range [1, 5 * 10⁴].
• 1 <= Node.val <= 1000""",
    bruteForce: Solution(
      code: """def reorderList(head):
    if not head or not head.next:
        return

    # Store nodes in array
    nodes = []
    current = head
    while current:
        nodes.append(current)
        current = current.next

    # Reorder using two pointers on array
    left = 0
    right = len(nodes) - 1

    while left < right:
        nodes[left].next = nodes[right]
        left += 1
        if left == right:
            break
        nodes[right].next = nodes[left]
        right -= 1

    nodes[left].next = None""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Store all nodes in an array for easy access by index. Use two pointers to alternate between nodes from the start and end, reordering the links.",
      steps: [
        "Handle edge case: return if list is empty or has one node",
        "Create array and store all nodes",
        "Traverse list and append each node to array",
        "Initialize two pointers: left at 0, right at end",
        "Loop while left < right:",
        "  - Link nodes[left] to nodes[right]",
        "  - Increment left",
        "  - Break if left == right (odd length, done)",
        "  - Link nodes[right] to nodes[left]",
        "  - Decrement right",
        "Set last node's next to None to avoid cycle",
        "Note: Uses O(n) space for array"
      ],
    ),
    optimized: Solution(
      code: """def reorderList(head):
    if not head or not head.next:
        return

    # Find middle using slow/fast pointers
    slow = fast = head
    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next

    # Reverse second half
    prev = None
    current = slow
    while current:
        next_node = current.next
        current.next = prev
        prev = current
        current = next_node

    # Merge two halves
    first = head
    second = prev

    while second.next:
        temp1 = first.next
        temp2 = second.next

        first.next = second
        second.next = temp1

        first = temp1
        second = temp2""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Three steps: (1) Find middle using slow/fast pointers, (2) Reverse second half, (3) Merge two halves by alternating nodes. All done in-place without extra space.",
      steps: [
        "Handle edge case: return if list empty or has one node",
        "Step 1: Find middle of list using slow/fast pointers",
        "  - Slow moves one step, fast moves two steps",
        "  - When fast reaches end, slow is at middle",
        "Step 2: Reverse second half starting from slow",
        "  - Use standard reverse linked list algorithm",
        "  - prev will point to head of reversed second half",
        "Step 3: Merge two halves",
        "  - first pointer at original head",
        "  - second pointer at head of reversed second half",
        "  - Alternate nodes: first -> second -> first.next -> second.next...",
        "  - Continue while second.next exists",
        "Result: List is reordered in-place with O(1) space"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 19,
    title: "Remove Nth Node From End of List",
    difficulty: Difficulty.medium,
    category: "Linked List",
    question: """Given the head of a linked list, remove the nth node from the end of the list and return its head.

Example 1:
Input: head = [1,2,3,4,5], n = 2
Output: [1,2,3,5]

Example 2:
Input: head = [1], n = 1
Output: []

Example 3:
Input: head = [1,2], n = 1
Output: [1]

Constraints:
• The number of nodes in the list is sz.
• 1 <= sz <= 30
• 0 <= Node.val <= 100
• 1 <= n <= sz

Follow up: Could you do this in one pass?""",
    bruteForce: Solution(
      code: """def removeNthFromEnd(head, n):
    # First pass: count nodes
    length = 0
    current = head
    while current:
        length += 1
        current = current.next

    # Handle removing first node
    if length == n:
        return head.next

    # Second pass: find node before target
    target_pos = length - n
    current = head
    for i in range(target_pos - 1):
        current = current.next

    # Remove target node
    current.next = current.next.next

    return head""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Two-pass approach: First pass counts total nodes to determine the position from the start. Second pass navigates to the node before the target and removes it.",
      steps: [
        "First pass: Count total number of nodes",
        "Traverse entire list incrementing counter",
        "Calculate position from start: length - n",
        "Handle edge case: if removing first node, return head.next",
        "Second pass: Navigate to node before target position",
        "Use for loop to move (length - n - 1) steps",
        "Remove target node: current.next = current.next.next",
        "Return head",
        "Note: Requires two passes through list"
      ],
    ),
    optimized: Solution(
      code: """def removeNthFromEnd(head, n):
    dummy = ListNode(0)
    dummy.next = head

    fast = slow = dummy

    # Move fast n steps ahead
    for i in range(n):
        fast = fast.next

    # Move both until fast reaches end
    while fast.next:
        fast = fast.next
        slow = slow.next

    # Remove target node
    slow.next = slow.next.next

    return dummy.next""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "One-pass solution using two pointers with n-step gap. When fast reaches end, slow will be at the node before the target. Use dummy node to handle edge case of removing first node.",
      steps: [
        "Create dummy node pointing to head (handles edge cases)",
        "Initialize two pointers: fast and slow, both at dummy",
        "Move fast pointer n steps ahead",
        "Move both pointers together until fast reaches last node",
        "  - When fast is at last node, slow is before target",
        "  - The gap between fast and slow is n nodes",
        "Remove target node: slow.next = slow.next.next",
        "Return dummy.next (actual head)",
        "Key: One pass using two-pointer technique with gap"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 138,
    title: "Copy List with Random Pointer",
    difficulty: Difficulty.medium,
    category: "Linked List",
    question: """A linked list of length n is given such that each node contains an additional random pointer, which could point to any node in the list, or null.

Construct a deep copy of the list. The deep copy should consist of exactly n brand new nodes, where each new node has its value set to the value of its corresponding original node. Both the next and random pointer of the new nodes should point to new nodes in the copied list such that the pointers in the original list and copied list represent the same list state. None of the pointers in the new list should point to nodes in the original list.

For example, if there are two nodes X and Y in the original list, where X.random --> Y, then for the corresponding two nodes x and y in the copied list, x.random --> y.

Return the head of the copied linked list.

The linked list is represented in the input/output as a list of n nodes. Each node is represented as a pair of [val, random_index] where:
• val: an integer representing Node.val
• random_index: the index of the node (range from 0 to n-1) that the random pointer points to, or null if it does not point to any node.

Your code will only be given the head of the original linked list.

Example 1:
Input: head = [[7,null],[13,0],[11,4],[10,2],[1,0]]
Output: [[7,null],[13,0],[11,4],[10,2],[1,0]]

Example 2:
Input: head = [[1,1],[2,1]]
Output: [[1,1],[2,1]]

Example 3:
Input: head = [[3,null],[3,0],[3,null]]
Output: [[3,null],[3,0],[3,null]]

Constraints:
• 0 <= n <= 1000
• -10⁴ <= Node.val <= 10⁴
• Node.random is null or is pointing to some node in the linked list.

Definition:
class Node:
    def __init__(self, x, next=None, random=None):
        self.val = int(x)
        self.next = next
        self.random = random""",
    bruteForce: Solution(
      code: """def copyRandomList(head):
    if not head:
        return None

    # First pass: create all nodes and store in hash map
    old_to_new = {}
    current = head
    while current:
        old_to_new[current] = Node(current.val)
        current = current.next

    # Second pass: set next and random pointers
    current = head
    while current:
        if current.next:
            old_to_new[current].next = old_to_new[current.next]
        if current.random:
            old_to_new[current].random = old_to_new[current.random]
        current = current.next

    return old_to_new[head]""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Two-pass approach with hash map. First pass creates all new nodes and maps old nodes to new nodes. Second pass sets next and random pointers using the mapping.",
      steps: [
        "Handle edge case: return None if head is None",
        "Create hash map: old node -> new node",
        "First pass: Traverse original list",
        "  - For each node, create new node with same value",
        "  - Store mapping: old_to_new[current] = new_node",
        "Second pass: Traverse original list again",
        "  - Set new_node.next using old_to_new[current.next]",
        "  - Set new_node.random using old_to_new[current.random]",
        "  - Handle null cases for next and random",
        "Return old_to_new[head] (head of copied list)",
        "Note: Hash map uses O(n) space"
      ],
    ),
    optimized: Solution(
      code: """def copyRandomList(head):
    if not head:
        return None

    # Step 1: Create copy nodes interleaved with original
    current = head
    while current:
        copy = Node(current.val)
        copy.next = current.next
        current.next = copy
        current = copy.next

    # Step 2: Set random pointers for copy nodes
    current = head
    while current:
        if current.random:
            current.next.random = current.random.next
        current = current.next.next

    # Step 3: Separate the two lists
    current = head
    copy_head = head.next
    while current:
        copy = current.next
        current.next = copy.next
        if copy.next:
            copy.next = copy.next.next
        current = current.next

    return copy_head""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Three-pass constant space solution. Interleave copy nodes with originals, set random pointers, then separate the lists. Avoids hash map by using the interleaved structure for mapping.",
      steps: [
        "Handle edge case: return None if head is None",
        "Step 1: Create interleaved list (original -> copy -> original -> copy...)",
        "  - For each node, create copy and insert after original",
        "  - original.next = copy, copy.next = original.next",
        "Step 2: Set random pointers for copy nodes",
        "  - For each original node, if it has random pointer",
        "  - Copy's random = original.random.next (the copy of original.random)",
        "Step 3: Separate original and copy lists",
        "  - Restore original list: current.next = copy.next",
        "  - Build copy list: copy.next = copy.next.next",
        "  - Save copy_head before separation",
        "Return copy_head",
        "Key: Uses list structure itself for mapping, O(1) space"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 2,
    title: "Add Two Numbers",
    difficulty: Difficulty.medium,
    category: "Linked List",
    question: """You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

Example 1:
Input: l1 = [2,4,3], l2 = [5,6,4]
Output: [7,0,8]
Explanation: 342 + 465 = 807.

Example 2:
Input: l1 = [0], l2 = [0]
Output: [0]

Example 3:
Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
Output: [8,9,9,9,0,0,0,1]

Constraints:
• The number of nodes in each linked list is in the range [1, 100].
• 0 <= Node.val <= 9
• It is guaranteed that the list represents a number that does not have leading zeros.""",
    bruteForce: Solution(
      code: """def addTwoNumbers(l1, l2):
    # Extract numbers
    num1 = 0
    power = 0
    current = l1
    while current:
        num1 += current.val * (10 ** power)
        power += 1
        current = current.next

    num2 = 0
    power = 0
    current = l2
    while current:
        num2 += current.val * (10 ** power)
        power += 1
        current = current.next

    # Add numbers
    total = num1 + num2

    # Convert back to linked list
    if total == 0:
        return ListNode(0)

    dummy = ListNode(0)
    current = dummy
    while total > 0:
        digit = total % 10
        current.next = ListNode(digit)
        current = current.next
        total //= 10

    return dummy.next""",
      timeComplexity: "O(max(n, m))",
      spaceComplexity: "O(max(n, m))",
      explanation: "Convert both linked lists to integers, add them, then convert the sum back to a linked list. This can overflow for very large numbers.",
      steps: [
        "Extract first number from l1",
        "  - Traverse l1, building num1 using positional values",
        "  - digit * (10 ** power) where power is position",
        "Extract second number from l2 similarly",
        "Add the two numbers: total = num1 + num2",
        "Handle special case: if total is 0, return ListNode(0)",
        "Convert total back to linked list",
        "  - Extract digits using modulo 10",
        "  - Create nodes in reverse order",
        "Return dummy.next",
        "Note: Can overflow for numbers > max integer size"
      ],
    ),
    optimized: Solution(
      code: """def addTwoNumbers(l1, l2):
    dummy = ListNode(0)
    current = dummy
    carry = 0

    while l1 or l2 or carry:
        val1 = l1.val if l1 else 0
        val2 = l2.val if l2 else 0

        total = val1 + val2 + carry
        carry = total // 10
        digit = total % 10

        current.next = ListNode(digit)
        current = current.next

        if l1:
            l1 = l1.next
        if l2:
            l2 = l2.next

    return dummy.next""",
      timeComplexity: "O(max(n, m))",
      spaceComplexity: "O(max(n, m))",
      explanation: "Simulate addition digit by digit with carry. Traverse both lists simultaneously, adding corresponding digits plus carry. Handle different lengths gracefully.",
      steps: [
        "Create dummy node and current pointer",
        "Initialize carry to 0",
        "Loop while l1 or l2 or carry exists:",
        "  - Get val1 from l1 (or 0 if l1 is None)",
        "  - Get val2 from l2 (or 0 if l2 is None)",
        "  - Calculate total: val1 + val2 + carry",
        "  - Update carry: total // 10",
        "  - Extract digit: total % 10",
        "  - Create new node with digit and advance current",
        "  - Move l1 and l2 forward if they exist",
        "Return dummy.next",
        "Key: Process digit-by-digit, avoids overflow"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 141,
    title: "Linked List Cycle",
    difficulty: Difficulty.easy,
    category: "Linked List",
    question: """Given head, the head of a linked list, determine if the linked list has a cycle in it.

There is a cycle in a linked list if there is some node in the list that can be reached again by continuously following the next pointer. Internally, pos is used to denote the index of the node that tail's next pointer is connected to. Note that pos is not passed as a parameter.

Return true if there is a cycle in the linked list. Otherwise, return false.

Example 1:
Input: head = [3,2,0,-4], pos = 1
Output: true
Explanation: There is a cycle in the linked list, where the tail connects to the 1st node (0-indexed).

Example 2:
Input: head = [1,2], pos = 0
Output: true
Explanation: There is a cycle in the linked list, where the tail connects to the 0th node.

Example 3:
Input: head = [1], pos = -1
Output: false
Explanation: There is no cycle in the linked list.

Constraints:
• The number of the nodes in the list is in the range [0, 10⁴].
• -10⁵ <= Node.val <= 10⁵
• pos is -1 or a valid index in the linked-list.

Follow up: Can you solve it using O(1) (i.e. constant) memory?""",
    bruteForce: Solution(
      code: """def hasCycle(head):
    seen = set()
    current = head

    while current:
        if current in seen:
            return True
        seen.add(current)
        current = current.next

    return False""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Use a hash set to track visited nodes. If we encounter a node we've seen before, there's a cycle. If we reach None, there's no cycle.",
      steps: [
        "Create empty set to track seen nodes",
        "Initialize current pointer to head",
        "Loop while current is not None:",
        "  - Check if current node is in seen set",
        "  - If yes, we found a cycle - return True",
        "  - Add current node to seen set",
        "  - Move to next node",
        "If loop exits (reached None), no cycle - return False",
        "Note: Uses O(n) space for set"
      ],
    ),
    optimized: Solution(
      code: """def hasCycle(head):
    slow = fast = head

    while fast and fast.next:
        slow = slow.next
        fast = fast.next.next

        if slow == fast:
            return True

    return False""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Floyd's Cycle Detection (tortoise and hare). Use two pointers moving at different speeds. If there's a cycle, they will eventually meet. If there's no cycle, fast will reach the end.",
      steps: [
        "Initialize two pointers: slow and fast, both at head",
        "Loop while fast and fast.next exist:",
        "  - Move slow one step: slow = slow.next",
        "  - Move fast two steps: fast = fast.next.next",
        "  - If slow == fast, pointers met - cycle exists, return True",
        "If loop exits, fast reached end - no cycle, return False",
        "Key: In a cycle, faster pointer will eventually lap slower one",
        "Space: O(1) - only two pointers"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 287,
    title: "Find the Duplicate Number",
    difficulty: Difficulty.medium,
    category: "Linked List",
    question: """Given an array of integers nums containing n + 1 integers where each integer is in the range [1, n] inclusive.

There is only one repeated number in nums, return this repeated number.

You must solve the problem without modifying the array nums and uses only constant extra space.

Example 1:
Input: nums = [1,3,4,2,2]
Output: 2

Example 2:
Input: nums = [3,1,3,4,2]
Output: 3

Example 3:
Input: nums = [3,3,3,3,3]
Output: 3

Constraints:
• 1 <= n <= 10⁵
• nums.length == n + 1
• 1 <= nums[i] <= n
• All the integers in nums appear only once except for precisely one integer which appears two or more times.

Follow up:
• How can we prove that at least one duplicate number must exist in nums?
• Can you solve the problem in linear runtime complexity?""",
    bruteForce: Solution(
      code: """def findDuplicate(nums):
    seen = set()
    for num in nums:
        if num in seen:
            return num
        seen.add(num)
    return -1""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Use a hash set to track numbers we've seen. When we encounter a number already in the set, that's the duplicate. This violates the constant space requirement.",
      steps: [
        "Create empty set to track seen numbers",
        "Iterate through nums array",
        "For each number:",
        "  - Check if it's already in seen set",
        "  - If yes, return it (found duplicate)",
        "  - Add it to seen set",
        "If loop completes, return -1 (shouldn't happen per constraints)",
        "Note: Uses O(n) space, violates constant space requirement"
      ],
    ),
    optimized: Solution(
      code: """def findDuplicate(nums):
    # Phase 1: Find intersection point in cycle
    slow = fast = nums[0]

    while True:
        slow = nums[slow]
        fast = nums[nums[fast]]
        if slow == fast:
            break

    # Phase 2: Find entrance to cycle (duplicate number)
    slow = nums[0]
    while slow != fast:
        slow = nums[slow]
        fast = nums[fast]

    return slow""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(1)",
      explanation: "Treat array as linked list where nums[i] points to nums[nums[i]]. The duplicate creates a cycle. Use Floyd's Cycle Detection to find the cycle, then find the entrance to the cycle (the duplicate number).",
      steps: [
        "Treat array as implicit linked list: index i -> nums[i]",
        "Duplicate creates cycle (two indices point to same value)",
        "Phase 1: Detect cycle using Floyd's algorithm",
        "  - Initialize slow and fast at nums[0]",
        "  - Move slow one step, fast two steps",
        "  - Continue until they meet inside cycle",
        "Phase 2: Find cycle entrance (duplicate)",
        "  - Reset slow to nums[0], keep fast at meeting point",
        "  - Move both one step at a time",
        "  - Where they meet is the cycle entrance (duplicate number)",
        "Return the duplicate",
        "Key: Uses array indices as linked list, O(1) space"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 146,
    title: "LRU Cache",
    difficulty: Difficulty.medium,
    category: "Linked List",
    question: """Design a data structure that follows the constraints of a Least Recently Used (LRU) cache.

Implement the LRUCache class:
• LRUCache(int capacity) Initialize the LRU cache with positive size capacity.
• int get(int key) Return the value of the key if the key exists, otherwise return -1.
• void put(int key, int value) Update the value of the key if the key exists. Otherwise, add the key-value pair to the cache. If the number of keys exceeds the capacity from this operation, evict the least recently used key.

The functions get and put must each run in O(1) average time complexity.

Example 1:
Input
["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
[[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]
Output
[null, null, null, 1, null, -1, null, -1, 3, 4]

Explanation
LRUCache lRUCache = new LRUCache(2);
lRUCache.put(1, 1); // cache is {1=1}
lRUCache.put(2, 2); // cache is {1=1, 2=2}
lRUCache.get(1);    // return 1
lRUCache.put(3, 3); // LRU key was 2, evicts key 2, cache is {1=1, 3=3}
lRUCache.get(2);    // returns -1 (not found)
lRUCache.put(4, 4); // LRU key was 1, evicts key 1, cache is {4=4, 3=3}
lRUCache.get(1);    // return -1 (not found)
lRUCache.get(3);    // return 3
lRUCache.get(4);    // return 4

Constraints:
• 1 <= capacity <= 3000
• 0 <= key <= 10⁴
• 0 <= value <= 10⁵
• At most 2 * 10⁵ calls will be made to get and put.""",
    bruteForce: Solution(
      code: """class LRUCache:
    def __init__(self, capacity):
        self.capacity = capacity
        self.cache = {}  # key -> value
        self.order = []  # track access order

    def get(self, key):
        if key not in self.cache:
            return -1
        # Update access order
        self.order.remove(key)  # O(n) operation
        self.order.append(key)
        return self.cache[key]

    def put(self, key, value):
        if key in self.cache:
            self.order.remove(key)  # O(n) operation
        elif len(self.cache) >= self.capacity:
            # Evict LRU
            lru = self.order.pop(0)  # O(n) operation
            del self.cache[lru]

        self.cache[key] = value
        self.order.append(key)""",
      timeComplexity: "O(n) for get and put",
      spaceComplexity: "O(capacity)",
      explanation: "Use hash map for key-value storage and list to track access order. List operations (remove, pop from front) take O(n) time, violating the O(1) requirement.",
      steps: [
        "Initialize: Create hash map for cache and list for order",
        "Get operation:",
        "  - If key not in cache, return -1",
        "  - Remove key from order list (O(n))",
        "  - Append key to end of order list (most recent)",
        "  - Return value from cache",
        "Put operation:",
        "  - If key exists, remove from order list (O(n))",
        "  - If cache full, evict LRU (pop from front of order list, O(n))",
        "  - Add/update key-value in cache",
        "  - Append key to end of order list",
        "Note: List operations make this O(n), not O(1)"
      ],
    ),
    optimized: Solution(
      code: """class Node:
    def __init__(self, key=0, val=0):
        self.key = key
        self.val = val
        self.prev = None
        self.next = None

class LRUCache:
    def __init__(self, capacity):
        self.capacity = capacity
        self.cache = {}  # key -> node
        # Dummy head and tail
        self.head = Node()
        self.tail = Node()
        self.head.next = self.tail
        self.tail.prev = self.head

    def _remove(self, node):
        node.prev.next = node.next
        node.next.prev = node.prev

    def _add_to_end(self, node):
        node.prev = self.tail.prev
        node.next = self.tail
        self.tail.prev.next = node
        self.tail.prev = node

    def get(self, key):
        if key not in self.cache:
            return -1
        node = self.cache[key]
        self._remove(node)
        self._add_to_end(node)
        return node.val

    def put(self, key, value):
        if key in self.cache:
            self._remove(self.cache[key])
        node = Node(key, value)
        self._add_to_end(node)
        self.cache[key] = node

        if len(self.cache) > self.capacity:
            # Remove LRU (after dummy head)
            lru = self.head.next
            self._remove(lru)
            del self.cache[lru.key]""",
      timeComplexity: "O(1) for get and put",
      spaceComplexity: "O(capacity)",
      explanation: "Use hash map for O(1) lookup and doubly linked list for O(1) insertion/deletion. Most recently used items are at the tail, least recently used at the head. Dummy nodes simplify edge cases.",
      steps: [
        "Data structures: Hash map (key -> node) + doubly linked list",
        "Initialize: Create dummy head and tail nodes",
        "Helper _remove(node): Remove node from linked list (O(1))",
        "Helper _add_to_end(node): Add node before tail (most recent, O(1))",
        "Get operation:",
        "  - If key not in cache, return -1",
        "  - Get node from hash map",
        "  - Remove node from current position",
        "  - Add to end (mark as recently used)",
        "  - Return node's value",
        "Put operation:",
        "  - If key exists, remove old node",
        "  - Create new node with key and value",
        "  - Add to end",
        "  - Store in hash map",
        "  - If over capacity, remove LRU (node after head)",
        "Key: Doubly linked list gives O(1) add/remove anywhere"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 23,
    title: "Merge k Sorted Lists",
    difficulty: Difficulty.hard,
    category: "Linked List",
    question: """You are given an array of k linked-lists lists, each linked-list is sorted in ascending order.

Merge all the linked-lists into one sorted linked-list and return it.

Example 1:
Input: lists = [[1,4,5],[1,3,4],[2,6]]
Output: [1,1,2,3,4,4,5,6]
Explanation: The linked-lists are:
[
  1->4->5,
  1->3->4,
  2->6
]
merging them into one sorted list:
1->1->2->3->4->4->5->6

Example 2:
Input: lists = []
Output: []

Example 3:
Input: lists = [[]]
Output: []

Constraints:
• k == lists.length
• 0 <= k <= 10⁴
• 0 <= lists[i].length <= 500
• -10⁴ <= lists[i][j] <= 10⁴
• lists[i] is sorted in ascending order.
• The sum of lists[i].length will not exceed 10⁴.""",
    bruteForce: Solution(
      code: """def mergeKLists(lists):
    # Collect all values
    values = []
    for head in lists:
        current = head
        while current:
            values.append(current.val)
            current = current.next

    # Sort values
    values.sort()

    # Build new list
    if not values:
        return None

    dummy = ListNode(0)
    current = dummy
    for val in values:
        current.next = ListNode(val)
        current = current.next

    return dummy.next""",
      timeComplexity: "O(N log N) - N is total nodes",
      spaceComplexity: "O(N)",
      explanation: "Extract all values from all lists into an array, sort the array, then build a new linked list. This doesn't leverage that individual lists are already sorted.",
      steps: [
        "Create empty array to collect all values",
        "For each list in lists:",
        "  - Traverse the list",
        "  - Append each value to array",
        "Sort the array (O(N log N))",
        "Handle empty array case - return None",
        "Build new linked list from sorted values",
        "  - Use dummy node",
        "  - Create node for each value in order",
        "Return dummy.next",
        "Note: Doesn't use pre-sorted property efficiently"
      ],
    ),
    optimized: Solution(
      code: """def mergeKLists(lists):
    import heapq

    # Min heap: (value, index, node)
    heap = []
    for i, head in enumerate(lists):
        if head:
            heapq.heappush(heap, (head.val, i, head))

    dummy = ListNode(0)
    current = dummy

    while heap:
        val, i, node = heapq.heappop(heap)
        current.next = node
        current = current.next

        if node.next:
            heapq.heappush(heap, (node.next.val, i, node.next))

    return dummy.next""",
      timeComplexity: "O(N log k) - N total nodes, k lists",
      spaceComplexity: "O(k)",
      explanation: "Use a min heap to track the smallest unmerged node from each list. Always pop the smallest node, add it to result, and push the next node from that list. Heap size is at most k.",
      steps: [
        "Import heapq for min heap",
        "Initialize min heap with first node from each non-empty list",
        "  - Store (value, list_index, node) to handle comparisons",
        "  - List index breaks ties when values equal",
        "Create dummy node for result",
        "While heap is not empty:",
        "  - Pop smallest node from heap",
        "  - Add it to result list",
        "  - If popped node has next, push next onto heap",
        "Return dummy.next",
        "Key: Heap maintains k smallest candidates, log k operations",
        "Total: N nodes × log k = O(N log k)"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 25,
    title: "Reverse Nodes in k-Group",
    difficulty: Difficulty.hard,
    category: "Linked List",
    question: """Given the head of a linked list, reverse the nodes of the list k at a time, and return the modified list.

k is a positive integer and is less than or equal to the length of the linked list. If the number of nodes is not a multiple of k then left-out nodes, in the end, should remain as it is.

You may not alter the values in the list's nodes, only nodes themselves may be changed.

Example 1:
Input: head = [1,2,3,4,5], k = 2
Output: [2,1,4,3,5]

Example 2:
Input: head = [1,2,3,4,5], k = 3
Output: [3,2,1,4,5]

Constraints:
• The number of nodes in the list is n.
• 1 <= k <= n <= 5000
• 0 <= Node.val <= 1000

Follow-up: Can you solve the problem in O(1) extra memory (i.e., in-place)?""",
    bruteForce: Solution(
      code: """def reverseKGroup(head, k):
    # Store nodes in array
    nodes = []
    current = head
    while current:
        nodes.append(current)
        current = current.next

    # Reverse in groups of k
    for i in range(0, len(nodes), k):
        # Only reverse if we have k nodes left
        if i + k <= len(nodes):
            # Reverse this group
            left = i
            right = i + k - 1
            while left < right:
                nodes[left], nodes[right] = nodes[right], nodes[left]
                left += 1
                right -= 1

    # Rebuild list
    for i in range(len(nodes) - 1):
        nodes[i].next = nodes[i + 1]
    if nodes:
        nodes[-1].next = None

    return nodes[0] if nodes else None""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n)",
      explanation: "Store all nodes in an array, reverse groups of k in the array using two pointers, then rebuild the linked list. Uses O(n) extra space.",
      steps: [
        "Store all nodes in array",
        "Iterate through array in steps of k:",
        "  - Check if we have k nodes remaining",
        "  - If yes, reverse this group in array using two pointers",
        "  - Swap nodes from left and right, moving inward",
        "  - If no, leave remaining nodes as-is",
        "Rebuild linked list from reordered array:",
        "  - Link each node to the next in array",
        "  - Set last node's next to None",
        "Return first node from array",
        "Note: Uses O(n) space for array"
      ],
    ),
    optimized: Solution(
      code: """def reverseKGroup(head, k):
    # Check if we have k nodes
    count = 0
    current = head
    while current and count < k:
        current = current.next
        count += 1

    if count < k:
        return head  # Not enough nodes, return as-is

    # Reverse first k nodes
    prev = None
    current = head
    for i in range(k):
        next_node = current.next
        current.next = prev
        prev = current
        current = next_node

    # prev is new head of this group
    # head is now tail of this group
    # current points to next group

    # Recursively reverse next groups
    head.next = reverseKGroup(current, k)

    return prev""",
      timeComplexity: "O(n)",
      spaceComplexity: "O(n/k) - recursion depth",
      explanation: "Recursively reverse k nodes at a time. For each group, check if we have k nodes, reverse them, then recursively process the rest. The tail of current group connects to the result of the recursion.",
      steps: [
        "Count if we have at least k nodes ahead",
        "If count < k, return head as-is (base case)",
        "Reverse first k nodes using standard reversal:",
        "  - Use prev, current, next_node pointers",
        "  - After reversal: prev is new head, original head is tail",
        "Recursively reverse remaining list starting from current",
        "Connect tail of current group to result of recursion",
        "Return prev (new head of this group)",
        "Key: Each recursive call handles one group of k",
        "Space: O(n/k) for recursion stack"
      ],
    ),
  ),

];
