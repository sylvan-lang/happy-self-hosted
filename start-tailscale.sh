#!/bin/bash
# Happy Self-Hosted - Startup Script (Tailscale version)
# Use this for a permanent URL that works across devices

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

# Get Tailscale IP
TAILSCALE_IP=$(tailscale ip -4 2>/dev/null || echo "")

if [ -n "$TAILSCALE_IP" ]; then
    SERVER_URL="http://${TAILSCALE_IP}:3005"

    echo ""
    echo "=========================================="
    echo "Happy Server is running!"
    echo "=========================================="
    echo ""
    echo "Tailscale URL: $SERVER_URL"
    echo ""
    echo "To use with Happy CLI:"
    echo "  export HAPPY_SERVER_URL=\"$SERVER_URL\""
    echo "  happy"
    echo ""
    echo "Or just run: ./run-happy.sh"
    echo ""
    echo "On your phone app:"
    echo "  Settings -> Server URL -> $SERVER_URL"
    echo ""
    echo "=========================================="

    # Save for run-happy.sh
    echo "export HAPPY_SERVER_URL=\"$SERVER_URL\"" > ~/.happy-server-url
else
    echo ""
    echo "=========================================="
    echo "Happy Server is running on localhost:3005"
    echo "=========================================="
    echo ""
    echo "Tailscale not detected. To get a permanent URL:"
    echo "  brew install tailscale"
    echo "  sudo tailscale up"
    echo ""
    echo "Then restart this script."
    echo "=========================================="
fi
