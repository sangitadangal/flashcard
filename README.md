# LeetCode Flashcards - Flutter App

A beautiful and interactive flashcard app for studying NeetCode 150 interview questions, built with Flutter.

## Features

- **Interactive Flashcards**: Flip cards with smooth 3D animations to reveal solutions
- **Dual Solutions**: Each question includes both Brute Force and Optimized approaches
- **Detailed Explanations**:
  - Step-by-step approach breakdown
  - Time and space complexity analysis
  - Full Python 3 code implementations
  - Collapsible code sections
- **Smart Filtering**:
  - Filter by difficulty (Easy/Medium/Hard)
  - Filter by category (Arrays & Hashing, Two Pointers, etc.)
  - Multiple filters can be applied simultaneously
- **Progress Tracking**:
  - Overall progress with visual indicators
  - Progress breakdown by difficulty
  - Progress breakdown by category
  - Mark questions as mastered
- **Persistent Storage**: Progress is saved automatically using SharedPreferences
- **Gesture Support**:
  - Tap to flip cards
  - Swipe left/right to navigate between questions

## Project Structure

```
flashcard/
├── lib/
│   ├── main.dart                           # App entry point
│   ├── models/
│   │   ├── leetcode_question.dart          # Data models
│   │   └── sample_questions.dart           # 5 complete questions with solutions
│   ├── services/
│   │   └── flashcard_provider.dart         # State management with Provider
│   ├── screens/
│   │   ├── home_screen.dart                # Main app screen
│   │   ├── filter_screen.dart              # Filter interface
│   │   └── progress_screen.dart            # Progress tracking view
│   └── widgets/
│       └── flashcard_widget.dart           # Flashcard with flip animation
├── pubspec.yaml                            # Dependencies
└── README.md                               # This file
```

## Questions Included

The app currently includes 5 complete questions from NeetCode 150:

1. **Two Sum** (Easy - Arrays & Hashing)
2. **Valid Anagram** (Easy - Arrays & Hashing)
3. **Contains Duplicate** (Easy - Arrays & Hashing)
4. **Valid Palindrome** (Easy - Two Pointers)
5. **3Sum** (Medium - Two Pointers)

Each question includes:
- Full problem description with examples and constraints
- Brute force solution with:
  - Python 3 code
  - Time complexity
  - Space complexity
  - Detailed explanation
  - Step-by-step approach (5-7 steps)
- Optimized solution with the same comprehensive breakdown

## Installation & Setup

### Prerequisites

