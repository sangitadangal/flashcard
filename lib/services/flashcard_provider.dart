import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/leetcode_question.dart';
import '../models/all_questions.dart';

class FlashcardProvider extends ChangeNotifier {
  List<LeetCodeQuestion> _allQuestions = [];
  List<LeetCodeQuestion> _filteredQuestions = [];
  int _currentIndex = 0;
  bool _isShowingAnswer = false;
  Set<Difficulty> _selectedDifficulties = {};
  Set<String> _selectedCategories = {};
  bool _hideMastered = false;
  bool _showOnlyMastered = false;

  FlashcardProvider() {
    _loadQuestions();
  }

  // Constructor for pre-loaded questions (for specific sets)
  FlashcardProvider.withQuestions(List<LeetCodeQuestion> questions) {
    _allQuestions = List.from(questions);
    _filteredQuestions = List.from(_allQuestions);
    _loadMasteredStatus(); // Load mastered status from storage (async)
    _loadFilterState(); // Load filter state
    _loadLastQuestionIndex(); // Load last question index
  }

  // Load mastered status from storage and apply to current questions
  Future<void> _loadMasteredStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? masteredJson = prefs.getString('mastered_questions');

      if (masteredJson != null) {
        final Map<String, dynamic> masteredMap = json.decode(masteredJson);

        // Update mastered status for current questions
        for (int i = 0; i < _allQuestions.length; i++) {
          final questionId = _allQuestions[i].id.toString();
          if (masteredMap.containsKey(questionId)) {
            _allQuestions[i] = _allQuestions[i].copyWith(
              isMastered: masteredMap[questionId] == true,
            );
          }
        }

        // Update filtered questions as well
        _filteredQuestions = List.from(_allQuestions);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading mastered status: $e');
    }
  }

  // Save only the mastered status to storage (lighter weight)
  Future<void> _saveMasteredStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final Map<String, bool> masteredMap = {};

      for (var question in _allQuestions) {
        masteredMap[question.id.toString()] = question.isMastered;
      }

      final String masteredJson = json.encode(masteredMap);
      await prefs.setString('mastered_questions', masteredJson);
    } catch (e) {
      debugPrint('Error saving mastered status: $e');
    }
  }

  // Load last question ID from storage and find its index
  Future<void> _loadLastQuestionIndex() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final int? savedQuestionId = prefs.getInt('last_question_id');

      if (savedQuestionId != null) {
        // Find the question in filtered questions
        final index = _filteredQuestions.indexWhere((q) => q.id == savedQuestionId);
        if (index != -1) {
          _currentIndex = index;
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint('Error loading last question index: $e');
    }
  }

  // Save current question ID to storage
  Future<void> _saveQuestionIndex() async {
    try {
      if (currentQuestion != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('last_question_id', currentQuestion!.id);
      }
    } catch (e) {
      debugPrint('Error saving question index: $e');
    }
  }

  // Load filter state from storage
  Future<void> _loadFilterState() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Load selected difficulties
      final List<String>? difficulties = prefs.getStringList('selected_difficulties');
      if (difficulties != null) {
        _selectedDifficulties = difficulties
            .map((d) => Difficulty.values.firstWhere((diff) => diff.toString() == d))
            .toSet();
      }

      // Load selected categories
      final List<String>? categories = prefs.getStringList('selected_categories');
      if (categories != null) {
        _selectedCategories = categories.toSet();
      }

      // Load hide mastered state
      final bool? hideMastered = prefs.getBool('hide_mastered');
      if (hideMastered != null) {
        _hideMastered = hideMastered;
      }

      // Load show only mastered state
      final bool? showOnlyMastered = prefs.getBool('show_only_mastered');
      if (showOnlyMastered != null) {
        _showOnlyMastered = showOnlyMastered;
      }

      // Apply filters after loading
      _applyFilters();
    } catch (e) {
      debugPrint('Error loading filter state: $e');
    }
  }

  // Save filter state to storage
  Future<void> _saveFilterState() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Save selected difficulties
      await prefs.setStringList(
        'selected_difficulties',
        _selectedDifficulties.map((d) => d.toString()).toList(),
      );

      // Save selected categories
      await prefs.setStringList('selected_categories', _selectedCategories.toList());

      // Save hide mastered state
      await prefs.setBool('hide_mastered', _hideMastered);

      // Save show only mastered state
      await prefs.setBool('show_only_mastered', _showOnlyMastered);
    } catch (e) {
      debugPrint('Error saving filter state: $e');
    }
  }

  // Getters
  List<LeetCodeQuestion> get allQuestions => _allQuestions;
  List<LeetCodeQuestion> get filteredQuestions => _filteredQuestions;
  int get currentIndex => _currentIndex;
  bool get isShowingAnswer => _isShowingAnswer;
  Set<Difficulty> get selectedDifficulties => _selectedDifficulties;
  Set<String> get selectedCategories => _selectedCategories;
  bool get hideMastered => _hideMastered;
  bool get showOnlyMastered => _showOnlyMastered;

  LeetCodeQuestion? get currentQuestion {
    if (_filteredQuestions.isNotEmpty && _currentIndex < _filteredQuestions.length) {
      return _filteredQuestions[_currentIndex];
    }
    return null;
  }

  bool get isFiltered =>
      _selectedDifficulties.isNotEmpty || _selectedCategories.isNotEmpty || _hideMastered || _showOnlyMastered;

  int get totalCount => _allQuestions.length;
  int get filteredCount => _filteredQuestions.length;
  int get masteredCount =>
      _allQuestions.where((q) => q.isMastered).length;

  double get progress {
    if (_allQuestions.isEmpty) return 0.0;
    return masteredCount / totalCount;
  }

  List<String> get allCategories {
    return _allQuestions.map((q) => q.category).toSet().toList()..sort();
  }

  // Load questions from storage or use sample data
  Future<void> _loadQuestions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? questionsJson = prefs.getString('leetcode_questions');
      final int? dataVersion = prefs.getInt('data_version');

      // Current data version - increment when dataset changes
      const int currentVersion = 2; // Changed to 2 for 150 questions

      // Load from storage only if version matches
      if (questionsJson != null && dataVersion == currentVersion) {
        final List<dynamic> decoded = json.decode(questionsJson);
        _allQuestions = decoded
            .map((item) => LeetCodeQuestion.fromJson(item))
            .toList();
      } else {
        // Use fresh dataset if no cached data or version mismatch
        _allQuestions = List.from(allNeetCode150Questions);
        // Update version number
        await prefs.setInt('data_version', currentVersion);
      }

      // Load mastered status
      await _loadMasteredStatus();

      _filteredQuestions = List.from(_allQuestions);
      notifyListeners();
      await _saveQuestions();
    } catch (e) {
      debugPrint('Error loading questions: $e');
      _allQuestions = List.from(allNeetCode150Questions);
      _filteredQuestions = List.from(_allQuestions);
      notifyListeners();
    }
  }

  // Save questions to storage
  Future<void> _saveQuestions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String questionsJson = json.encode(
        _allQuestions.map((q) => q.toJson()).toList(),
      );
      await prefs.setString('leetcode_questions', questionsJson);

      // Also save mastered status separately
      await _saveMasteredStatus();
    } catch (e) {
      debugPrint('Error saving questions: $e');
    }
  }

  // Toggle mastered status
  void toggleMastered() {
    if (currentQuestion == null) return;

    final questionId = currentQuestion!.id;

    // Update in all questions
    final allIndex = _allQuestions.indexWhere((q) => q.id == questionId);
    if (allIndex != -1) {
      _allQuestions[allIndex] = _allQuestions[allIndex].copyWith(
        isMastered: !_allQuestions[allIndex].isMastered,
      );
    }

    // Update in filtered questions
    if (_currentIndex < _filteredQuestions.length) {
      _filteredQuestions[_currentIndex] = _filteredQuestions[_currentIndex].copyWith(
        isMastered: !_filteredQuestions[_currentIndex].isMastered,
      );
    }

    notifyListeners();
    _saveMasteredStatus(); // Save immediately when toggled
  }

  // Navigation
  void nextQuestion() {
    _isShowingAnswer = false;
    if (_filteredQuestions.isNotEmpty) {
      if (_currentIndex < _filteredQuestions.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
    }
    notifyListeners();
    _saveQuestionIndex(); // Save position for resume
  }

  void previousQuestion() {
    _isShowingAnswer = false;
    if (_filteredQuestions.isNotEmpty) {
      if (_currentIndex > 0) {
        _currentIndex--;
      } else {
        _currentIndex = _filteredQuestions.length - 1;
      }
    }
    notifyListeners();
    _saveQuestionIndex(); // Save position for resume
  }

  void flipCard() {
    _isShowingAnswer = !_isShowingAnswer;
    notifyListeners();
  }

  // Filter methods
  void toggleDifficulty(Difficulty difficulty) {
    if (_selectedDifficulties.contains(difficulty)) {
      _selectedDifficulties.remove(difficulty);
    } else {
      _selectedDifficulties.add(difficulty);
    }
    _applyFilters();
    _saveFilterState(); // Save filter state
  }

  void toggleCategory(String category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    _applyFilters();
    _saveFilterState(); // Save filter state
  }

  void toggleHideMastered() {
    _hideMastered = !_hideMastered;
    // Disable show only mastered when hiding mastered
    if (_hideMastered) {
      _showOnlyMastered = false;
    }
    _applyFilters();
    _saveFilterState(); // Save filter state
  }

  void toggleShowOnlyMastered() {
    _showOnlyMastered = !_showOnlyMastered;
    // Disable hide mastered when showing only mastered
    if (_showOnlyMastered) {
      _hideMastered = false;
    }
    _applyFilters();
    _saveFilterState(); // Save filter state
  }

  void clearFilters() {
    _selectedDifficulties.clear();
    _selectedCategories.clear();
    _hideMastered = false;
    _showOnlyMastered = false;
    _applyFilters();
    _saveFilterState(); // Save filter state
  }

  void _applyFilters() {
    _filteredQuestions = List.from(_allQuestions);

    // Filter by difficulty
    if (_selectedDifficulties.isNotEmpty) {
      _filteredQuestions = _filteredQuestions
          .where((q) => _selectedDifficulties.contains(q.difficulty))
          .toList();
    }

    // Filter by category
    if (_selectedCategories.isNotEmpty) {
      _filteredQuestions = _filteredQuestions
          .where((q) => _selectedCategories.contains(q.category))
          .toList();
    }

    // Filter out mastered questions if hide mastered is enabled
    if (_hideMastered) {
      _filteredQuestions = _filteredQuestions
          .where((q) => !q.isMastered)
          .toList();
    }

    // Show only mastered questions if enabled
    if (_showOnlyMastered) {
      _filteredQuestions = _filteredQuestions
          .where((q) => q.isMastered)
          .toList();
    }

    // Try to restore last question position
    _loadLastQuestionIndex();

    // Reset index if out of bounds or if question not found
    if (_filteredQuestions.isNotEmpty && _currentIndex >= _filteredQuestions.length) {
      _currentIndex = 0;
    } else if (_filteredQuestions.isEmpty) {
      _currentIndex = 0;
    }

    _isShowingAnswer = false;
    notifyListeners();
  }

  // Reset progress
  void resetProgress() {
    for (int i = 0; i < _allQuestions.length; i++) {
      _allQuestions[i] = _allQuestions[i].copyWith(isMastered: false);
    }
    _applyFilters();
    _saveMasteredStatus();
  }

  // Get category progress
  Map<String, Map<String, int>> getCategoryProgress() {
    final Map<String, Map<String, int>> progress = {};

    for (var question in _allQuestions) {
      if (!progress.containsKey(question.category)) {
        progress[question.category] = {'mastered': 0, 'total': 0};
      }
      progress[question.category]!['total'] =
          (progress[question.category]!['total'] ?? 0) + 1;
      if (question.isMastered) {
        progress[question.category]!['mastered'] =
            (progress[question.category]!['mastered'] ?? 0) + 1;
      }
    }

    return progress;
  }

  // Get difficulty progress
  Map<Difficulty, Map<String, int>> getDifficultyProgress() {
    final Map<Difficulty, Map<String, int>> progress = {};

    for (var difficulty in Difficulty.values) {
      progress[difficulty] = {'mastered': 0, 'total': 0};
    }

    for (var question in _allQuestions) {
      progress[question.difficulty]!['total'] =
          (progress[question.difficulty]!['total'] ?? 0) + 1;
      if (question.isMastered) {
        progress[question.difficulty]!['mastered'] =
            (progress[question.difficulty]!['mastered'] ?? 0) + 1;
      }
    }

    return progress;
  }
}