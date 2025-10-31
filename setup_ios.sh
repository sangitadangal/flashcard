#!/bin/bash

# Flutter iOS Setup Script
# This script generates iOS platform files and configures deployment target

set -e  # Exit on error

echo "════════════════════════════════════════════════════════════════"
echo "  Flutter iOS Platform Setup"
echo "════════════════════════════════════════════════════════════════"
echo ""

# Check if Flutter is available
if ! command -v flutter &> /dev/null; then
    echo "❌ Error: Flutter command not found"
    echo ""
    echo "Please install Flutter first:"
    echo "  https://flutter.dev/docs/get-started/install"
    echo ""
    echo "Or add Flutter to your PATH:"
    echo "  export PATH=\"\$PATH:/path/to/flutter/bin\""
    exit 1
fi

echo "✅ Flutter found: $(flutter --version | head -n 1)"
echo ""

# Navigate to project directory
cd "$(dirname "$0")"

echo "📁 Current directory: $(pwd)"
echo ""

# Generate iOS and Android platform files
echo "🔨 Generating iOS and Android platform files..."
flutter create --platforms=ios,android .

if [ $? -eq 0 ]; then
    echo "✅ Platform files generated successfully"
else
    echo "❌ Failed to generate platform files"
    exit 1
fi

echo ""

# Check if ios directory was created
if [ -d "ios" ]; then
    echo "✅ iOS directory created"

    # Update Podfile deployment target
    if [ -f "ios/Podfile" ]; then
        echo "🔧 Updating iOS deployment target to 17.0..."
        sed -i '' "s/platform :ios, '[0-9.]*'/platform :ios, '17.0'/" ios/Podfile
        echo "✅ Podfile updated"
    fi

    # Install CocoaPods dependencies
    echo ""
    echo "📦 Installing CocoaPods dependencies..."
    cd ios

    if command -v pod &> /dev/null; then
        pod install
        if [ $? -eq 0 ]; then
            echo "✅ CocoaPods installed successfully"
        else
            echo "⚠️  Pod install failed, but continuing..."
        fi
    else
        echo "⚠️  CocoaPods not found. Install with: sudo gem install cocoapods"
    fi

    cd ..
else
    echo "❌ iOS directory not created"
    exit 1
fi

echo ""
echo "════════════════════════════════════════════════════════════════"
echo "  Setup Complete! ✅"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Next steps:"
echo ""
echo "1. Check available devices:"
echo "   flutter devices"
echo ""
echo "2. Run on iPhone:"
echo "   flutter run"
echo ""
echo "3. Or specify device:"
echo "   flutter run -d \"Sushan's iPhone\""
echo ""
echo "For physical iPhone, set up code signing in Xcode:"
echo "   open ios/Runner.xcworkspace"
echo ""
echo "════════════════════════════════════════════════════════════════"
