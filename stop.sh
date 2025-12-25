#!/bin/bash
# Happy Self-Hosted - Stop Script

echo "Stopping Happy Self-Hosted Server..."

# Stop tunnel
if [ -f /tmp/happy-tunnel.pid ]; then
    kill $(cat /tmp/happy-tunnel.pid) 2>/dev/null || true
    rm /tmp/happy-tunnel.pid
    echo "Tunnel stopped"
fi

# Stop Docker containers
cd ~/happy-self-hosted
docker compose down
echo "Containers stopped"

echo "Done!"
