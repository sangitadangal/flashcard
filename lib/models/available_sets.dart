import 'flashcard_set.dart';
import 'all_questions.dart';

// Available flashcard sets
final List<FlashcardSet> availableFlashcardSets = [
  FlashcardSet(
    id: 'neetcode_150',
    title: 'NeetCode 150',
    description: 'Master the most popular coding interview questions from NeetCode. Covers all essential patterns and data structures.',
    iconEmoji: '💻',
    totalQuestions: 150,
    questions: allNeetCode150Questions,
    category: 'Coding Interview',
    isCustom: false,
    createdAt: DateTime(2025, 10, 31),
  ),

  // Placeholder for future sets - will be added later
  // FlashcardSet(
  //   id: 'blind_75',
  //   title: 'Blind 75',
  //   description: 'The famous 75 LeetCode questions curated by a former Facebook engineer.',
  //   iconEmoji: '🎯',
  //   totalQuestions: 75,
  //   questions: [], // To be added
  //   category: 'Coding Interview',
  //   isCustom: false,
  // ),

  // FlashcardSet(
  //   id: 'system_design',
  //   title: 'System Design',
  //   description: 'Common system design interview questions and patterns.',
  //   iconEmoji: '🏗️',
  //   totalQuestions: 50,
  //   questions: [], // To be added
  //   category: 'System Design',
  //   isCustom: false,
  // ),
];

// Get set by ID
FlashcardSet? getFlashcardSetById(String id) {
  try {
    return availableFlashcardSets.firstWhere((set) => set.id == id);
  } catch (e) {
    return null;
  }
}