1. **Install Flutter**: Follow the [official Flutter installation guide](https://flutter.dev/docs/get-started/install)
2. **Verify installation**:
   ```bash
   flutter doctor
   ```
   Make sure all checks pass (or at least Flutter and one platform SDK)

### Setup Steps

1. **Navigate to the project directory**:
   ```bash
   cd /Users/sangitadangal/claude-projects/flutter-projects/flashcard
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:

   **For iOS Simulator** (macOS only):
   ```bash
   flutter run
   ```

   **For Android Emulator**:
   ```bash
   flutter emulators --launch <emulator_id>
   flutter run
   ```

   **For Chrome** (web):
   ```bash
   flutter run -d chrome
   ```

## Dependencies

The app uses the following Flutter packages:

- **provider** (^6.1.1): State management
- **shared_preferences** (^2.2.2): Persistent storage
- **flutter_lints** (^3.0.0): Code quality and linting

## Usage Guide

### Main Screen

- **Top Bar**:
  - Filter icon (shows red dot when filters are active)
  - Progress chart icon
- **Progress Bar**: Shows overall mastery progress
- **Flashcard Area**:
  - Front: Question description
  - Back: Tabbed solutions with code and explanations
- **Bottom Controls**:
  - Previous/Next navigation buttons
  - Star button to mark as mastered
  - Gesture instructions

### Flashcard Interactions

1. **Flip Card**: Tap anywhere on the card
2. **Navigate**:
   - Swipe left to go to next question
   - Swipe right to go to previous question
   - Use bottom arrow buttons
3. **View Solutions**:
   - Switch between "Brute Force" and "Optimized" tabs
   - Read step-by-step approach
   - Tap "View Code" to expand/collapse code section
   - View time and space complexity

### Filtering

1. Tap the filter icon in the top-right
2. Select difficulty levels (Easy/Medium/Hard)
3. Select categories (Arrays & Hashing, Two Pointers, etc.)
4. Apply multiple filters
5. See filtered count at the top
6. Tap "Clear All" to remove filters

### Progress Tracking

1. Tap the chart icon in the top-right
2. View overall progress with circular indicator
3. See progress breakdown by difficulty
4. See progress breakdown by category
5. Tap refresh icon to reset all progress (with confirmation)

### Marking Questions as Mastered

1. Navigate to a question
2. Tap the star icon at the bottom
3. Star turns yellow when mastered
4. Progress updates automatically
5. Changes persist across app restarts

## Building for Release

### iOS

```bash
flutter build ios --release
```

Then open `ios/Runner.xcworkspace` in Xcode and archive for App Store.

### Android

```bash
flutter build apk --release
```

APK will be at: `build/app/outputs/flutter-apk/app-release.apk`

### Web

```bash
flutter build web --release
```

Output will be in: `build/web/`

## Customization

### Adding More Questions

Edit `lib/models/sample_questions.dart` and add new `LeetCodeQuestion` objects to the `sampleQuestions` list:

```dart
LeetCodeQuestion(
  id: 6,
  title: "Your Question Title",
  difficulty: Difficulty.medium,
  category: "Your Category",
  question: """Full question description...""",
  bruteForce: Solution(
    code: """Python code here""",
    timeComplexity: "O(n)",
    spaceComplexity: "O(1)",
    explanation: "Explanation here",
    steps: [
      "Step 1",
      "Step 2",
      // ...
    ],
  ),
  optimized: Solution(
    // Same structure as bruteForce
  ),
),
```

### Changing Theme Colors

Edit `lib/main.dart` and modify the `ThemeData`:

```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple), // Change color
  useMaterial3: true,
),
```

### Adjusting Animations

Edit `lib/widgets/flashcard_widget.dart` and modify the `AnimationController` duration:

```dart
_controller = AnimationController(
  duration: const Duration(milliseconds: 800), // Change duration
  vsync: this,
);
```

## Troubleshooting

### Issue: Flutter not found

**Solution**:
1. Install Flutter from https://flutter.dev/docs/get-started/install
2. Add Flutter to your PATH
3. Run `flutter doctor` to verify

### Issue: Dependencies not installing

**Solution**:
```bash
flutter clean
flutter pub get
```

### Issue: App not running on iOS simulator

**Solution**:
1. Ensure Xcode is installed
2. Open Xcode and accept license agreements
3. Run: `open -a Simulator`
4. Then: `flutter run`

### Issue: Build errors

**Solution**:
```bash
flutter clean
flutter pub get
flutter pub upgrade
flutter run
```

### Issue: Progress not saving

**Solution**: Make sure you've granted storage permissions. On iOS, this should work automatically. On Android, check app permissions in Settings.

## Technical Details

- **State Management**: Provider pattern for reactive state updates
- **Storage**: SharedPreferences for JSON serialization of progress data
- **Animation**: Custom 3D flip animation using Matrix4 transformations
- **Architecture**: Clean separation of concerns (Models, Services, Screens, Widgets)
- **Platform Support**: iOS, Android, Web, macOS, Windows, Linux

## Performance

- Smooth 60 FPS animations
- Efficient state management with Provider
- Minimal rebuilds using Consumer widgets
- Lazy loading of questions

## Future Enhancements

Potential features to add:
- [ ] Search functionality
- [ ] Bookmarking favorite questions
- [ ] Daily study reminders
- [ ] Spaced repetition algorithm
- [ ] Export progress as CSV/PDF
- [ ] Dark mode support
- [ ] Multiple programming language support
- [ ] Video solution links
- [ ] Custom question sets
- [ ] Study streaks and achievements

## Contributing

Feel free to fork this project and customize it for your needs!

## License

This project is open source and available for personal and educational use.

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Provider Package](https://pub.dev/packages/provider)
- [NeetCode 150](https://neetcode.io/practice)
- [LeetCode](https://leetcode.com)

---

Built with ❤️ using Flutter
