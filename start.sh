#!/bin/bash
# Happy Self-Hosted - Startup Script
# Run this to start your self-hosted Happy server

set -e

echo "Starting Happy Self-Hosted Server..."

# Start Colima if not running
if ! colima status 2>/dev/null | grep -q "Running"; then
    echo "Starting Colima..."
    colima start --cpu 2 --memory 4
fi

# Start the Docker stack
echo "Starting Docker containers..."
cd ~/happy-self-hosted
docker compose up -d

# Wait for server to be healthy
echo "Waiting for server to be ready..."
for i in {1..30}; do
    if curl -s http://localhost:3005/health > /dev/null 2>&1; then
        echo "Server is healthy!"
        break
    fi
    sleep 2
done

# Start Cloudflare tunnel
echo "Starting Cloudflare Tunnel..."
cloudflared tunnel --url http://localhost:3005 2>&1 | tee /tmp/happy-tunnel.log &
TUNNEL_PID=$!
echo $TUNNEL_PID > /tmp/happy-tunnel.pid

# Wait for tunnel URL
sleep 10
TUNNEL_URL=$(grep -o 'https://[a-z0-9-]*\.trycloudflare\.com' /tmp/happy-tunnel.log | head -1)

if [ -n "$TUNNEL_URL" ]; then
    echo ""
    echo "=========================================="
    echo "Happy Server is running!"
    echo "=========================================="
    echo ""
    echo "Public URL: $TUNNEL_URL"
    echo ""
    echo "To use with Happy CLI:"
    echo "  export HAPPY_SERVER_URL=\"$TUNNEL_URL\""
    echo "  happy"
    echo ""
    echo "Configure this URL in your Android Happy app:"
    echo "  Settings -> Server URL -> $TUNNEL_URL"
    echo ""
    echo "=========================================="

    # Update shell config
    echo "export HAPPY_SERVER_URL=\"$TUNNEL_URL\"" > ~/.happy-server-url
else
    echo "Warning: Could not get tunnel URL. Check /tmp/happy-tunnel.log"
fi
