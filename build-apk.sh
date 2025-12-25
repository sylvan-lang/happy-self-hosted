#!/bin/bash
set -e

export JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home
export ANDROID_HOME=/Users/sylvangrunwald/Library/Android/sdk
export PATH=$JAVA_HOME/bin:$ANDROID_HOME/platform-tools:$PATH

cd /Users/sylvangrunwald/happy-self-hosted/happy-app/android

echo "Java version:"
java -version

echo ""
echo "Building APK..."
./gradlew assembleDebug --stacktrace

echo ""
echo "Build complete!"
echo "APK location:"
find /Users/sylvangrunwald/happy-self-hosted/happy-app/android -name "*.apk" -type f 2>/dev/null
