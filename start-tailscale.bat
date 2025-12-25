@echo off
REM Happy Self-Hosted - Windows Startup Script (Tailscale version)

echo Starting Happy Self-Hosted Server...

REM Start Docker containers
echo Starting Docker containers...
cd /d %~dp0
docker compose up -d

REM Wait for server to be healthy
echo Waiting for server to be ready...
:waitloop
timeout /t 2 /nobreak >nul
curl -s http://localhost:3005/health >nul 2>&1
if errorlevel 1 goto waitloop
echo Server is healthy!

REM Get Tailscale IP
for /f "tokens=*" %%i in ('tailscale ip -4 2^>nul') do set TAILSCALE_IP=%%i

if defined TAILSCALE_IP (
    set SERVER_URL=http://%TAILSCALE_IP%:3005
    echo.
    echo ==========================================
    echo Happy Server is running!
    echo ==========================================
    echo.
    echo Tailscale URL: %SERVER_URL%
    echo.
    echo To use with Happy CLI:
    echo   set HAPPY_SERVER_URL=%SERVER_URL%
    echo   happy
    echo.
    echo Or just run: run-happy.bat
    echo.
    echo On your phone app:
    echo   Settings -^> Server URL -^> %SERVER_URL%
    echo.
    echo ==========================================

    REM Save for run-happy.bat
    echo set HAPPY_SERVER_URL=%SERVER_URL%> "%USERPROFILE%\.happy-server-url.bat"
) else (
    echo.
    echo ==========================================
    echo Happy Server is running on localhost:3005
    echo ==========================================
    echo.
    echo Tailscale not detected. Install from:
    echo   https://tailscale.com/download/windows
    echo.
    echo ==========================================
)

pause
