@echo off
REM Run Happy CLI connected to your self-hosted server

REM Load the saved URL
if exist "%USERPROFILE%\.happy-server-url.bat" (
    call "%USERPROFILE%\.happy-server-url.bat"
)

if not defined HAPPY_SERVER_URL (
    echo Error: HAPPY_SERVER_URL is not set.
    echo.
    echo Please run start-tailscale.bat first to start the server.
    pause
    exit /b 1
)

echo ==========================================
echo Happy Self-Hosted - Remote Claude Control
echo ==========================================
echo.
echo Server: %HAPPY_SERVER_URL%
echo.
echo Starting Claude with Happy integration...
echo Tool calls will stream to your phone!
echo.
echo ==========================================
echo.

happy %*
