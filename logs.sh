#!/bin/bash
# Stream Happy Server logs

echo "=== Happy Server Logs (Ctrl+C to stop) ==="
docker logs -f happy-server
