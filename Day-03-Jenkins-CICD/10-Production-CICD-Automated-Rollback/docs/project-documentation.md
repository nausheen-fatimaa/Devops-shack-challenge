\# Production CI/CD with Automated Rollback



\## Objective



The objective is to implement a production-style CI/CD pipeline for the JioHotstar application using Jenkins and Docker.



\## Problem



A bad application release can cause production downtime.



A production pipeline should therefore:



\- Build the application

\- Test the application

\- Create a Docker image

\- Deploy the new version

\- Verify application health

\- Automatically restore the previous version if deployment fails



\## Solution



Jenkins performs all deployment steps automatically.



\## Architecture



Developer

↓

GitHub

↓

Jenkins

↓

npm install

↓

npm test

↓

npm run build

↓

Docker Build

↓

Docker Container

↓

Health Check

↓

Production



\## Rollback



If the health check fails:



New Version

↓

FAILED

↓

Stop Container

↓

Previous Stable Image

↓

Start Container

↓

Health Check

↓

Production Restored



\## Files



\### Dockerfile



Builds the application and packages the production build into Nginx.



\### nginx.conf



Serves the application and provides the health endpoint.



\### Jenkinsfile



Defines the complete CI/CD pipeline.



\### deploy.bat



Deploys a Docker image.



\### health-check.bat



Checks whether the application is healthy.



\### rollback.bat



Restores the previous Docker image.



\## Production Concepts Demonstrated



\- Continuous Integration

\- Continuous Deployment

\- Docker image versioning

\- Health checks

\- Deployment validation

\- Automated rollback

\- Jenkins pipeline

\- Production failure handling

