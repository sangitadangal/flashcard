import 'leetcode_question.dart';

class FlashcardSet {
  final String id;
  final String title;
  final String description;
  final String iconEmoji;
  final int totalQuestions;
  final List<LeetCodeQuestion> questions;
  final String category;
  final bool isCustom;
  final DateTime? createdAt;

  FlashcardSet({
    required this.id,
    required this.title,
    required this.description,
    required this.iconEmoji,
    required this.totalQuestions,
    required this.questions,
    this.category = 'General',
    this.isCustom = false,
    this.createdAt,
  });

  // Calculate progress
  int get completedCount => questions.where((q) => q.isMastered).length;

  double get progress {
    if (totalQuestions == 0) return 0.0;
    return completedCount / totalQuestions;
  }

  String get progressText => '$completedCount / $totalQuestions';

  // Copy with method for updating
  FlashcardSet copyWith({
    String? id,
    String? title,
    String? description,
    String? iconEmoji,
    int? totalQuestions,
    List<LeetCodeQuestion>? questions,
    String? category,
    bool? isCustom,
    DateTime? createdAt,
  }) {
    return FlashcardSet(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      iconEmoji: iconEmoji ?? this.iconEmoji,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      questions: questions ?? this.questions,
      category: category ?? this.category,
      isCustom: isCustom ?? this.isCustom,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
