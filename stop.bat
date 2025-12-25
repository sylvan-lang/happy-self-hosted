@echo off
REM Stop Happy Self-Hosted Server

echo Stopping Happy Server...
cd /d %~dp0
docker compose down

echo.
echo Server stopped.
pause
