import '../leetcode_question.dart';

final List<LeetCodeQuestion> dataStructuresQuestions = [
  // Question 1: Dynamic Array
  LeetCodeQuestion(
    id: 1001,
    title: 'Implement Dynamic Array',
    difficulty: Difficulty.easy,
    category: 'Arrays',
    question:
        'Implement a dynamic array (similar to Python list or Java ArrayList) with operations:\n'
        '• append(value): Add element to end\n'
        '• insert(index, value): Insert at index\n'
        '• delete(index): Remove at index\n'
        '• get(index): Get element at index\n'
        '• size(): Return number of elements',
    bruteForce: Solution(
      steps: [
        'Start with fixed capacity (e.g., 10)',
        'When full, create new array with 2x capacity',
        'Copy all elements to new array',
        'Manually shift elements for insert/delete',
      ],
      timeComplexity: 'O(n) for resize, O(n) for insert/delete',
      spaceComplexity: 'O(n)',
      code: '''class DynamicArray:
    def __init__(self):
        self.capacity = 10
        self.size = 0
        self.arr = [None] * self.capacity

    def append(self, value):
        if self.size == self.capacity:
            self._resize()
        self.arr[self.size] = value
        self.size += 1

    def _resize(self):
        self.capacity *= 2
        new_arr = [None] * self.capacity
        for i in range(self.size):
            new_arr[i] = self.arr[i]
        self.arr = new_arr

    def get(self, index):
        if index >= self.size:
            raise IndexError()
        return self.arr[index]''',
      explanation:
          'Fixed-size array with manual resizing. Doubles capacity when full for amortized O(1) append. Simple but requires copying all elements on resize.',
    ),
    optimized: Solution(
      steps: [
        'Use growth factor of 1.5-2x',
        'Add bounds checking',
        'Shrink when size < capacity/4',
        'Amortized O(1) append via doubling',
      ],
      timeComplexity: 'O(1) amortized append, O(n) insert/delete',
      spaceComplexity: 'O(n)',
      code: '''class DynamicArray:
    def __init__(self, capacity=10):
        self.capacity = capacity
        self.size = 0
        self.arr = [None] * capacity

    def append(self, value):
        if self.size == self.capacity:
            self._resize(2 * self.capacity)
        self.arr[self.size] = value
        self.size += 1

    def insert(self, index, value):
        if index > self.size:
            raise IndexError()
        if self.size == self.capacity:
            self._resize(2 * self.capacity)
        for i in range(self.size, index, -1):
            self.arr[i] = self.arr[i-1]
        self.arr[index] = value
        self.size += 1

    def delete(self, index):
        if index >= self.size:
            raise IndexError()
        for i in range(index, self.size - 1):
            self.arr[i] = self.arr[i+1]
        self.size -= 1
        if self.size < self.capacity // 4:
            self._resize(self.capacity // 2)

    def _resize(self, new_capacity):
        new_arr = [None] * new_capacity
        for i in range(self.size):
            new_arr[i] = self.arr[i]
        self.arr = new_arr
        self.capacity = new_capacity''',
      explanation:
          'Optimized with proper resizing strategy. Shrinks when usage < 25% to save memory. Amortized O(1) append through doubling. Handles edge cases properly.',
    ),
  ),

  // Question 2: Stack
  LeetCodeQuestion(
    id: 1002,
    title: 'Implement Stack',
    difficulty: Difficulty.easy,
    category: 'Stacks',
    question:
        'Implement a stack data structure with operations:\n'
        '• push(value): Add to top\n'
        '• pop(): Remove and return top\n'
        '• peek(): Return top without removing\n'
        '• is_empty(): Check if empty\n'
        '• size(): Return number of elements',
    bruteForce: Solution(
      steps: [
        'Use fixed-size array with capacity limit',
        'Track top pointer (-1 when empty)',
        'Push increments top and adds element',
        'Pop decrements top and returns element',
        'Check overflow and underflow',
      ],
      timeComplexity: 'O(1) for all operations',
      spaceComplexity: 'O(n)',
      code: '''class Stack:
    def __init__(self, max_size=100):
        self.max_size = max_size
        self.arr = [None] * max_size
        self.top = -1

    def push(self, value):
        if self.top >= self.max_size - 1:
            raise OverflowError("Stack is full")
        self.top += 1
        self.arr[self.top] = value

    def pop(self):
        if self.is_empty():
            raise IndexError("Stack is empty")
        value = self.arr[self.top]
        self.top -= 1
        return value

    def peek(self):
        if self.is_empty():
            raise IndexError("Stack is empty")
        return self.arr[self.top]

    def is_empty(self):
        return self.top == -1

    def size(self):
        return self.top + 1''',
      explanation:
          'Array-based with fixed size. O(1) operations but limited capacity. Simple implementation with overflow protection.',
    ),
    optimized: Solution(
      steps: [
        'Use Python list with dynamic resizing',
        'Push uses append() for O(1) amortized',
        'Pop uses pop() for O(1)',
        'No size limit',
        'Can also use collections.deque',
      ],
      timeComplexity: 'O(1) amortized for all operations',
      spaceComplexity: 'O(n)',
      code: '''class Stack:
    def __init__(self):
        self.items = []

    def push(self, value):
        self.items.append(value)

    def pop(self):
        if self.is_empty():
            raise IndexError("Stack is empty")
        return self.items.pop()

    def peek(self):
        if self.is_empty():
            raise IndexError("Stack is empty")
        return self.items[-1]

    def is_empty(self):
        return len(self.items) == 0

    def size(self):
        return len(self.items)

# Alternative: Using deque
from collections import deque

class StackDeque:
    def __init__(self):
        self.items = deque()

    def push(self, value):
        self.items.append(value)

    def pop(self):
        if not self.items:
            raise IndexError("Stack is empty")
        return self.items.pop()''',
      explanation:
          'Pythonic using built-in list with automatic resizing. Collections.deque provides O(1) operations from both ends. More efficient and flexible than fixed array.',
    ),
  ),

  // Question 3: Queue
  LeetCodeQuestion(
    id: 1003,
    title: 'Implement Queue',
    difficulty: Difficulty.easy,
    category: 'Queues',
    question:
        'Implement a queue with operations:\n'
        '• enqueue(value): Add to rear\n'
        '• dequeue(): Remove and return front\n'
        '• peek(): Return front without removing\n'
        '• is_empty(): Check if empty\n'
        '• size(): Return number of elements',
    bruteForce: Solution(
      steps: [
        'Use array with shifting',
        'Enqueue adds to end',
        'Dequeue removes from front and shifts all left',
        'Simple but inefficient shifting',
      ],
      timeComplexity: 'O(1) enqueue, O(n) dequeue',
      spaceComplexity: 'O(n)',
      code: '''class Queue:
    def __init__(self):
        self.items = []

    def enqueue(self, value):
        self.items.append(value)

    def dequeue(self):
        if self.is_empty():
            raise IndexError("Queue is empty")
        return self.items.pop(0)  # O(n) operation

    def peek(self):
        if self.is_empty():
            raise IndexError("Queue is empty")
        return self.items[0]

    def is_empty(self):
        return len(self.items) == 0

    def size(self):
        return len(self.items)''',
      explanation:
          'Inefficient due to O(n) dequeue requiring shifting. Fine for small queues but not scalable.',
    ),
    optimized: Solution(
      steps: [
        'Use collections.deque for O(1) at both ends',
        'Enqueue with append()',
        'Dequeue with popleft()',
        'Optimized for queue operations',
      ],
      timeComplexity: 'O(1) for all operations',
      spaceComplexity: 'O(n)',
      code: '''from collections import deque

class Queue:
    def __init__(self):
        self.items = deque()

    def enqueue(self, value):
        self.items.append(value)

    def dequeue(self):
        if self.is_empty():
            raise IndexError("Queue is empty")
        return self.items.popleft()  # O(1)

    def peek(self):
        if self.is_empty():
            raise IndexError("Queue is empty")
        return self.items[0]

    def is_empty(self):
        return len(self.items) == 0

    def size(self):
        return len(self.items)

# Circular queue alternative
class CircularQueue:
    def __init__(self, capacity=10):
        self.capacity = capacity
        self.items = [None] * capacity
        self.front = 0
        self.rear = 0
        self.count = 0

    def enqueue(self, value):
        if self.count == self.capacity:
            raise OverflowError("Queue is full")
        self.items[self.rear] = value
        self.rear = (self.rear + 1) % self.capacity
        self.count += 1

    def dequeue(self):
        if self.is_empty():
            raise IndexError("Queue is empty")
        value = self.items[self.front]
        self.front = (self.front + 1) % self.capacity
        self.count -= 1
        return value''',
      explanation:
          'Collections.deque is optimal - O(1) operations at both ends. Circular queue shows classic implementation with modulo arithmetic for wraparound.',
    ),
  ),

  // Question 4: Linked List
  LeetCodeQuestion(
    id: 1004,
    title: 'Implement Singly Linked List',
    difficulty: Difficulty.medium,
    category: 'Linked Lists',
    question:
        'Implement a singly linked list with operations:\n'
        '• append(value): Add to end\n'
        '• prepend(value): Add to beginning\n'
        '• insert_after(node, value): Insert after node\n'
        '• delete(value): Remove first occurrence\n'
        '• search(value): Find node',
    bruteForce: Solution(
      steps: [
        'Create Node with data and next pointer',
        'LinkedList with head pointer',
        'Traverse from head for all operations',
        'Update pointers for insert/delete',
      ],
      timeComplexity: 'O(1) prepend, O(n) for others',
      spaceComplexity: 'O(1) per operation',
      code: '''class Node:
    def __init__(self, data):
        self.data = data
        self.next = None

class LinkedList:
    def __init__(self):
        self.head = None

    def append(self, data):
        new_node = Node(data)
        if not self.head:
            self.head = new_node
            return

        current = self.head
        while current.next:
            current = current.next
        current.next = new_node

    def prepend(self, data):
        new_node = Node(data)
        new_node.next = self.head
        self.head = new_node

    def delete(self, value):
        if not self.head:
            return
        if self.head.data == value:
            self.head = self.head.next
            return

        current = self.head
        while current.next:
            if current.next.data == value:
                current.next = current.next.next
                return
            current = current.next''',
      explanation:
          'Basic implementation. Append is O(n) as it must traverse to end. Good for learning fundamentals.',
    ),
    optimized: Solution(
      steps: [
        'Add tail pointer for O(1) append',
        'Maintain size counter',
        'Update tail on append',
        'Handle edge cases properly',
      ],
      timeComplexity: 'O(1) append/prepend, O(n) search/delete',
      spaceComplexity: 'O(1) per operation',
      code: '''class Node:
    def __init__(self, data):
        self.data = data
        self.next = None

class LinkedList:
    def __init__(self):
        self.head = None
        self.tail = None
        self.size = 0

    def append(self, data):
        new_node = Node(data)
        if not self.head:
            self.head = self.tail = new_node
        else:
            self.tail.next = new_node
            self.tail = new_node
        self.size += 1

    def prepend(self, data):
        new_node = Node(data)
        if not self.head:
            self.head = self.tail = new_node
        else:
            new_node.next = self.head
            self.head = new_node
        self.size += 1

    def insert_after(self, node, data):
        if not node:
            return
        new_node = Node(data)
        new_node.next = node.next
        node.next = new_node
        if node == self.tail:
            self.tail = new_node
        self.size += 1

    def delete(self, value):
        if not self.head:
            return False
        if self.head.data == value:
            self.head = self.head.next
            if not self.head:
                self.tail = None
            self.size -= 1
            return True

        current = self.head
        while current.next:
            if current.next.data == value:
                if current.next == self.tail:
                    self.tail = current
                current.next = current.next.next
                self.size -= 1
                return True
            current = current.next
        return False''',
      explanation:
          'Optimized with tail pointer for O(1) append. Size counter for instant length. Proper edge case handling makes it production-ready.',
    ),
  ),

  // Question 5: Binary Search Tree
  LeetCodeQuestion(
    id: 1005,
    title: 'Implement Binary Search Tree',
    difficulty: Difficulty.medium,
    category: 'Trees',
    question:
        'Implement a BST with operations:\n'
        '• insert(value): Add maintaining BST property\n'
        '• search(value): Find if exists\n'
        '• delete(value): Remove maintaining BST\n'
        '• inorder(): Return sorted values\n'
        'BST: left < node < right',
    bruteForce: Solution(
      steps: [
        'Create TreeNode with value, left, right',
        'Recursive insert to find position',
        'Recursive search left or right',
        'Delete handles 0, 1, 2 children cases',
      ],
      timeComplexity: 'O(h) where h=height, O(n) worst',
      spaceComplexity: 'O(h) recursion stack',
      code: '''class TreeNode:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

class BST:
    def __init__(self):
        self.root = None

    def insert(self, value):
        if not self.root:
            self.root = TreeNode(value)
        else:
            self._insert_recursive(self.root, value)

    def _insert_recursive(self, node, value):
        if value < node.value:
            if node.left is None:
                node.left = TreeNode(value)
            else:
                self._insert_recursive(node.left, value)
        else:
            if node.right is None:
                node.right = TreeNode(value)
            else:
                self._insert_recursive(node.right, value)

    def search(self, value):
        return self._search_recursive(self.root, value)

    def _search_recursive(self, node, value):
        if node is None:
            return False
        if node.value == value:
            return True
        if value < node.value:
            return self._search_recursive(node.left, value)
        return self._search_recursive(node.right, value)''',
      explanation:
          'Recursive implementation follows BST properties naturally. Elegant but can overflow stack for deep trees.',
    ),
    optimized: Solution(
      steps: [
        'Use iterative for insert/search',
        'Helper to find minimum',
        'Delete with inorder successor',
        'Handles all 3 delete cases',
      ],
      timeComplexity: 'O(h) avg, O(log n) balanced',
      spaceComplexity: 'O(1) for iterative',
      code: '''class TreeNode:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

class BST:
    def __init__(self):
        self.root = None

    def insert(self, value):
        if not self.root:
            self.root = TreeNode(value)
            return

        current = self.root
        while True:
            if value < current.value:
                if current.left is None:
                    current.left = TreeNode(value)
                    break
                current = current.left
            else:
                if current.right is None:
                    current.right = TreeNode(value)
                    break
                current = current.right

    def search(self, value):
        current = self.root
        while current:
            if current.value == value:
                return True
            elif value < current.value:
                current = current.left
            else:
                current = current.right
        return False

    def delete(self, value):
        self.root = self._delete_recursive(self.root, value)

    def _delete_recursive(self, node, value):
        if not node:
            return None
        if value < node.value:
            node.left = self._delete_recursive(node.left, value)
        elif value > node.value:
            node.right = self._delete_recursive(node.right, value)
        else:
            # Leaf or one child
            if not node.left:
                return node.right
            if not node.right:
                return node.left
            # Two children: find inorder successor
            min_node = self._find_min(node.right)
            node.value = min_node.value
            node.right = self._delete_recursive(node.right, min_node.value)
        return node

    def _find_min(self, node):
        while node.left:
            node = node.left
        return node''',
      explanation:
          'Combines iterative (insert/search) and recursive (delete). Avoids stack issues while keeping delete logic clean. Uses inorder successor for two-child deletion.',
    ),
  ),

  // Question 6: Min Heap
  LeetCodeQuestion(
    id: 1006,
    title: 'Implement Min Heap',
    difficulty: Difficulty.medium,
    category: 'Heaps',
    question:
        'Implement a Min Heap (priority queue) with operations:\n'
        '• insert(value): Add element maintaining heap property\n'
        '• extract_min(): Remove and return minimum\n'
        '• peek(): Return minimum without removing\n'
        '• heapify(array): Build heap from array\n'
        'Min Heap: parent ≤ children',
    bruteForce: Solution(
      steps: [
        'Use sorted array',
        'Extract_min pops first element O(1)',
        'Insert finds position and shifts O(n)',
        'Simple but inefficient for insertions',
      ],
      timeComplexity: 'O(n) insert, O(1) extract_min',
      spaceComplexity: 'O(n)',
      code: '''class MinHeapSorted:
    def __init__(self):
        self.heap = []

    def insert(self, value):
        if not self.heap:
            self.heap.append(value)
        else:
            # Insert in sorted position
            inserted = False
            for i in range(len(self.heap)):
                if value < self.heap[i]:
                    self.heap.insert(i, value)
                    inserted = True
                    break
            if not inserted:
                self.heap.append(value)

    def extract_min(self):
        if not self.heap:
            raise IndexError("Heap is empty")
        return self.heap.pop(0)

    def peek(self):
        if not self.heap:
            raise IndexError("Heap is empty")
        return self.heap[0]''',
      explanation:
          'Maintains sorted order for easy minimum access. Inefficient O(n) insertions due to shifting elements.',
    ),
    optimized: Solution(
      steps: [
        'Store as array: parent at i, children at 2i+1, 2i+2',
        'Insert: add to end, bubble up (heapify up)',
        'Extract: swap with last, remove, bubble down',
        'Heapify: O(n) bottom-up construction',
      ],
      timeComplexity: 'O(log n) insert/extract, O(n) heapify',
      spaceComplexity: 'O(n)',
      code: '''class MinHeap:
    def __init__(self):
        self.heap = []

    def parent(self, i):
        return (i - 1) // 2

    def left_child(self, i):
        return 2 * i + 1

    def right_child(self, i):
        return 2 * i + 2

    def insert(self, value):
        self.heap.append(value)
        self._heapify_up(len(self.heap) - 1)

    def _heapify_up(self, i):
        parent = self.parent(i)
        if i > 0 and self.heap[i] < self.heap[parent]:
            self.heap[i], self.heap[parent] = self.heap[parent], self.heap[i]
            self._heapify_up(parent)

    def extract_min(self):
        if not self.heap:
            raise IndexError("Heap is empty")
        if len(self.heap) == 1:
            return self.heap.pop()

        min_val = self.heap[0]
        self.heap[0] = self.heap.pop()
        self._heapify_down(0)
        return min_val

    def _heapify_down(self, i):
        min_index = i
        left = self.left_child(i)
        right = self.right_child(i)

        if left < len(self.heap) and self.heap[left] < self.heap[min_index]:
            min_index = left
        if right < len(self.heap) and self.heap[right] < self.heap[min_index]:
            min_index = right

        if min_index != i:
            self.heap[i], self.heap[min_index] = self.heap[min_index], self.heap[i]
            self._heapify_down(min_index)

    def peek(self):
        if not self.heap:
            raise IndexError("Heap is empty")
        return self.heap[0]

# Using Python's heapq
import heapq

class MinHeapPythonic:
    def __init__(self):
        self.heap = []

    def insert(self, value):
        heapq.heappush(self.heap, value)

    def extract_min(self):
        return heapq.heappop(self.heap)

    def peek(self):
        return self.heap[0]''',
      explanation:
          'Binary heap using array. Parent-child via index arithmetic. O(log n) operations through heapify. Python heapq module is C-optimized.',
    ),
  ),

  // Question 7: Graph (Adjacency List)
  LeetCodeQuestion(
    id: 1007,
    title: 'Implement Graph',
    difficulty: Difficulty.medium,
    category: 'Graphs',
    question:
        'Implement a graph using adjacency list with operations:\n'
        '• add_vertex(v): Add new vertex\n'
        '• add_edge(v1, v2): Add edge\n'
        '• remove_edge(v1, v2): Remove edge\n'
        '• remove_vertex(v): Remove vertex and edges\n'
        '• get_neighbors(v): Return adjacent vertices\n'
        'Support directed and undirected graphs',
    bruteForce: Solution(
      steps: [
        'Use V×V adjacency matrix',
        'matrix[i][j] = 1 if edge exists',
        'Simple but wastes O(V²) space',
        'Adding vertex requires resizing matrix',
      ],
      timeComplexity: 'O(1) add/remove edge, O(V²) add vertex',
      spaceComplexity: 'O(V²)',
      code: '''class GraphMatrix:
    def __init__(self, num_vertices):
        self.V = num_vertices
        self.matrix = [[0] * num_vertices for _ in range(num_vertices)]

    def add_edge(self, v1, v2, directed=False):
        if v1 >= self.V or v2 >= self.V:
            return False
        self.matrix[v1][v2] = 1
        if not directed:
            self.matrix[v2][v1] = 1
        return True

    def remove_edge(self, v1, v2, directed=False):
        if v1 >= self.V or v2 >= self.V:
            return False
        self.matrix[v1][v2] = 0
        if not directed:
            self.matrix[v2][v1] = 0
        return True

    def get_neighbors(self, vertex):
        if vertex >= self.V:
            return []
        return [i for i in range(self.V) if self.matrix[vertex][i] == 1]''',
      explanation:
          'Matrix allows O(1) edge operations but wastes O(V²) space for sparse graphs. Adding vertices is expensive.',
    ),
    optimized: Solution(
      steps: [
        'Use dict where key=vertex, value=set of neighbors',
        'Set provides O(1) edge add/remove',
        'Dynamic - easy to add vertices',
        'Space efficient for sparse graphs',
      ],
      timeComplexity: 'O(1) avg for operations, O(degree) for neighbors',
      spaceComplexity: 'O(V + E)',
      code: '''class Graph:
    def __init__(self, directed=False):
        self.graph = {}
        self.directed = directed

    def add_vertex(self, vertex):
        if vertex not in self.graph:
            self.graph[vertex] = set()
            return True
        return False

    def add_edge(self, v1, v2):
        self.add_vertex(v1)
        self.add_vertex(v2)
        self.graph[v1].add(v2)
        if not self.directed:
            self.graph[v2].add(v1)
        return True

    def remove_edge(self, v1, v2):
        if v1 not in self.graph or v2 not in self.graph:
            return False
        self.graph[v1].discard(v2)
        if not self.directed:
            self.graph[v2].discard(v1)
        return True

    def remove_vertex(self, vertex):
        if vertex not in self.graph:
            return False
        # Remove all edges to this vertex
        for v in self.graph:
            self.graph[v].discard(vertex)
        del self.graph[vertex]
        return True

    def get_neighbors(self, vertex):
        return list(self.graph.get(vertex, set()))

    def has_edge(self, v1, v2):
        return v1 in self.graph and v2 in self.graph[v1]

# Using defaultdict
from collections import defaultdict

class GraphDefaultDict:
    def __init__(self, directed=False):
        self.graph = defaultdict(set)
        self.directed = directed

    def add_edge(self, v1, v2):
        self.graph[v1].add(v2)
        if not self.directed:
            self.graph[v2].add(v1)''',
      explanation:
          'Adjacency list with dict is optimal. O(V+E) space, efficient for sparse graphs. Set gives O(1) edge ops. DefaultDict auto-creates vertices.',
    ),
  ),

  // Question 8: Trie (Prefix Tree)
  LeetCodeQuestion(
    id: 1008,
    title: 'Implement Trie',
    difficulty: Difficulty.medium,
    category: 'Tries',
    question:
        'Implement a Trie (prefix tree) with operations:\n'
        '• insert(word): Insert word\n'
        '• search(word): Return true if word exists\n'
        '• starts_with(prefix): Return true if prefix exists\n'
        'Example: After insert("apple"), search("apple")=true, '
        'starts_with("app")=true, search("app")=false',
    bruteForce: Solution(
      steps: [
        'Store all words in a list',
        'Insert is O(1) append',
        'Search checks all words O(n*m)',
        'Prefix search checks all words for startswith',
      ],
      timeComplexity: 'O(1) insert, O(n*m) search/prefix',
      spaceComplexity: 'O(total chars)',
      code: '''class TrieList:
    def __init__(self):
        self.words = []

    def insert(self, word):
        if word not in self.words:
            self.words.append(word)

    def search(self, word):
        return word in self.words

    def starts_with(self, prefix):
        for word in self.words:
            if word.startswith(prefix):
                return True
        return False''',
      explanation:
          'Simple but inefficient. Must check all words for search/prefix. No benefit from common prefixes.',
    ),
    optimized: Solution(
      steps: [
        'TrieNode with children dict and is_end flag',
        'Insert: traverse/create nodes per character',
        'Search: traverse nodes, check is_end',
        'Starts_with: traverse nodes, no end check needed',
      ],
      timeComplexity: 'O(m) all operations (m = word length)',
      spaceComplexity: 'O(total chars * alphabet size)',
      code: '''class TrieNode:
    def __init__(self):
        self.children = {}
        self.is_end_of_word = False

class Trie:
    def __init__(self):
        self.root = TrieNode()

    def insert(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
        node.is_end_of_word = True

    def search(self, word):
        node = self._find_node(word)
        return node is not None and node.is_end_of_word

    def starts_with(self, prefix):
        return self._find_node(prefix) is not None

    def _find_node(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                return None
            node = node.children[char]
        return node

    def delete(self, word):
        def _delete_recursive(node, word, index):
            if index == len(word):
                if not node.is_end_of_word:
                    return False
                node.is_end_of_word = False
                return len(node.children) == 0

            char = word[index]
            if char not in node.children:
                return False

            should_delete = _delete_recursive(node.children[char], word, index + 1)
            if should_delete:
                del node.children[char]
                return len(node.children) == 0 and not node.is_end_of_word
            return False

        _delete_recursive(self.root, word, 0)

    def autocomplete(self, prefix):
        node = self._find_node(prefix)
        if not node:
            return []

        suggestions = []
        def dfs(node, current):
            if node.is_end_of_word:
                suggestions.append(prefix + current)
            for char, child in node.children.items():
                dfs(child, current + char)

        dfs(node, "")
        return suggestions''',
      explanation:
          'Optimal Trie with O(m) operations. Perfect for prefix queries, autocomplete, spell check. Space-time tradeoff worth it. Includes delete and autocomplete.',
    ),
  ),

  // Question 9: Hash Map
  LeetCodeQuestion(
    id: 1009,
    title: 'Implement Hash Map',
    difficulty: Difficulty.medium,
    category: 'Hash Tables',
    question:
        'Implement a hash map from scratch with operations:\n'
        '• put(key, value): Insert or update\n'
        '• get(key): Return value or None\n'
        '• remove(key): Delete key-value pair\n'
        'Handle collisions using separate chaining (linked list per bucket)',
    bruteForce: Solution(
      steps: [
        'Store (key, value) pairs in array',
        'Put: linear search for key, update or append',
        'Get: linear search for key',
        'Remove: linear search and delete',
      ],
      timeComplexity: 'O(n) for all operations',
      spaceComplexity: 'O(n)',
      code: '''class HashMapLinear:
    def __init__(self):
        self.data = []

    def put(self, key, value):
        for i, (k, v) in enumerate(self.data):
            if k == key:
                self.data[i] = (key, value)
                return
        self.data.append((key, value))

    def get(self, key):
        for k, v in self.data:
            if k == key:
                return v
        return None

    def remove(self, key):
        for i, (k, v) in enumerate(self.data):
            if k == key:
                self.data.pop(i)
                return True
        return False''',
      explanation:
          'Simplest approach with linear search. No hashing. Inefficient for large datasets but easy to understand.',
    ),
    optimized: Solution(
      steps: [
        'Array of buckets (size 16)',
        'Hash function: key -> bucket via modulo',
        'Each bucket is list of (key, value) pairs',
        'Resize when load factor > 0.75',
        'Separate chaining for collisions',
      ],
      timeComplexity: 'O(1) average, O(n) worst',
      spaceComplexity: 'O(n)',
      code: '''class HashMap:
    def __init__(self, capacity=16):
        self.capacity = capacity
        self.size = 0
        self.buckets = [[] for _ in range(capacity)]
        self.load_factor_threshold = 0.75

    def _hash(self, key):
        return hash(key) % self.capacity

    def put(self, key, value):
        index = self._hash(key)
        bucket = self.buckets[index]

        # Update if exists
        for i, (k, v) in enumerate(bucket):
            if k == key:
                bucket[i] = (key, value)
                return

        # Add new
        bucket.append((key, value))
        self.size += 1

        # Resize if needed
        if self.size / self.capacity > self.load_factor_threshold:
            self._resize()

    def get(self, key):
        index = self._hash(key)
        bucket = self.buckets[index]
        for k, v in bucket:
            if k == key:
                return v
        return None

    def remove(self, key):
        index = self._hash(key)
        bucket = self.buckets[index]
        for i, (k, v) in enumerate(bucket):
            if k == key:
                bucket.pop(i)
                self.size -= 1
                return True
        return False

    def _resize(self):
        old_buckets = self.buckets
        self.capacity *= 2
        self.buckets = [[] for _ in range(self.capacity)]
        self.size = 0
        for bucket in old_buckets:
            for key, value in bucket:
                self.put(key, value)

    def keys(self):
        result = []
        for bucket in self.buckets:
            for key, value in bucket:
                result.append(key)
        return result

    def values(self):
        result = []
        for bucket in self.buckets:
            for key, value in bucket:
                result.append(value)
        return result''',
      explanation:
          'Production hash map with separate chaining. Dynamic resizing maintains O(1) average. Load factor prevents degradation. Rehashing on resize.',
    ),
  ),

  // Question 10: Doubly Linked List
  LeetCodeQuestion(
    id: 1010,
    title: 'Implement Doubly Linked List',
    difficulty: Difficulty.medium,
    category: 'Linked Lists',
    question:
        'Implement a doubly linked list with operations:\n'
        '• append(value): Add to end\n'
        '• prepend(value): Add to beginning\n'
        '• insert_after(node, value): Insert after node\n'
        '• delete(value): Remove first occurrence\n'
        '• reverse(): Reverse the list\n'
        'Each node has prev and next pointers',
    bruteForce: Solution(
      steps: [
        'Node with data, next, prev pointers',
        'Track head only',
        'Traverse to end for append',
        'Manual pointer updates for insert/delete',
      ],
      timeComplexity: 'O(1) prepend, O(n) append/delete',
      spaceComplexity: 'O(1) per operation',
      code: '''class Node:
    def __init__(self, data):
        self.data = data
        self.next = None
        self.prev = None

class DoublyLinkedList:
    def __init__(self):
        self.head = None

    def append(self, data):
        new_node = Node(data)
        if not self.head:
            self.head = new_node
            return

        current = self.head
        while current.next:
            current = current.next
        current.next = new_node
        new_node.prev = current

    def prepend(self, data):
        new_node = Node(data)
        if self.head:
            self.head.prev = new_node
            new_node.next = self.head
        self.head = new_node

    def delete(self, value):
        current = self.head
        while current:
            if current.data == value:
                if current.prev:
                    current.prev.next = current.next
                else:
                    self.head = current.next

                if current.next:
                    current.next.prev = current.prev
                return True
            current = current.next
        return False''',
      explanation:
          'Basic doubly linked list. Append is O(n) as it traverses to end. Bidirectional traversal enabled by prev pointers.',
    ),
    optimized: Solution(
      steps: [
        'Add tail pointer for O(1) append',
        'Maintain size counter',
        'Sentinel nodes (dummy head/tail) simplify edge cases',
        'Reverse swaps prev and next for all nodes',
      ],
      timeComplexity: 'O(1) append/prepend, O(n) delete/reverse',
      spaceComplexity: 'O(1) per operation',
      code: '''class Node:
    def __init__(self, data):
        self.data = data
        self.next = None
        self.prev = None

class DoublyLinkedList:
    def __init__(self):
        self.head = None
        self.tail = None
        self.size = 0

    def append(self, data):
        new_node = Node(data)
        if not self.head:
            self.head = self.tail = new_node
        else:
            new_node.prev = self.tail
            self.tail.next = new_node
            self.tail = new_node
        self.size += 1

    def prepend(self, data):
        new_node = Node(data)
        if not self.head:
            self.head = self.tail = new_node
        else:
            new_node.next = self.head
            self.head.prev = new_node
            self.head = new_node
        self.size += 1

    def insert_after(self, node, data):
        if not node:
            return
        new_node = Node(data)
        new_node.prev = node
        new_node.next = node.next

        if node.next:
            node.next.prev = new_node
        else:
            self.tail = new_node

        node.next = new_node
        self.size += 1

    def delete(self, value):
        current = self.head
        while current:
            if current.data == value:
                if current.prev:
                    current.prev.next = current.next
                else:
                    self.head = current.next

                if current.next:
                    current.next.prev = current.prev
                else:
                    self.tail = current.prev

                self.size -= 1
                return True
            current = current.next
        return False

    def reverse(self):
        current = self.head
        self.head, self.tail = self.tail, self.head

        while current:
            current.prev, current.next = current.next, current.prev
            current = current.prev  # Move to next (which is now prev)

    def get_size(self):
        return self.size

    def traverse_forward(self):
        result = []
        current = self.head
        while current:
            result.append(current.data)
            current = current.next
        return result

    def traverse_backward(self):
        result = []
        current = self.tail
        while current:
            result.append(current.data)
            current = current.prev
        return result''',
      explanation:
          'Optimized with tail pointer for O(1) append. Bidirectional traversal. Reverse swaps pointers. Size tracking for instant length. Used in LRU cache implementation.',
    ),
  ),

  // Question 11: Union-Find (Disjoint Set)
  LeetCodeQuestion(
    id: 1011,
    title: 'Implement Union-Find',
    difficulty: Difficulty.medium,
    category: 'Union-Find',
    question:
        'Implement Union-Find (Disjoint Set Union) with operations:\n'
        '• find(x): Find set representative of x\n'
        '• union(x, y): Merge sets containing x and y\n'
        '• connected(x, y): Check if x and y are in same set\n'
        'Used for: detecting cycles, connected components, Kruskal\'s MST',
    bruteForce: Solution(
      steps: [
        'Use array where parent[i] = parent of i',
        'Find: follow parent pointers to root',
        'Union: set parent of one root to other',
        'Simple but creates tall trees O(n) worst case',
      ],
      timeComplexity: 'O(n) for find/union in worst case',
      spaceComplexity: 'O(n)',
      code: '''class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))

    def find(self, x):
        # Follow parent pointers to root
        while self.parent[x] != x:
            x = self.parent[x]
        return x

    def union(self, x, y):
        root_x = self.find(x)
        root_y = self.find(y)
        if root_x != root_y:
            self.parent[root_x] = root_y

    def connected(self, x, y):
        return self.find(x) == self.find(y)''',
      explanation:
          'Basic implementation without optimizations. Can create tall trees leading to O(n) operations. Works but inefficient for large datasets.',
    ),
    optimized: Solution(
      steps: [
        'Union by Rank: attach smaller tree to larger',
        'Path Compression: flatten tree during find',
        'Both optimizations give nearly O(1) amortized',
        'Inverse Ackermann function α(n) is practically constant',
      ],
      timeComplexity: 'O(α(n)) amortized (nearly O(1))',
      spaceComplexity: 'O(n)',
      code: '''class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0] * n
        self.count = n  # Number of connected components

    def find(self, x):
        # Path compression: make all nodes point to root
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        root_x = self.find(x)
        root_y = self.find(y)

        if root_x == root_y:
            return False

        # Union by rank: attach smaller to larger
        if self.rank[root_x] < self.rank[root_y]:
            self.parent[root_x] = root_y
        elif self.rank[root_x] > self.rank[root_y]:
            self.parent[root_y] = root_x
        else:
            self.parent[root_y] = root_x
            self.rank[root_x] += 1

        self.count -= 1
        return True

    def connected(self, x, y):
        return self.find(x) == self.find(y)

    def get_components(self):
        return self.count

# Alternative: Union by Size
class UnionFindSize:
    def __init__(self, n):
        self.parent = list(range(n))
        self.size = [1] * n

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        root_x, root_y = self.find(x), self.find(y)
        if root_x == root_y:
            return False

        # Attach smaller to larger by size
        if self.size[root_x] < self.size[root_y]:
            self.parent[root_x] = root_y
            self.size[root_y] += self.size[root_x]
        else:
            self.parent[root_y] = root_x
            self.size[root_x] += self.size[root_y]
        return True''',
      explanation:
          'Optimized with path compression and union by rank. Nearly O(1) operations. Essential for graph problems: cycle detection, MST, connected components. Union by size is alternative to rank.',
    ),
  ),

  // Question 12: Segment Tree
  LeetCodeQuestion(
    id: 1012,
    title: 'Implement Segment Tree',
    difficulty: Difficulty.hard,
    category: 'Trees',
    question:
        'Implement a Segment Tree for range queries:\n'
        '• build(arr): Build tree from array\n'
        '• query(left, right): Get sum/min/max in range\n'
        '• update(index, value): Update single element\n'
        'Used for: range sum/min/max queries with updates',
    bruteForce: Solution(
      steps: [
        'Store array and compute range on each query',
        'Query: iterate through range and sum',
        'Update: change single element O(1)',
        'Simple but query is O(n)',
      ],
      timeComplexity: 'O(n) query, O(1) update',
      spaceComplexity: 'O(n)',
      code: '''class RangeQuery:
    def __init__(self, arr):
        self.arr = arr[:]

    def query(self, left, right):
        # Sum elements in range [left, right]
        return sum(self.arr[left:right+1])

    def update(self, index, value):
        self.arr[index] = value

# Prefix sum for faster queries but slow updates
class PrefixSum:
    def __init__(self, arr):
        self.n = len(arr)
        self.prefix = [0] * (self.n + 1)
        for i in range(self.n):
            self.prefix[i+1] = self.prefix[i] + arr[i]

    def query(self, left, right):
        return self.prefix[right+1] - self.prefix[left]

    def update(self, index, value):
        # Need to rebuild prefix array - O(n)
        diff = value - (self.prefix[index+1] - self.prefix[index])
        for i in range(index+1, len(self.prefix)):
            self.prefix[i] += diff''',
      explanation:
          'Naive approach with O(n) queries. Prefix sum improves query to O(1) but update becomes O(n). Not suitable when both operations needed.',
    ),
    optimized: Solution(
      steps: [
        'Build tree: each node stores range aggregate',
        'Tree stored in array: node i has children at 2i+1, 2i+2',
        'Query: combine relevant segments in O(log n)',
        'Update: propagate change up tree in O(log n)',
      ],
      timeComplexity: 'O(log n) query and update, O(n) build',
      spaceComplexity: 'O(n)',
      code: '''class SegmentTree:
    def __init__(self, arr):
        self.n = len(arr)
        # Tree array size is 4*n to be safe
        self.tree = [0] * (4 * self.n)
        self._build(arr, 0, 0, self.n - 1)

    def _build(self, arr, node, start, end):
        if start == end:
            self.tree[node] = arr[start]
        else:
            mid = (start + end) // 2
            left_child = 2 * node + 1
            right_child = 2 * node + 2

            self._build(arr, left_child, start, mid)
            self._build(arr, right_child, mid + 1, end)

            # Combine children (sum in this case)
            self.tree[node] = self.tree[left_child] + self.tree[right_child]

    def query(self, left, right):
        return self._query(0, 0, self.n - 1, left, right)

    def _query(self, node, start, end, left, right):
        # No overlap
        if right < start or left > end:
            return 0

        # Complete overlap
        if left <= start and end <= right:
            return self.tree[node]

        # Partial overlap
        mid = (start + end) // 2
        left_sum = self._query(2*node+1, start, mid, left, right)
        right_sum = self._query(2*node+2, mid+1, end, left, right)
        return left_sum + right_sum

    def update(self, index, value):
        self._update(0, 0, self.n - 1, index, value)

    def _update(self, node, start, end, index, value):
        if start == end:
            self.tree[node] = value
        else:
            mid = (start + end) // 2
            if index <= mid:
                self._update(2*node+1, start, mid, index, value)
            else:
                self._update(2*node+2, mid+1, end, index, value)

            # Update current node
            self.tree[node] = self.tree[2*node+1] + self.tree[2*node+2]

# For range minimum queries
class SegmentTreeMin:
    def __init__(self, arr):
        self.n = len(arr)
        self.tree = [float('inf')] * (4 * self.n)
        self._build(arr, 0, 0, self.n - 1)

    def _build(self, arr, node, start, end):
        if start == end:
            self.tree[node] = arr[start]
        else:
            mid = (start + end) // 2
            self._build(arr, 2*node+1, start, mid)
            self._build(arr, 2*node+2, mid+1, end)
            self.tree[node] = min(self.tree[2*node+1], self.tree[2*node+2])''',
      explanation:
          'Segment tree with O(log n) operations. Binary tree where each node represents a range. Can be adapted for sum, min, max, GCD. Essential for competitive programming.',
    ),
  ),

  // Question 13: Fenwick Tree (Binary Indexed Tree)
  LeetCodeQuestion(
    id: 1013,
    title: 'Implement Fenwick Tree',
    difficulty: Difficulty.medium,
    category: 'Trees',
    question:
        'Implement Fenwick Tree (Binary Indexed Tree) for:\n'
        '• update(index, delta): Add delta to element at index\n'
        '• prefix_sum(index): Get sum of elements [0...index]\n'
        '• range_sum(left, right): Get sum in range\n'
        'More space-efficient than segment tree for certain operations',
    bruteForce: Solution(
      steps: [
        'Maintain array and compute prefix sum each time',
        'Update is O(1), prefix_sum is O(n)',
        'Range sum via two prefix sums',
        'Simple but inefficient for queries',
      ],
      timeComplexity: 'O(1) update, O(n) prefix_sum',
      spaceComplexity: 'O(n)',
      code: '''class SimplePrefix:
    def __init__(self, n):
        self.arr = [0] * n

    def update(self, index, delta):
        self.arr[index] += delta

    def prefix_sum(self, index):
        return sum(self.arr[:index+1])

    def range_sum(self, left, right):
        return self.prefix_sum(right) - (
            self.prefix_sum(left-1) if left > 0 else 0
        )''',
      explanation:
          'Naive approach computing sum on each query. Fine for few queries but not scalable.',
    ),
    optimized: Solution(
      steps: [
        'Use BIT array where each index stores partial sum',
        'Index i responsible for range based on lowest set bit',
        'Update: propagate to O(log n) indices',
        'Query: sum O(log n) ranges',
        'Simpler and faster than segment tree for this use case',
      ],
      timeComplexity: 'O(log n) for update and query',
      spaceComplexity: 'O(n)',
      code: '''class FenwickTree:
    def __init__(self, n):
        self.n = n
        self.tree = [0] * (n + 1)  # 1-indexed

    def update(self, index, delta):
        # Convert to 1-indexed
        index += 1
        while index <= self.n:
            self.tree[index] += delta
            # Move to next responsible index
            index += index & (-index)

    def prefix_sum(self, index):
        # Convert to 1-indexed
        index += 1
        total = 0
        while index > 0:
            total += self.tree[index]
            # Move to parent in BIT
            index -= index & (-index)
        return total

    def range_sum(self, left, right):
        if left == 0:
            return self.prefix_sum(right)
        return self.prefix_sum(right) - self.prefix_sum(left - 1)

# 2D Fenwick Tree for matrix operations
class FenwickTree2D:
    def __init__(self, rows, cols):
        self.rows = rows
        self.cols = cols
        self.tree = [[0] * (cols + 1) for _ in range(rows + 1)]

    def update(self, row, col, delta):
        row += 1
        col += 1
        i = row
        while i <= self.rows:
            j = col
            while j <= self.cols:
                self.tree[i][j] += delta
                j += j & (-j)
            i += i & (-i)

    def query(self, row, col):
        row += 1
        col += 1
        total = 0
        i = row
        while i > 0:
            j = col
            while j > 0:
                total += self.tree[i][j]
                j -= j & (-j)
            i -= i & (-i)
        return total''',
      explanation:
          'BIT uses bit manipulation for efficient updates and queries. Simpler than segment tree. The key insight: index & (-index) isolates lowest set bit. Great for cumulative frequency tables.',
    ),
  ),

  // Question 14: AVL Tree
  LeetCodeQuestion(
    id: 1014,
    title: 'Implement AVL Tree',
    difficulty: Difficulty.hard,
    category: 'Trees',
    question:
        'Implement a self-balancing AVL tree:\n'
        '• insert(value): Add node and rebalance\n'
        '• delete(value): Remove node and rebalance\n'
        '• search(value): Find value\n'
        'AVL property: |height(left) - height(right)| ≤ 1 for all nodes',
    bruteForce: Solution(
      steps: [
        'Use regular BST without balancing',
        'Insert/delete may create skewed tree',
        'Worst case: all operations become O(n)',
        'Works but degrades to linked list',
      ],
      timeComplexity: 'O(n) worst case for all operations',
      spaceComplexity: 'O(n)',
      code: '''class TreeNode:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

class BST:
    def __init__(self):
        self.root = None

    def insert(self, value):
        self.root = self._insert(self.root, value)

    def _insert(self, node, value):
        if not node:
            return TreeNode(value)
        if value < node.value:
            node.left = self._insert(node.left, value)
        else:
            node.right = self._insert(node.right, value)
        return node

    def search(self, value):
        current = self.root
        while current:
            if current.value == value:
                return True
            elif value < current.value:
                current = current.left
            else:
                current = current.right
        return False''',
      explanation:
          'Unbalanced BST can degrade to O(n). For sorted insertions, becomes a linked list.',
    ),
    optimized: Solution(
      steps: [
        'Track height of each node',
        'After insert/delete, check balance factor',
        'Perform rotations to restore balance',
        '4 cases: LL, RR, LR, RL rotations',
        'Guarantees O(log n) height',
      ],
      timeComplexity: 'O(log n) guaranteed for all operations',
      spaceComplexity: 'O(n)',
      code: '''class AVLNode:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None
        self.height = 1

class AVLTree:
    def get_height(self, node):
        return node.height if node else 0

    def get_balance(self, node):
        return self.get_height(node.left) - self.get_height(node.right) if node else 0

    def update_height(self, node):
        node.height = 1 + max(self.get_height(node.left), self.get_height(node.right))

    def rotate_right(self, z):
        y = z.left
        T3 = y.right

        # Rotate
        y.right = z
        z.left = T3

        # Update heights
        self.update_height(z)
        self.update_height(y)
        return y

    def rotate_left(self, z):
        y = z.right
        T2 = y.left

        # Rotate
        y.left = z
        z.right = T2

        # Update heights
        self.update_height(z)
        self.update_height(y)
        return y

    def insert(self, root, value):
        # Standard BST insert
        if not root:
            return AVLNode(value)

        if value < root.value:
            root.left = self.insert(root.left, value)
        else:
            root.right = self.insert(root.right, value)

        # Update height
        self.update_height(root)

        # Get balance factor
        balance = self.get_balance(root)

        # Left Left Case
        if balance > 1 and value < root.left.value:
            return self.rotate_right(root)

        # Right Right Case
        if balance < -1 and value > root.right.value:
            return self.rotate_left(root)

        # Left Right Case
        if balance > 1 and value > root.left.value:
            root.left = self.rotate_left(root.left)
            return self.rotate_right(root)

        # Right Left Case
        if balance < -1 and value < root.right.value:
            root.right = self.rotate_right(root.right)
            return self.rotate_left(root)

        return root

    def get_min_value_node(self, node):
        current = node
        while current.left:
            current = current.left
        return current

    def delete(self, root, value):
        if not root:
            return root

        # Standard BST delete
        if value < root.value:
            root.left = self.delete(root.left, value)
        elif value > root.value:
            root.right = self.delete(root.right, value)
        else:
            if not root.left:
                return root.right
            elif not root.right:
                return root.left

            temp = self.get_min_value_node(root.right)
            root.value = temp.value
            root.right = self.delete(root.right, temp.value)

        self.update_height(root)
        balance = self.get_balance(root)

        # Rebalance (same 4 cases)
        if balance > 1 and self.get_balance(root.left) >= 0:
            return self.rotate_right(root)
        if balance > 1 and self.get_balance(root.left) < 0:
            root.left = self.rotate_left(root.left)
            return self.rotate_right(root)
        if balance < -1 and self.get_balance(root.right) <= 0:
            return self.rotate_left(root)
        if balance < -1 and self.get_balance(root.right) > 0:
            root.right = self.rotate_right(root.right)
            return self.rotate_left(root)

        return root''',
      explanation:
          'AVL tree maintains strict balance via rotations. Guarantees O(log n) height. More rotations than Red-Black trees but better search performance. Used when frequent lookups needed.',
    ),
  ),

  // Question 15: Deque (Double-ended Queue)
  LeetCodeQuestion(
    id: 1015,
    title: 'Implement Deque',
    difficulty: Difficulty.medium,
    category: 'Queues',
    question:
        'Implement a Deque (double-ended queue) with:\n'
        '• append_left(value): Add to front\n'
        '• append_right(value): Add to rear\n'
        '• pop_left(): Remove from front\n'
        '• pop_right(): Remove from rear\n'
        'O(1) operations at both ends',
    bruteForce: Solution(
      steps: [
        'Use dynamic array (Python list)',
        'append_right is O(1), pop_right is O(1)',
        'But append_left and pop_left require shifting',
        'Left operations are O(n)',
      ],
      timeComplexity: 'O(1) right ops, O(n) left ops',
      spaceComplexity: 'O(n)',
      code: '''class DequeList:
    def __init__(self):
        self.items = []

    def append_right(self, value):
        self.items.append(value)  # O(1)

    def append_left(self, value):
        self.items.insert(0, value)  # O(n) - shifts all

    def pop_right(self):
        if not self.items:
            raise IndexError("Deque is empty")
        return self.items.pop()  # O(1)

    def pop_left(self):
        if not self.items:
            raise IndexError("Deque is empty")
        return self.items.pop(0)  # O(n) - shifts all

    def peek_left(self):
        return self.items[0] if self.items else None

    def peek_right(self):
        return self.items[-1] if self.items else None''',
      explanation:
          'Using list is inefficient for left operations due to shifting. Fine for small deques but not scalable.',
    ),
    optimized: Solution(
      steps: [
        'Use circular array with front and rear pointers',
        'Or use doubly linked list for true O(1)',
        'Python collections.deque is optimized C implementation',
        'Both ends O(1) operations',
      ],
      timeComplexity: 'O(1) for all operations',
      spaceComplexity: 'O(n)',
      code: '''# Using Python's optimized deque
from collections import deque

class Deque:
    def __init__(self):
        self.items = deque()

    def append_left(self, value):
        self.items.appendleft(value)

    def append_right(self, value):
        self.items.append(value)

    def pop_left(self):
        if not self.items:
            raise IndexError("Deque is empty")
        return self.items.popleft()

    def pop_right(self):
        if not self.items:
            raise IndexError("Deque is empty")
        return self.items.pop()

# Manual implementation with circular array
class CircularDeque:
    def __init__(self, capacity=10):
        self.capacity = capacity
        self.items = [None] * capacity
        self.front = 0
        self.rear = 0
        self.size = 0

    def append_right(self, value):
        if self.size == self.capacity:
            self._resize()
        self.items[self.rear] = value
        self.rear = (self.rear + 1) % self.capacity
        self.size += 1

    def append_left(self, value):
        if self.size == self.capacity:
            self._resize()
        self.front = (self.front - 1) % self.capacity
        self.items[self.front] = value
        self.size += 1

    def pop_right(self):
        if self.size == 0:
            raise IndexError("Deque is empty")
        self.rear = (self.rear - 1) % self.capacity
        value = self.items[self.rear]
        self.size -= 1
        return value

    def pop_left(self):
        if self.size == 0:
            raise IndexError("Deque is empty")
        value = self.items[self.front]
        self.front = (self.front + 1) % self.capacity
        self.size -= 1
        return value

    def _resize(self):
        new_capacity = self.capacity * 2
        new_items = [None] * new_capacity
        for i in range(self.size):
            new_items[i] = self.items[(self.front + i) % self.capacity]
        self.items = new_items
        self.front = 0
        self.rear = self.size
        self.capacity = new_capacity

# Using doubly linked list
class Node:
    def __init__(self, value):
        self.value = value
        self.prev = None
        self.next = None

class DequeLinkedList:
    def __init__(self):
        self.head = None
        self.tail = None
        self.size = 0

    def append_left(self, value):
        node = Node(value)
        if not self.head:
            self.head = self.tail = node
        else:
            node.next = self.head
            self.head.prev = node
            self.head = node
        self.size += 1

    def append_right(self, value):
        node = Node(value)
        if not self.tail:
            self.head = self.tail = node
        else:
            node.prev = self.tail
            self.tail.next = node
            self.tail = node
        self.size += 1''',
      explanation:
          'Collections.deque is the Pythonic solution - highly optimized. Circular array and doubly linked list both achieve O(1) at both ends. Used in BFS, sliding window, palindrome checking.',
    ),
  ),

  // Question 16: Breadth-First Search (BFS)
  LeetCodeQuestion(
    id: 1016,
    title: 'Implement Breadth-First Search (BFS)',
    difficulty: Difficulty.medium,
    category: 'Graph Traversal',
    question:
        'Implement BFS (Breadth-First Search) for graph traversal.\n'
        'Given a graph and a starting node, visit all nodes level by level.\n'
        '• Use a queue to track nodes to visit\n'
        '• Mark nodes as visited to avoid cycles\n'
        '• Process nodes in the order they were discovered\n'
        '• Return the order of visited nodes\n\n'
        'Applications: Shortest path in unweighted graphs, level-order traversal, connected components.',
    bruteForce: Solution(
      steps: [
        'Create a queue and add starting node',
        'Create a visited set',
        'While queue is not empty, dequeue a node',
        'Mark it as visited and process it',
        'Add all unvisited neighbors to queue',
        'Continue until queue is empty',
      ],
      timeComplexity: 'O(V + E) where V = vertices, E = edges',
      spaceComplexity: 'O(V) for queue and visited set',
      code: '''def bfs(graph, start):
    """
    BFS traversal using list as queue (inefficient)
    """
    queue = [start]  # Using list as queue (O(n) dequeue)
    visited = set()
    result = []

    while queue:
        # Pop from front - O(n) operation
        node = queue.pop(0)

        if node in visited:
            continue

        visited.add(node)
        result.append(node)

        # Add all unvisited neighbors
        for neighbor in graph.get(node, []):
            if neighbor not in visited:
                queue.append(neighbor)

    return result

# Example usage
graph = {
    0: [1, 2],
    1: [0, 3, 4],
    2: [0, 5],
    3: [1],
    4: [1],
    5: [2]
}
print(bfs(graph, 0))  # [0, 1, 2, 3, 4, 5]''',
      explanation:
          'Basic BFS using list as queue. Works correctly but inefficient - list.pop(0) is O(n) because all elements must shift. Visits nodes level by level, guarantees shortest path in unweighted graphs.',
    ),
    optimized: Solution(
      steps: [
        'Use collections.deque for O(1) operations',
        'Add starting node to queue',
        'Use visited set to track seen nodes',
        'Dequeue from left, enqueue to right',
        'Process each node and add unvisited neighbors',
        'Optional: track level/depth information',
      ],
      timeComplexity: 'O(V + E) - visit each vertex once, check each edge once',
      spaceComplexity: 'O(V) for queue and visited set',
      code: '''from collections import deque

def bfs(graph, start):
    """
    Optimized BFS using deque for O(1) operations
    """
    queue = deque([start])
    visited = set([start])
    result = []

    while queue:
        node = queue.popleft()  # O(1) dequeue
        result.append(node)

        # Add all unvisited neighbors
        for neighbor in graph.get(node, []):
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append(neighbor)  # O(1) enqueue

    return result

def bfs_with_level(graph, start):
    """
    BFS that also tracks level/depth
    """
    queue = deque([(start, 0)])  # (node, level)
    visited = set([start])
    result = []

    while queue:
        node, level = queue.popleft()
        result.append((node, level))

        for neighbor in graph.get(node, []):
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append((neighbor, level + 1))

    return result

# Example usage
graph = {
    0: [1, 2],
    1: [0, 3, 4],
    2: [0, 5],
    3: [1],
    4: [1],
    5: [2]
}
print(bfs(graph, 0))  # [0, 1, 2, 3, 4, 5]
print(bfs_with_level(graph, 0))
# [(0, 0), (1, 1), (2, 1), (3, 2), (4, 2), (5, 2)]

# BFS for shortest path in unweighted graph
def shortest_path_bfs(graph, start, target):
    queue = deque([(start, [start])])
    visited = set([start])

    while queue:
        node, path = queue.popleft()

        if node == target:
            return path

        for neighbor in graph.get(node, []):
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append((neighbor, path + [neighbor]))

    return None  # No path found''',
      explanation:
          'Production-ready BFS using deque for O(1) enqueue/dequeue. Mark nodes as visited when adding to queue (not when processing) to avoid duplicates. Can track levels, find shortest paths, detect cycles. Used in: web crawlers, social networks (degrees of separation), maze solving, network broadcasting.',
    ),
  ),

  // Question 17: Depth-First Search (DFS)
  LeetCodeQuestion(
    id: 1017,
    title: 'Implement Depth-First Search (DFS)',
    difficulty: Difficulty.medium,
    category: 'Graph Traversal',
    question:
        'Implement DFS (Depth-First Search) for graph traversal.\n'
        'Given a graph and a starting node, explore as far as possible along each branch before backtracking.\n'
        '• Can be implemented recursively or iteratively\n'
        '• Use a stack for iterative approach\n'
        '• Mark nodes as visited to avoid cycles\n'
        '• Return the order of visited nodes\n\n'
        'Applications: Topological sort, cycle detection, pathfinding, maze solving, connected components.',
    bruteForce: Solution(
      steps: [
        'Use recursion for simple implementation',
        'Mark current node as visited',
        'Process the current node',
        'Recursively visit all unvisited neighbors',
        'No need for explicit stack (call stack used)',
      ],
      timeComplexity: 'O(V + E) where V = vertices, E = edges',
      spaceComplexity: 'O(V) for recursion stack and visited set',
      code: '''def dfs_recursive(graph, node, visited=None):
    """
    Basic recursive DFS
    """
    if visited is None:
        visited = set()

    if node in visited:
        return []

    visited.add(node)
    result = [node]

    # Visit all neighbors recursively
    for neighbor in graph.get(node, []):
        if neighbor not in visited:
            result.extend(dfs_recursive(graph, neighbor, visited))

    return result

# Example usage
graph = {
    0: [1, 2],
    1: [0, 3, 4],
    2: [0, 5],
    3: [1],
    4: [1],
    5: [2]
}
print(dfs_recursive(graph, 0))  # [0, 1, 3, 4, 2, 5]

# DFS to detect cycle in directed graph
def has_cycle_dfs(graph, node, visited, rec_stack):
    visited.add(node)
    rec_stack.add(node)

    for neighbor in graph.get(node, []):
        if neighbor not in visited:
            if has_cycle_dfs(graph, neighbor, visited, rec_stack):
                return True
        elif neighbor in rec_stack:
            return True  # Back edge found - cycle exists

    rec_stack.remove(node)
    return False''',
      explanation:
          'Simple recursive DFS. Explores deeply before backtracking. Uses call stack implicitly. Easy to understand but can cause stack overflow for deep graphs. Good for smaller graphs or when recursion is natural.',
    ),
    optimized: Solution(
      steps: [
        'Use explicit stack for iterative approach',
        'Push starting node onto stack',
        'While stack not empty, pop a node',
        'Mark as visited and process',
        'Push all unvisited neighbors onto stack',
        'Optional: use different traversal orders (preorder, postorder)',
      ],
      timeComplexity: 'O(V + E) - visit each vertex once, check each edge once',
      spaceComplexity: 'O(V) for stack and visited set',
      code: '''def dfs_iterative(graph, start):
    """
    Iterative DFS using stack - avoids recursion overhead
    """
    stack = [start]
    visited = set()
    result = []

    while stack:
        node = stack.pop()  # O(1) pop from end

        if node in visited:
            continue

        visited.add(node)
        result.append(node)

        # Add neighbors in reverse order to match recursive DFS
        for neighbor in reversed(graph.get(node, [])):
            if neighbor not in visited:
                stack.append(neighbor)

    return result

def dfs_with_path(graph, start, target):
    """
    DFS to find a path from start to target
    """
    stack = [(start, [start])]
    visited = set()

    while stack:
        node, path = stack.pop()

        if node in visited:
            continue

        visited.add(node)

        if node == target:
            return path

        for neighbor in graph.get(node, []):
            if neighbor not in visited:
                stack.append((neighbor, path + [neighbor]))

    return None  # No path found

def dfs_all_paths(graph, start, target, path=None, all_paths=None):
    """
    Find all paths from start to target using DFS
    """
    if path is None:
        path = []
    if all_paths is None:
        all_paths = []

    path = path + [start]

    if start == target:
        all_paths.append(path)
        return all_paths

    for neighbor in graph.get(start, []):
        if neighbor not in path:  # Avoid cycles
            dfs_all_paths(graph, neighbor, target, path, all_paths)

    return all_paths

# Topological sort using DFS
def topological_sort_dfs(graph):
    """
    Topological sort for DAG (Directed Acyclic Graph)
    """
    visited = set()
    stack = []

    def dfs(node):
        visited.add(node)
        for neighbor in graph.get(node, []):
            if neighbor not in visited:
                dfs(neighbor)
        stack.append(node)  # Add to stack after visiting all descendants

    # Visit all nodes
    for node in graph:
        if node not in visited:
            dfs(node)

    return stack[::-1]  # Reverse to get topological order

# Example usage
graph = {
    0: [1, 2],
    1: [0, 3, 4],
    2: [0, 5],
    3: [1],
    4: [1],
    5: [2]
}
print(dfs_iterative(graph, 0))  # [0, 1, 3, 4, 2, 5]
print(dfs_with_path(graph, 0, 5))  # [0, 1, 3] or [0, 2, 5]

# DAG for topological sort
dag = {
    0: [1, 2],
    1: [3],
    2: [3],
    3: [4],
    4: []
}
print(topological_sort_dfs(dag))  # [0, 2, 1, 3, 4]''',
      explanation:
          'Production-ready DFS with both iterative and recursive approaches. Iterative version avoids stack overflow for deep graphs. Includes path finding, all paths enumeration, and topological sort. Used in: maze solving, puzzle games, dependency resolution, detecting cycles, finding strongly connected components (Tarjan/Kosaraju), backtracking algorithms.',
    ),
  ),
];
