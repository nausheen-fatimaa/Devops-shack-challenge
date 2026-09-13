@echo off
set IMAGE_NAME=%1
set CONTAINER_NAME=jiohotstar-prod

echo ==========================================
echo Deploying %IMAGE_NAME%
echo ==========================================

docker rm -f %CONTAINER_NAME% >nul 2>&1

docker run -d ^
  --name %CONTAINER_NAME% ^
  -p 8081:80 ^
  %IMAGE_NAME%

if errorlevel 1 (
    echo Deployment failed.
    exit /b 1
)

echo Container started successfully.
exit /b 0