import '../leetcode_question.dart';

// NeetCode 150 - Tries Category
// 3 questions with complete solutions

final List<LeetCodeQuestion> triesQuestions = [

  LeetCodeQuestion(
    id: 208,
    title: "Implement Trie (Prefix Tree)",
    difficulty: Difficulty.medium,
    category: "Tries",
    question: """A trie (pronounced as "try") or prefix tree is a tree data structure used to efficiently store and retrieve keys in a dataset of strings. There are various applications of this data structure, such as autocomplete and spellchecker.

Implement the Trie class:
• Trie() Initializes the trie object.
• void insert(String word) Inserts the string word into the trie.
• boolean search(String word) Returns true if the string word is in the trie (i.e., was inserted before), and false otherwise.
• boolean startsWith(String prefix) Returns true if there is a previously inserted string word that has the prefix prefix, and false otherwise.

Example 1:
Input
["Trie", "insert", "search", "search", "startsWith", "insert", "search"]
[[], ["apple"], ["apple"], ["app"], ["app"], ["app"], ["app"]]
Output
[null, null, true, false, true, null, true]

Explanation
Trie trie = new Trie();
trie.insert("apple");
trie.search("apple");   // return True
trie.search("app");     // return False
trie.startsWith("app"); // return True
trie.insert("app");
trie.search("app");     // return True

Constraints:
• 1 <= word.length, prefix.length <= 2000
• word and prefix consist only of lowercase English letters.
• At most 3 * 10⁴ calls in total will be made to insert, search, and startsWith.""",
    bruteForce: Solution(
      code: """class Trie:
    def __init__(self):
        self.words = set()  # Store all inserted words

    def insert(self, word):
        self.words.add(word)

    def search(self, word):
        return word in self.words

    def startsWith(self, prefix):
        for word in self.words:
            if word.startswith(prefix):
                return True
        return False""",
      timeComplexity: "O(1) insert, O(1) search, O(n*m) startsWith",
      spaceComplexity: "O(total characters)",
      explanation: "Use a set to store all words. Insert and search are O(1), but startsWith requires checking all words against the prefix, making it O(n*m) where n is number of words and m is prefix length.",
      steps: [
        "Initialize: Create empty set to store words",
        "Insert: Add word to set (O(1))",
        "Search: Check if word is in set (O(1))",
        "StartsWith: Iterate through all words",
        "  - Check if each word starts with prefix",
        "  - Return True if any match found",
        "  - Return False if no matches",
        "Note: startsWith is inefficient, O(n*m)"
      ],
    ),
    optimized: Solution(
      code: """class TrieNode:
    def __init__(self):
        self.children = {}
        self.is_end = False

class Trie:
    def __init__(self):
        self.root = TrieNode()

    def insert(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
        node.is_end = True

    def search(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                return False
            node = node.children[char]
        return node.is_end

    def startsWith(self, prefix):
        node = self.root
        for char in prefix:
            if char not in node.children:
                return False
            node = node.children[char]
        return True""",
      timeComplexity: "O(m) for all operations - m is word/prefix length",
      spaceComplexity: "O(total characters)",
      explanation: "Use trie data structure with nodes containing children dictionary and end-of-word flag. Each operation traverses at most the length of the word/prefix.",
      steps: [
        "Define TrieNode class:",
        "  - children: dictionary mapping char to TrieNode",
        "  - is_end: boolean flag for end of word",
        "Initialize: Create root TrieNode",
        "Insert:",
        "  - Start at root",
        "  - For each character, create child node if not exists",
        "  - Move to child node",
        "  - Mark last node as end of word",
        "Search:",
        "  - Start at root",
        "  - For each character, traverse to child",
        "  - If child doesn't exist, return False",
        "  - Return is_end flag of final node",
        "StartsWith:",
        "  - Same as search but return True if path exists",
        "  - Don't check is_end flag",
        "Key: All operations O(m) time where m is length"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 211,
    title: "Design Add and Search Words Data Structure",
    difficulty: Difficulty.medium,
    category: "Tries",
    question: """Design a data structure that supports adding new words and finding if a string matches any previously added string.

Implement the WordDictionary class:
• WordDictionary() Initializes the object.
• void addWord(word) Adds word to the data structure, it can be matched later.
• bool search(word) Returns true if there is any string in the data structure that matches word or false otherwise. word may contain dots '.' where dots can be matched with any letter.

Example:
Input
["WordDictionary","addWord","addWord","addWord","search","search","search","search"]
[[],["bad"],["dad"],["mad"],["pad"],["bad"],[".ad"],["b.."]]
Output
[null,null,null,null,false,true,true,true]

Explanation
WordDictionary wordDictionary = new WordDictionary();
wordDictionary.addWord("bad");
wordDictionary.addWord("dad");
wordDictionary.addWord("mad");
wordDictionary.search("pad"); // return False
wordDictionary.search("bad"); // return True
wordDictionary.search(".ad"); // return True
wordDictionary.search("b.."); // return True

Constraints:
• 1 <= word.length <= 25
• word in addWord consists of lowercase English letters.
• word in search consist of '.' or lowercase English letters.
• There will be at most 2 dots in word for search queries.
• At most 10⁴ calls will be made to addWord and search.""",
    bruteForce: Solution(
      code: """class WordDictionary:
    def __init__(self):
        self.words = []

    def addWord(self, word):
        self.words.append(word)

    def search(self, word):
        import re
        pattern = word.replace('.', '.')
        regex = re.compile('^' + pattern + 'END')

        for w in self.words:
            if regex.match(w):
                return True
        return False""",
      timeComplexity: "O(1) addWord, O(n*m) search",
      spaceComplexity: "O(total characters)",
      explanation: "Store words in a list. For search, use regular expression matching against all words. Inefficient for large datasets.",
      steps: [
        "Initialize: Create empty list to store words",
        "AddWord: Append word to list (O(1))",
        "Search:",
        "  - Convert search pattern to regex (. matches any char)",
        "  - Compile regex pattern",
        "  - Iterate through all stored words",
        "  - Check if pattern matches each word",
        "  - Return True if any match found",
        "  - Return False if no matches",
        "Note: Search checks all words, O(n*m) time"
      ],
    ),
    optimized: Solution(
      code: """class TrieNode:
    def __init__(self):
        self.children = {}
        self.is_end = False

class WordDictionary:
    def __init__(self):
        self.root = TrieNode()

    def addWord(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
        node.is_end = True

    def search(self, word):
        def dfs(index, node):
            if index == len(word):
                return node.is_end

            char = word[index]

            if char == '.':
                # Try all possible children
                for child in node.children.values():
                    if dfs(index + 1, child):
                        return True
                return False
            else:
                # Regular character match
                if char not in node.children:
                    return False
                return dfs(index + 1, node.children[char])

        return dfs(0, self.root)""",
      timeComplexity: "O(m) addWord, O(m * 26^k) search worst case",
      spaceComplexity: "O(total characters)",
      explanation: "Use trie with DFS search. For regular characters, follow single path. For '.', recursively try all children. Worst case is when word is all dots, but typically much faster.",
      steps: [
        "Use TrieNode class with children dict and is_end flag",
        "Initialize: Create root TrieNode",
        "AddWord: Same as regular trie insert (O(m))",
        "Search with DFS helper:",
        "  - Base case: if index == word length, return is_end",
        "  - Get character at current index",
        "  - If character is '.':",
        "    - Recursively try all children",
        "    - Return True if any child path succeeds",
        "  - If regular character:",
        "    - Check if child exists",
        "    - Recursively search in child",
        "  - Return result of DFS",
        "Start DFS from root at index 0",
        "Key: Trie structure with backtracking for wildcards"
      ],
    ),
  ),

  LeetCodeQuestion(
    id: 212,
    title: "Word Search II",
    difficulty: Difficulty.hard,
    category: "Tries",
    question: """Given an m x n board of characters and a list of strings words, return all words on the board.

Each word must be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring. The same letter cell may not be used more than once in a word.

Example 1:
Input: board = [["o","a","a","n"],["e","t","a","e"],["i","h","k","r"],["i","f","l","v"]], words = ["oath","pea","eat","rain"]
Output: ["eat","oath"]

Example 2:
Input: board = [["a","b"],["c","d"]], words = ["abcb"]
Output: []

Constraints:
• m == board.length
• n == board[i].length
• 1 <= m, n <= 12
• board[i][j] is a lowercase English letter.
• 1 <= words.length <= 3 * 10⁴
• 1 <= words[i].length <= 10
• words[i] consists of lowercase English letters.
• All the strings of words are unique.""",
    bruteForce: Solution(
      code: """def findWords(board, words):
    def dfs(i, j, word, index, visited):
        if index == len(word):
            return True

        if (i < 0 or i >= len(board) or j < 0 or j >= len(board[0]) or
            (i, j) in visited or board[i][j] != word[index]):
            return False

        visited.add((i, j))

        # Try all 4 directions
        found = (dfs(i+1, j, word, index+1, visited) or
                 dfs(i-1, j, word, index+1, visited) or
                 dfs(i, j+1, word, index+1, visited) or
                 dfs(i, j-1, word, index+1, visited))

        visited.remove((i, j))
        return found

    result = []

    for word in words:
        found = False
        for i in range(len(board)):
            for j in range(len(board[0])):
                if dfs(i, j, word, 0, set()):
                    result.append(word)
                    found = True
                    break
            if found:
                break

    return result""",
      timeComplexity: "O(w * m * n * 4^L) - w words, L max length",
      spaceComplexity: "O(L)",
      explanation: "For each word, try DFS from each cell. Check all 4 directions recursively. Very inefficient as it searches for each word independently.",
      steps: [
        "Define DFS function to search for word starting at (i, j)",
        "  - Base case: if index == word length, found complete word",
        "  - Check bounds, visited set, and character match",
        "  - Mark cell as visited",
        "  - Try all 4 directions recursively",
        "  - Unmark cell (backtrack)",
        "For each word in words list:",
        "  - Try DFS from each cell in board",
        "  - If found, add to result and move to next word",
        "Return result list",
        "Note: Repeats work for overlapping words, very slow"
      ],
    ),
    optimized: Solution(
      code: """def findWords(board, words):
    # Build trie from words
    class TrieNode:
        def __init__(self):
            self.children = {}
            self.word = None

    root = TrieNode()
    for word in words:
        node = root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
        node.word = word

    result = []
    m, n = len(board), len(board[0])

    def dfs(i, j, node):
        char = board[i][j]

        if char not in node.children:
            return

        next_node = node.children[char]

        # Found a word
        if next_node.word:
            result.append(next_node.word)
            next_node.word = None  # Avoid duplicates

        # Mark as visited
        board[i][j] = '#'

        # Try all 4 directions
        if i > 0:
            dfs(i-1, j, next_node)
        if i < m-1:
            dfs(i+1, j, next_node)
        if j > 0:
            dfs(i, j-1, next_node)
        if j < n-1:
            dfs(i, j+1, next_node)

        # Restore cell
        board[i][j] = char

    # Start DFS from each cell
    for i in range(m):
        for j in range(n):
            dfs(i, j, root)

    return result""",
      timeComplexity: "O(m * n * 4^L) - much better with trie",
      spaceComplexity: "O(total characters in words)",
      explanation: "Build trie from all words, then do single DFS from each cell following trie paths. Find multiple words in one traversal. Much more efficient than searching for each word separately.",
      steps: [
        "Build trie from all words:",
        "  - Create TrieNode class with children dict and word field",
        "  - Insert all words into trie",
        "  - Store complete word at end nodes",
        "Define DFS function with cell position and current trie node:",
        "  - Get character at current cell",
        "  - Check if character exists in trie node's children",
        "  - If not, return (invalid path)",
        "  - Move to next trie node",
        "  - If next node has word, add to result and clear (avoid duplicates)",
        "  - Mark cell as visited using '#'",
        "  - Recursively explore all 4 directions",
        "  - Restore cell character (backtrack)",
        "Call DFS from each cell in board",
        "Return result",
        "Key: Single trie + DFS finds all words in one traversal"
      ],
    ),
  ),

];
