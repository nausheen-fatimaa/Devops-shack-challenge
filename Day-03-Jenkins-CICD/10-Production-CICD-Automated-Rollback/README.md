# Production CI/CD with Automated Rollback

## Project Overview

This project demonstrates a production-style CI/CD pipeline using Jenkins, Docker and automated health checks.

The pipeline automatically builds, tests, packages and deploys the JioHotstar application.

If the newly deployed version fails the health check, Jenkins automatically rolls back to the previous stable version.

## Technologies Used

- Git
- GitHub
- Jenkins
- Node.js
- npm
- Docker
- Nginx
- Windows
- CI/CD
- Automated Rollback

## Pipeline Flow

GitHub
↓
Jenkins
↓
Checkout
↓
Install Dependencies
↓
Testing
↓
Application Build
↓
Docker Build
↓
Production Deployment
↓
Health Check
↓
Success / Automated Rollback

## Docker Images

Example:

jiohotstar:1
jiohotstar:2
jiohotstar:3

## Rollback Strategy

The currently running production version is preserved as the previous stable image.

If a newly deployed version fails its health check:

1. New container is stopped.
2. Previous image is started.
3. Health check is executed again.
4. Previous version becomes the active production version.

## Health Check

The application exposes:

/health

Expected response:

OK

## Expected Result

Successful deployment:

Build → Test → Docker → Deploy → Health Check → SUCCESS

Failed deployment:

Build → Test → Docker → Deploy → Health Check FAILED → Rollback → Previous Version Restored