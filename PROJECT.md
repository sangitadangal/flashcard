# LeetCode Flashcards - Flutter App

A beautiful and interactive flashcard app for studying NeetCode 150 interview questions with progress tracking and filtering.

## Features

- **150 Complete Questions** from NeetCode 150 with dual solutions (Brute Force + Optimized)
- **Multiple Flashcard Sets** - Homepage with set selection (ready for Blind 75, System Design, etc.)
- **Interactive Flashcards** - Smooth 3D flip animation
- **Detailed Solutions** - Step-by-step explanations with time/space complexity analysis
- **Smart Filtering** - Filter by difficulty and category (18 categories)
- **Progress Tracking** - Track mastery with visual indicators and persistent storage
- **Gesture Support** - Tap to flip, swipe to navigate
- **Cross-Platform** - iOS, Android, Web, macOS, Windows, Linux

## Quick Start

```bash
cd /Users/sangitadangal/claude-projects/flutter-projects/flashcard
flutter pub get
flutter run
```

## Project Structure

```
flashcard/
├── lib/
│   ├── main.dart                       # App entry point
│   ├── models/
│   │   ├── leetcode_question.dart      # Question data model
│   │   ├── flashcard_set.dart          # Set model
│   │   ├── available_sets.dart         # Registry of available sets
│   │   ├── all_questions.dart          # Aggregates all 150 questions
│   │   └── categories/                 # 18 category files
│   ├── services/
│   │   └── flashcard_provider.dart     # State management
│   ├── screens/
│   │   ├── sets_home_screen.dart       # Set selection homepage
│   │   ├── flashcard_screen.dart       # Main flashcard view
│   │   ├── filter_screen.dart          # Filter interface
│   │   └── progress_screen.dart        # Progress tracking
│   └── widgets/
│       └── flashcard_widget.dart       # Flashcard with flip animation
└── pubspec.yaml
```

## Categories (18 Total)

1. Arrays & Hashing (9 questions)
2. Two Pointers (5 questions)
3. Sliding Window (6 questions)
4. Stack (7 questions)
5. Binary Search (7 questions)
6. Linked List (11 questions)
7. Trees (15 questions)
8. Tries (3 questions)
9. Heap/Priority Queue (7 questions)
10. Backtracking (9 questions)
11. Graphs (13 questions)
12. Advanced Graphs (6 questions)
13. 1-D Dynamic Programming (12 questions)
14. 2-D Dynamic Programming (11 questions)
15. Greedy (8 questions)
16. Intervals (6 questions)
17. Math & Geometry (8 questions)
18. Bit Manipulation (7 questions)

**Total: 150 questions** ✅

## Key Features Explained

### Multiple Sets Homepage
- App opens to set selection screen
- Shows available flashcard sets with progress
- Currently includes NeetCode 150
- Easy to add more sets (Blind 75, System Design, custom sets)
- Progress tracked independently per set

### Flashcard Interface
- **Front**: Question description with difficulty badge
- **Back**: Tabbed solutions (Brute Force / Optimized)
- Each solution includes:
  - Complete Python code (collapsible)
  - Time and space complexity
  - Detailed explanation
  - 5-7 step-by-step approach

### Progress Tracking
- Mark questions as mastered with star button
- Overall progress bar and percentage
- Progress breakdown by difficulty (Easy/Medium/Hard)
- Progress breakdown by category
- Automatic persistence using SharedPreferences
- Data survives app restarts

### Filtering System
- Filter by difficulty (multiple selection)
- Filter by category (multiple selection)
- Combine filters for precise control
- Active filter indicator on home screen
- Shows filtered count (e.g., "Showing 25 of 150")

## Usage

### Navigation
- **Tap card** to flip between question and solution
- **Swipe left/right** to navigate questions
- **Previous/Next buttons** for precise control
- **Star button** to mark as mastered

### Filtering
1. Tap filter icon (top-right)
2. Select difficulties and/or categories
3. Apply multiple filters simultaneously
4. Tap "Clear All" to reset

### Progress
1. Tap chart icon (top-right)
2. View overall progress circle
3. See breakdown by difficulty and category
4. Reset progress with confirmation

## Technical Details

- **Framework**: Flutter 3.0+
- **Language**: Dart
- **State Management**: Provider pattern
- **Storage**: SharedPreferences (JSON)
- **Animation**: Custom 3D Matrix4 transforms
- **Architecture**: Clean separation (Models/Services/Screens/Widgets)

## Dependencies

```yaml
provider: ^6.1.1          # State management
shared_preferences: ^2.2.2 # Persistent storage
flutter_lints: ^3.0.0     # Code quality
```

## Building for Release

### iOS
```bash
flutter build ios --release
```

### Android
```bash
flutter build apk --release
```

### Web
```bash
flutter build web --release
```

## Data Version Control

The app includes automatic version control for the question dataset:

- **Version 1**: 5 sample questions
- **Version 2**: Full 150 questions (current)

When upgrading, the app automatically:
- Detects old cached data
- Loads new dataset
- Preserves user progress for matching questions
- Updates version number

## Adding New Questions

To add more questions, create or edit category files in `lib/models/categories/`:

```dart
final question = LeetCodeQuestion(
  id: 151,
  title: "Your Question",
  difficulty: Difficulty.medium,
  category: "Your Category",
  question: """Problem description...""",
  bruteForce: Solution(
    code: """Python code""",
    timeComplexity: "O(n)",
    spaceComplexity: "O(1)",
    explanation: "Explanation",
    steps: ["Step 1", "Step 2", ...],
  ),
  optimized: Solution(...),
);
```

Then add to `lib/models/all_questions.dart`.

## Adding New Flashcard Sets

Edit `lib/models/available_sets.dart`:

```dart
FlashcardSet(
  id: 'blind_75',
  title: 'Blind 75',
  description: 'The famous 75 LeetCode questions',
  iconEmoji: '🎯',
  totalQuestions: 75,
  questions: blind75Questions,
  category: 'Coding Interview',
),
```

## Troubleshooting

### Issue: Dependencies not installing
```bash
flutter clean
flutter pub get
```

### Issue: App not launching
```bash
flutter doctor  # Check setup
flutter run -v  # Verbose output
```

### Issue: Progress not saving
- Check storage permissions
- Verify SharedPreferences is working
- Try uninstall/reinstall

### Issue: Wrong question count
- Uninstall app to clear cache
- Reinstall to load fresh data

## Version History

- **v2.1** (2025-10-31): Added multiple sets feature, bug fixes
- **v2.0** (2025-10-31): Completed all 150 questions
- **v1.0** (2025-10-30): Initial release with 5 sample questions

## Status

✅ **Production Ready**
- 150/150 questions complete
- All features working
- Cross-platform support
- Persistent storage
- Clean codebase

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Provider Package](https://pub.dev/packages/provider)
- [NeetCode 150](https://neetcode.io/practice)
- [LeetCode](https://leetcode.com)

---

Built with Flutter • Cross-Platform • Open Source
