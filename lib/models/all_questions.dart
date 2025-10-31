import 'leetcode_question.dart';

// Import all category files
import 'categories/arrays_hashing.dart';
import 'categories/two_pointers.dart';
import 'categories/sliding_window.dart';
import 'categories/stack.dart';
import 'categories/binary_search.dart';
import 'categories/linked_list.dart';
import 'categories/trees.dart';
import 'categories/tries.dart';
import 'categories/heap_priority_queue.dart';
import 'categories/backtracking.dart';
import 'categories/graphs.dart';
import 'categories/advanced_graphs.dart';
import 'categories/dynamic_programming_1d.dart';
import 'categories/dynamic_programming_2d.dart';
import 'categories/greedy.dart';
import 'categories/intervals.dart';
import 'categories/math_geometry.dart';
import 'categories/bit_manipulation.dart';

// NeetCode 150 - All Questions Combined
// Total: 150 questions across 18 categories

final List<LeetCodeQuestion> allNeetCode150Questions = [
  ...arraysHashingQuestions,        // 9 questions
  ...twoPointersQuestions,          // 5 questions
  ...slidingWindowQuestions,        // 6 questions
  ...stackQuestions,                // 7 questions
  ...binarySearchQuestions,         // 7 questions
  ...linkedListQuestions,           // 11 questions
  ...treesQuestions,                // 15 questions
  ...triesQuestions,                // 3 questions
  ...heapPriorityQueueQuestions,    // 7 questions
  ...backtrackingQuestions,         // 9 questions
  ...graphsQuestions,               // 13 questions
  ...advancedGraphsQuestions,       // 6 questions
  ...dynamicProgramming1DQuestions, // 12 questions
  ...dynamicProgramming2DQuestions, // 11 questions
  ...greedyQuestions,               // 8 questions
  ...intervalsQuestions,            // 6 questions
  ...mathGeometryQuestions,         // 8 questions
  ...bitManipulationQuestions,      // 7 questions
];
