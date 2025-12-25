# Happy Self-Hosted

Self-host [Happy Engineering](https://happy.engineering/) to control Claude Code from your phone without any data going through third-party servers.

## What's Included

- **happy-server** - The relay server (runs in Docker)
- **happy-app** - Modified mobile app source (points to your server)
- **Pre-built APK** - Ready to install on Android
- **Scripts** - Easy start/stop for Mac and Windows

## Quick Start

### Prerequisites

- **Mac**: Docker (via Colima or Docker Desktop)
- **Windows**: Docker Desktop
- **Both**: Node.js 20+, Tailscale (for permanent URLs)

### 1. Install Tailscale (Recommended)

Gives you a permanent URL that never changes.

**Mac:**
```bash
brew install tailscale
sudo tailscale up
```

**Windows:**
Download from https://tailscale.com/download/windows

**Phone:**
Install Tailscale from Play Store/App Store

Sign in with the **same account** on all devices.

### 2. Install Happy CLI

```bash
npm install -g happy-coder
```

### 3. Start the Server

**Mac:**
```bash
cd ~/happy-self-hosted
./start-tailscale.sh
```

**Windows:**
```powershell
cd C:\happy-self-hosted
start-tailscale.bat
```

This will show your permanent server URL (e.g., `http://100.64.0.1:3005`).

### 4. Install the Android App

Install `HappySelfHosted-Release.apk` on your Android device.

Or build from source:
```bash
cd happy-app
yarn install
cd android
./gradlew assembleRelease
```

### 5. Configure the App

1. Open the Happy app on your phone
2. Go to **Settings → Server URL**
3. Enter your Tailscale URL: `http://100.x.x.x:3005`

### 6. Run Claude

**Mac:**
```bash
./run-happy.sh
```

**Windows:**
```powershell
run-happy.bat
```

Scan the QR code with your phone to connect, then control Claude from anywhere!

## Multi-Device Setup

You can run this on multiple computers. Each gets its own Tailscale IP:

| Device | Tailscale IP | Server URL |
|--------|--------------|------------|
| Mac | 100.64.0.1 | http://100.64.0.1:3005 |
| Windows | 100.64.0.2 | http://100.64.0.2:3005 |

Switch between them in the app's Settings → Server URL.

## Scripts Reference

| Script | Mac | Windows | Description |
|--------|-----|---------|-------------|
| Start server | `./start-tailscale.sh` | `start-tailscale.bat` | Start Docker + show URL |
| Run Claude | `./run-happy.sh` | `run-happy.bat` | Start Claude with Happy |
| Stop server | `./stop.sh` | `stop.bat` | Stop Docker containers |

## Without Tailscale

If you don't want Tailscale, you can use temporary Cloudflare tunnels:

```bash
./start.sh  # Uses cloudflared for temporary URL
```

Note: The URL changes every time you restart.

## Architecture

```
┌─────────────┐     ┌─────────────────┐     ┌─────────────┐
│   Phone     │◄───►│  Happy Server   │◄───►│  Happy CLI  │
│  (App)      │     │  (Docker)       │     │  (Claude)   │
└─────────────┘     └─────────────────┘     └─────────────┘
      │                     │                      │
      └─────────────────────┴──────────────────────┘
                    Your Network (Tailscale)
```

All data stays on your network. Nothing goes to external servers.

## Troubleshooting

### Server won't start
```bash
# Check Docker is running
docker ps

# Check server health
curl http://localhost:3005/health
```

### App can't connect
1. Make sure Tailscale is connected on both devices
2. Verify the server URL in Settings matches your Tailscale IP
3. Check that port 3005 isn't blocked

### Tool calls not showing on phone
Make sure you're running `./run-happy.sh` (not `claude` directly). The Happy CLI wrapper is what streams data to your phone.

## Credits

Based on [Happy Engineering](https://happy.engineering/) - the original Claude Code mobile client.

## License

MIT
