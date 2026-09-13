@echo off

set PREVIOUS_IMAGE=%1
set CONTAINER_NAME=jiohotstar-prod

echo ==========================================
echo AUTOMATED ROLLBACK
echo ==========================================

echo Previous image:
echo %PREVIOUS_IMAGE%

docker rm -f %CONTAINER_NAME% >nul 2>&1

docker run -d ^
  --name %CONTAINER_NAME% ^
  -p 8081:80 ^
  %PREVIOUS_IMAGE%

if errorlevel 1 (
    echo Rollback deployment FAILED.
    exit /b 1
)

echo Previous version started.

timeout /t 5 /nobreak >nul

curl.exe --fail --silent --show-error http://localhost:8081/health

if errorlevel 1 (
    echo Rollback health check FAILED.
    exit /b 1
)

echo.
echo ==========================================
echo ROLLBACK SUCCESSFUL
echo ==========================================

exit /b 0