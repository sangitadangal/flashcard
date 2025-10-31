# Fix: iOS Devices Not Supported

## The Problem

You're seeing this error:
```
The following devices were found, but are not supported by this project:
Sushan's iPhone (mobile) • 00008110-0011302C1199801E • ios • iOS 26.0.1
iPhone 16e (mobile)      • 3EAF1A5E-C4B1-4BE8-B3B6-2AAE496B80D1 • ios • (simulator)
```

**Why?** The iOS platform files (`ios/` folder) weren't generated because the project was created manually without the `flutter create` command.

## The Solution (2 Options)

### Option 1: Automated Script (Easiest) ⭐

Run the automated setup script:

```bash
cd /Users/sangitadangal/claude-projects/flutter-projects/flashcard
./setup_ios.sh
```

This will:
- Generate iOS and Android platform files
- Update iOS deployment target to 17.0
- Install CocoaPods dependencies
- Verify everything is ready

### Option 2: Manual Steps

```bash
# 1. Generate platform files
cd /Users/sangitadangal/claude-projects/flutter-projects/flashcard
flutter create --platforms=ios,android .

# 2. Install iOS dependencies
cd ios
pod install
cd ..

# 3. Check devices (should now show as supported)
flutter devices

# 4. Run on your iPhone
flutter run
```

## What Gets Created

After running the setup, you'll have:

```
flashcard/
├── ios/                          ← NEW
│   ├── Runner.xcworkspace        ← Xcode workspace
│   ├── Runner.xcodeproj          ← Xcode project
│   ├── Podfile                   ← CocoaPods config
│   └── Runner/
│       ├── Info.plist            ← App metadata
│       └── Assets.xcassets       ← App icons
├── android/                      ← NEW
│   └── app/
│       └── build.gradle
└── lib/                          ← UNCHANGED (your code is safe!)
    ├── main.dart
    ├── models/
    ├── screens/
    └── widgets/
```

## Important Notes

✅ **Your code is safe** - The `flutter create` command will NOT overwrite your `lib/` folder or any Dart code

✅ **Dependencies preserved** - Your `pubspec.yaml` will not be changed

✅ **Works for both** - Physical iPhone and Simulator

## After Setup: Running on Physical iPhone

Once iOS files are generated, you need to configure code signing:

### 1. Open in Xcode
```bash
open ios/Runner.xcworkspace
```

### 2. Configure Signing
1. Select **Runner** in left sidebar
2. Select **Runner** under TARGETS
3. Go to **Signing & Capabilities** tab
4. ✅ Check **"Automatically manage signing"**
5. Select your **Team** (Apple ID)
6. Change **Bundle Identifier** to something unique:
   - Example: `com.sushandangal.flashcard`

### 3. Trust on iPhone (First Time Only)
1. App installs but shows "Untrusted Developer"
2. iPhone: **Settings → General → VPN & Device Management**
3. Tap your Apple ID → **Trust**

### 4. Run
```bash
flutter run
```

## Verification

After setup, `flutter devices` should show:

```
✅ Sushan's iPhone (mobile) • 00008110-0011302C1199801E • ios • iOS 26.0.1 (supported)
✅ iPhone 16e (mobile)      • 3EAF1A5E-C4B1-4BE8-B3B6-2AAE496B80D1 • ios • (supported)
```

## Quick Command Reference

```bash
# Setup
./setup_ios.sh

# Check devices
flutter devices

# Run on any device (auto-select)
flutter run

# Run on specific device
flutter run -d "Sushan's iPhone"

# Run on simulator
flutter run -d "iPhone 16e"

# Open Xcode (for signing)
open ios/Runner.xcworkspace
```

## Troubleshooting

### "flutter: command not found"
```bash
# Find flutter
which flutter

# Or search for it
find ~ -name flutter -type f 2>/dev/null | grep bin/flutter

# Add to PATH in ~/.zshrc
export PATH="$PATH:/path/to/flutter/bin"
source ~/.zshrc
```

### "CocoaPods not installed"
```bash
sudo gem install cocoapods
```

### "No provisioning profile"
- Open `ios/Runner.xcworkspace` in Xcode
- Follow code signing steps above

### Still not working?
See detailed guide: **SETUP_IOS.md**

---

**Summary:** Run `./setup_ios.sh` to generate iOS files, then you can run on your iPhone! 📱
