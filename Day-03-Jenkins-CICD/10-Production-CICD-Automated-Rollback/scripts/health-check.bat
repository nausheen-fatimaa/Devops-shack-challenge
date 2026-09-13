@echo off

echo ==========================================
echo Running Health Check
echo ==========================================

curl.exe --fail --silent --show-error http://localhost:8081/health

if errorlevel 1 (
    echo Health check FAILED.
    exit /b 1
)

echo.
echo Health check PASSED.

exit /b 0