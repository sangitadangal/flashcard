class LeetCodeQuestion {
  final int id;
  final String title;
  final Difficulty difficulty;
  final String category;
  final String question;
  final Solution bruteForce;
  final Solution optimized;
  bool isMastered;

  LeetCodeQuestion({
    required this.id,
    required this.title,
    required this.difficulty,
    required this.category,
    required this.question,
    required this.bruteForce,
    required this.optimized,
    this.isMastered = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'difficulty': difficulty.toString().split('.').last,
      'category': category,
      'question': question,
      'bruteForce': bruteForce.toJson(),
      'optimized': optimized.toJson(),
      'isMastered': isMastered,
    };
  }

  factory LeetCodeQuestion.fromJson(Map<String, dynamic> json) {
    return LeetCodeQuestion(
      id: json['id'],
      title: json['title'],
      difficulty: Difficulty.values.firstWhere(
        (e) => e.toString().split('.').last == json['difficulty'],
      ),
      category: json['category'],
      question: json['question'],
      bruteForce: Solution.fromJson(json['bruteForce']),
      optimized: Solution.fromJson(json['optimized']),
      isMastered: json['isMastered'] ?? false,
    );
  }

  LeetCodeQuestion copyWith({bool? isMastered}) {
    return LeetCodeQuestion(
      id: id,
      title: title,
      difficulty: difficulty,
      category: category,
      question: question,
      bruteForce: bruteForce,
      optimized: optimized,
      isMastered: isMastered ?? this.isMastered,
    );
  }
}

enum Difficulty {
  easy,
  medium,
  hard,
}

class Solution {
  final String code;
  final String timeComplexity;
  final String spaceComplexity;
  final String explanation;
  final List<String> steps;

  Solution({
    required this.code,
    required this.timeComplexity,
    required this.spaceComplexity,
    required this.explanation,
    required this.steps,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'timeComplexity': timeComplexity,
      'spaceComplexity': spaceComplexity,
      'explanation': explanation,
      'steps': steps,
    };
  }

  factory Solution.fromJson(Map<String, dynamic> json) {
    return Solution(
      code: json['code'],
      timeComplexity: json['timeComplexity'],
      spaceComplexity: json['spaceComplexity'],
      explanation: json['explanation'],
      steps: List<String>.from(json['steps']),
    );
  }
}
