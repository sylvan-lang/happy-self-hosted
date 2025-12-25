#!/bin/bash
# Run Happy CLI connected to your self-hosted server
# This streams Claude's tool calls and thinking to your phone

# Load the tunnel URL
if [ -f ~/.happy-server-url ]; then
    source ~/.happy-server-url
fi

# Check if tunnel URL is set
if [ -z "$HAPPY_SERVER_URL" ]; then
    echo "Error: HAPPY_SERVER_URL is not set."
    echo ""
    echo "Please run ./start.sh first to start the server and get the tunnel URL."
    echo "Or manually set: export HAPPY_SERVER_URL=https://your-tunnel.trycloudflare.com"
    exit 1
fi

echo "=========================================="
echo "Happy Self-Hosted - Remote Claude Control"
echo "=========================================="
echo ""
echo "Server: $HAPPY_SERVER_URL"
echo ""
echo "Starting Claude with Happy integration..."
echo "Tool calls and thinking will stream to your phone!"
echo ""
echo "=========================================="
echo ""

# Run happy CLI with the self-hosted server
HAPPY_SERVER_URL="$HAPPY_SERVER_URL" happy "$@"
