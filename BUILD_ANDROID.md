# Building Your Self-Hosted Happy Android App

Your app is configured to connect to your self-hosted server at:
`https://few-lots-xml-mills.trycloudflare.com`

## Option 1: Cloud Build with Expo (Easiest - Free)

1. Create a free Expo account at https://expo.dev/signup

2. Login to EAS:
```bash
cd ~/happy-self-hosted/happy-app
npx eas-cli login
```

3. Create your own EAS project:
```bash
npx eas-cli init
```
(Follow prompts to create a new project)

4. Update eas.json for local APK build:
```bash
cat > eas.json << 'EOF'
{
  "cli": {
    "version": ">= 14.2.0"
  },
  "build": {
    "production": {
      "android": {
        "buildType": "apk"
      }
    }
  }
}
EOF
```

5. Build the APK:
```bash
npx eas-cli build --platform android --profile production --local
```

The APK will be downloaded to the current directory.

---

## Option 2: Local Build with Android Studio

1. Install Android Studio from https://developer.android.com/studio

2. Generate native Android project:
```bash
cd ~/happy-self-hosted/happy-app
yarn prebuild
```

3. Open in Android Studio:
```bash
open -a "Android Studio" android
```

4. Build → Generate Signed Bundle/APK → APK

---

## After Building

1. Transfer the APK to your Android phone

2. Install it (you may need to enable "Install from unknown sources")

3. The app will automatically connect to your self-hosted server

---

## Updating Server URL

If your tunnel URL changes, you have two options:

### Option A: In-App Settings
1. Open the app
2. Go to Settings → Server
3. Enter the new URL

### Option B: Rebuild with New URL
Edit `sources/sync/serverConfig.ts` and change the URL, then rebuild.

---

## Files Modified for Self-Hosting

| File | Change |
|------|--------|
| `sources/sync/serverConfig.ts` | Default server URL |
| `app.config.js` | App name, bundle ID, removed analytics |

Your app has NO analytics or telemetry - 100% private!
