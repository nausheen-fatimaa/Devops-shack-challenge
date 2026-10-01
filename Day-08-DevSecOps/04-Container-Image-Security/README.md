# Project 4 — Container Image Security

## Objective
Scan Docker images before registry push/deployment.

## Tool
Trivy

## Run
```bash
docker build -t devsecops-container-demo:1.0 .
trivy image devsecops-container-demo:1.0
trivy image --severity HIGH,CRITICAL --exit-code 1 devsecops-container-demo:1.0
```

The final command intentionally fails the job when High/Critical findings are present.

## Best practices
Use a small base image, update dependencies, run as a non-root user, pin trusted base images where appropriate, and scan continuously.
