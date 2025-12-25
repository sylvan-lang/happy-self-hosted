#!/bin/bash
export JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home
export ANDROID_HOME=~/Library/Android/sdk
export PATH=$JAVA_HOME/bin:$PATH

echo "Java version:"
java -version

echo ""
echo "Accepting licenses..."
yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --licenses

echo ""
echo "Installing platform-tools..."
$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platform-tools"

echo ""
echo "Installing Android 34 platform..."
$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platforms;android-34"

echo ""
echo "Installing build-tools..."
$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "build-tools;34.0.0"

echo ""
echo "Done! SDK installed at: $ANDROID_HOME"
ls -la $ANDROID_HOME
