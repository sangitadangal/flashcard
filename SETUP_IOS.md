# iOS Setup Guide

## Issue: iOS Platform Files Missing

You're seeing this error because the iOS platform files weren't generated when the project was created manually.

```
The following devices were found, but are not supported by this project:
Sushan's iPhone (mobile) • 00008110-0011302C1199801E • ios • iOS 26.0.1
```

## Solution: Generate iOS Platform Files

Run this command in your project directory to generate all necessary iOS files:

```bash
cd /Users/sangitadangal/claude-projects/flutter-projects/flashcard

# Generate iOS and Android platform files
flutter create --platforms=ios,android .
```

This will create:
- `ios/` folder with Xcode project
- `android/` folder with Android project
- All necessary configuration files

**Important:** This command will NOT overwrite your existing `lib/` folder or Dart code!

## Step-by-Step Instructions

### 1. Generate Platform Files

```bash
cd /Users/sangitadangal/claude-projects/flutter-projects/flashcard
flutter create --platforms=ios,android .
```

You'll see output like:
```
Creating project flashcard...
  ios/Runner.xcworkspace (created)
  ios/Runner.xcodeproj (created)
  ios/Podfile (created)
  android/app/build.gradle (created)
  ...
```

### 2. Update iOS Deployment Target for iOS 26

After generation, update the deployment target:

**Option A: Edit Podfile**
```bash
# Open Podfile
open ios/Podfile
```

Change line 2 to:
```ruby
platform :ios, '17.0'
```

**Option B: Use Xcode**
```bash
# Open in Xcode
open ios/Runner.xcworkspace
```

Then:
1. Select **Runner** in the left sidebar
2. Go to **General** tab
3. Set **Minimum Deployments** to **iOS 17.0**
4. Go to **Build Settings** tab
5. Search for "deployment target"
6. Set **iOS Deployment Target** to **17.0**

### 3. Install CocoaPods Dependencies

```bash
cd ios
pod install
cd ..
```

### 4. Check Devices Again

```bash
flutter devices
```

You should now see your devices as **supported**:
```
Sushan's iPhone (mobile) • 00008110-0011302C1199801E • ios • iOS 26.0.1 (supported)
iPhone 16e (mobile)      • 3EAF1A5E-C4B1-4BE8-B3B6-2AAE496B80D1 • ios • (supported)
```

### 5. Run on Your iPhone

```bash
flutter run
```

Or specify the device:
```bash
flutter run -d "00008110-0011302C1199801E"
```

## Complete Command Sequence

Here's everything in order:

```bash
# Navigate to project
cd /Users/sangitadangal/claude-projects/flutter-projects/flashcard

# Generate iOS/Android files (safe - won't overwrite lib/)
flutter create --platforms=ios,android .

# Install iOS dependencies
cd ios
pod install
cd ..

# Check devices
flutter devices

# Run on iPhone
flutter run
```

## For Physical iPhone: Code Signing

If running on your physical iPhone (Sushan's iPhone), you'll need to set up code signing:

### 1. Open Xcode

```bash
open ios/Runner.xcworkspace
```

### 2. Configure Signing

1. Select **Runner** in the left sidebar
2. Select **Runner** target (under TARGETS)
3. Go to **Signing & Capabilities** tab
4. Check **"Automatically manage signing"**
5. Select your **Team** (Apple ID)
6. Change **Bundle Identifier** to something unique:
   - Example: `com.yourname.flashcard`

### 3. Trust Developer on iPhone

First time running:
1. App will install but show "Untrusted Developer"
2. On iPhone: **Settings → General → VPN & Device Management**
3. Tap your Apple ID
4. Tap **"Trust"**
5. Run `flutter run` again

## Troubleshooting

### Issue: "flutter: command not found"

**Solution:**
```bash
# Find flutter
find ~ -name flutter -type f 2>/dev/null | grep bin/flutter

# Add to PATH (add to ~/.zshrc or ~/.bash_profile)
export PATH="$PATH:/path/to/flutter/bin"

# Reload shell
source ~/.zshrc
```

### Issue: "CocoaPods not installed"

**Solution:**
```bash
sudo gem install cocoapods
```

### Issue: "iOS deployment target too low"

The error you're seeing happens when deployment target is below iOS 17.0.

**Solution:** Follow Step 2 above to set deployment target to iOS 17.0

### Issue: "No provisioning profile"

**Solution:**
1. Open `ios/Runner.xcworkspace` in Xcode
2. Set up code signing (see "For Physical iPhone" section above)

## Why This Happened

When I created the Flutter project manually (because `flutter` command wasn't available), I created:
- ✅ `lib/` folder with all Dart code
- ✅ `pubspec.yaml` with dependencies
- ❌ `ios/` folder (needs `flutter create`)
- ❌ `android/` folder (needs `flutter create`)

The `flutter create --platforms=ios,android .` command will add the missing platform files without touching your Dart code.

## Verification

After running `flutter create`, you should have:

```
flashcard/
├── lib/                  ✅ (existing - untouched)
├── ios/                  ✅ (newly generated)
│   ├── Runner.xcworkspace
│   ├── Runner.xcodeproj
│   ├── Podfile
│   └── Runner/
│       └── Info.plist
├── android/              ✅ (newly generated)
├── pubspec.yaml          ✅ (existing - untouched)
└── README.md             ✅ (existing - untouched)
```

## Next Steps

Once iOS files are generated:

1. ✅ Run `flutter create --platforms=ios,android .`
2. ✅ Set iOS deployment target to 17.0
3. ✅ Run `pod install` in ios/ folder
4. ✅ Configure code signing (for physical device)
5. ✅ Run `flutter run`

Your app will then run on both simulator and physical iPhone! 📱
