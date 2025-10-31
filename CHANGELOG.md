# Changelog

## [1.0.4] - 2025-10-30

### Added
- **App Icon Design**: Created professional app icon for the flashcard app
  - Blue gradient background matching app theme
  - White flashcard with code brackets `{ }` symbol
  - SVG source file included: `app_icon.svg`
  - Detailed setup instructions: `ADD_APP_ICON.md`
  - Design documentation: `APP_ICON_DESIGN.md`
- **Files Added**: `app_icon.svg`, `ADD_APP_ICON.md`, `APP_ICON_DESIGN.md`
- **App Icon Installed**: Icon assets successfully copied to `ios/Runner/Assets.xcassets/AppIcon.appiconset/`
  - 12 icon sizes covering all iOS requirements
  - Ready to display on home screen after rebuild

### Status
✅ Icon fully installed - Run `flutter clean && flutter run` to see it!

---

## [1.0.3] - 2025-10-30

### Changed
- **Solution Layout**: Reordered content on answer side for better readability
  - **New order**: Explanation → View Code Button → Approach (step-by-step)
  - **Previous order**: Approach → View Code Button → Explanation
  - Rationale: Users see high-level explanation first, then code, then detailed steps
- **File Modified**: `lib/widgets/flashcard_widget.dart`

---

## [1.0.2] - 2025-10-30

### Fixed
- **Flip Animation Bug**: Fixed card flip animation not showing back side (solution)
  - Simplified 3D transform logic using `Visibility` widget
  - Fixed mirrored/reversed text issue on back side
  - Added proper state sync between animation controller and provider
  - Card now properly resets to front when navigating between questions
- **File Modified**: `lib/widgets/flashcard_widget.dart`

### Testing
- Verified on iOS Simulator
- All interactions working: tap to flip, swipe navigation, tab switching
- See `TESTING_GUIDE.md` for complete testing checklist

---

## [1.0.1] - 2025-10-30

### Fixed
- **Deprecated API**: Replaced all `withOpacity()` calls with `withValues(alpha:)` to fix deprecation warnings
  - Updated `filter_screen.dart` (1 occurrence)
  - Updated `home_screen.dart` (2 occurrences)
  - Updated `progress_screen.dart` (2 occurrences)
- Total fixes: 5 deprecation warnings resolved

### Details
The Flutter SDK deprecated `Color.withOpacity()` in favor of `Color.withValues(alpha:)` to avoid precision loss. All instances have been updated to use the new API.

**Before:**
```dart
color: Colors.blue.withOpacity(0.3)
```

**After:**
```dart
color: Colors.blue.withValues(alpha: 0.3)
```

### Files Modified
1. `lib/screens/filter_screen.dart` - Line 140
2. `lib/screens/home_screen.dart` - Lines 80, 144
3. `lib/screens/progress_screen.dart` - Lines 74, 100

### Breaking Changes
None - All changes are internal and backward compatible.

---

## [1.0.0] - 2025-10-30

### Added
- Initial release of LeetCode Flashcards Flutter app
- 5 complete NeetCode 150 questions with solutions
- 3D flip animation for flashcards
- Tabbed solution view (Brute Force / Optimized)
- Step-by-step approach explanations
- Collapsible code sections
- Smart filtering by difficulty and category
- Progress tracking with detailed analytics
- Persistent storage using SharedPreferences
- Material Design 3 UI
- Cross-platform support (iOS, Android, Web, Desktop)

### Features
- **Models**: Complete data structures with JSON serialization
- **State Management**: Provider pattern for reactive updates
- **Screens**: Home, Filter, and Progress views
- **Widgets**: Custom flashcard widget with animations
- **Documentation**: Comprehensive README and Quick Start guide
