# Quick Start Guide

Get the LeetCode Flashcards app running in 5 minutes!

## Prerequisites

You need Flutter installed on your machine. If you don't have it:

### Install Flutter (macOS)

```bash
# Download Flutter SDK
cd ~/development
git clone https://github.com/flutter/flutter.git -b stable

# Add to PATH (add this to your ~/.zshrc or ~/.bash_profile)
export PATH="$PATH:$HOME/development/flutter/bin"

# Verify installation
flutter doctor
```

For other platforms, see: https://flutter.dev/docs/get-started/install

## Run the App (3 Steps)

### 1. Navigate to Project

```bash
cd /Users/sangitadangal/claude-projects/flutter-projects/flashcard
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the App

**Option A: iOS Simulator (macOS only)**
```bash
# Open simulator
open -a Simulator

# Run app
flutter run
```

**Option B: Chrome (All platforms)**
```bash
flutter run -d chrome
```

**Option C: Android Emulator**
```bash
# List available emulators
flutter emulators

# Launch an emulator
flutter emulators --launch <emulator_id>

# Run app
flutter run
```

## Expected Output

When the app launches, you should see:

1. **Top Bar**: "NeetCode 150" with filter and progress icons
2. **Progress Bar**: Shows 0/5 questions mastered initially
3. **Flashcard**: Displays "Two Sum" question
4. **Bottom Controls**: Navigation arrows and star button

## Test the App

Try these interactions:

- ✅ **Tap the card** → Should flip to show solutions
- ✅ **Swipe left** → Should go to next question
- ✅ **Tap star** → Should turn yellow (mastered)
- ✅ **Tap filter icon** → Opens filter screen
- ✅ **Tap chart icon** → Opens progress screen
- ✅ **Switch tabs** → Toggle between Brute Force and Optimized
- ✅ **Tap "View Code"** → Expands code section

## Troubleshooting

### "Flutter command not found"

**Solution**: Flutter is not installed or not in PATH. Follow installation steps above.

### "No devices found"

**Solution**:
```bash
# For iOS
open -a Simulator

# For Chrome
flutter run -d chrome

# For Android
flutter emulators --launch Pixel_5_API_33
```

### "Pod install failed" (iOS)

**Solution**:
```bash
cd ios
pod install
cd ..
flutter run
```

### Dependencies error

**Solution**:
```bash
flutter clean
flutter pub get
flutter run
```

## Next Steps

Once the app is running:

1. **Explore the questions**: Navigate through all 5 questions
2. **Try filtering**: Filter by difficulty or category
3. **Mark progress**: Mark some questions as mastered
4. **View analytics**: Check the progress screen

## Project Structure Overview

```
lib/
├── main.dart                      # Start here
├── models/                        # Data structures
├── services/                      # State management
├── screens/                       # Full-screen pages
└── widgets/                       # Reusable components
```

## Development Commands

```bash
# Run in debug mode
flutter run

# Run in release mode (faster)
flutter run --release

# Hot reload (while app is running)
# Press 'r' in terminal

# Hot restart (while app is running)
# Press 'R' in terminal

# Build APK (Android)
flutter build apk

# Build for iOS
flutter build ios
```

## Need Help?

- Check the full README.md for detailed documentation
- Run `flutter doctor` to diagnose issues
- Visit https://flutter.dev/docs for Flutter documentation

---

Happy coding! 🚀
