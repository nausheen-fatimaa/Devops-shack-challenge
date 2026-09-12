# 10 - Production CI/CD with Automated Rollback

## 🚀 Project Overview

This is the final production-style CI/CD project.

It combines multiple DevOps practices into a single automated pipeline.

The pipeline includes:

* GitHub
* Jenkins
* Maven
* Unit testing
* SonarQube
* Security scanning
* Docker
* Kubernetes
* Health checks
* Automated rollback

## 🏗️ Complete Architecture

```text
                    GitHub
                       |
                       v
                    Jenkins
                       |
        +--------------+--------------+
        |              |              |
        v              v              v
      Build          Testing       Security
        |              |              |
        +--------------+--------------+
                       |
                       v
                  SonarQube
                       |
                       v
                 Quality Gate
                       |
                       v
                  Docker Build
                       |
                       v
                 Security Scan
                       |
                       v
               Kubernetes Deploy
                       |
                       v
                 Health Check
                       |
             +---------+---------+
             |                   |
          HEALTHY             FAILED
             |                   |
             v                   v
        Production          Rollback
```

## 📂 Project Structure

```text
10-Production-CICD-Automated-Rollback/
├
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── configmap.yaml
│   └── probes.yaml
├── scripts/
│   ├── deploy.bat
│   ├── health-check.bat
│   ├── rollback.bat
│   └── verify-deployment.bat
├── security/
│   └── security-scan.bat
├── Dockerfile
├── Jenkinsfile
├── README.md
├── docs/
│   ├── architecture.md
│   ├── deployment-strategy.md
│   └── rollback-strategy.md
├── reports/
│   ├── test-results/
│   └── security-results/
└── screenshots/
    ├── pipeline-success.png
    ├── production-deployment.png
    ├── health-check.png
    └── rollback.png
```

## 🔄 Complete Pipeline

### Stage 1 - Checkout

Jenkins retrieves the source code from GitHub.

### Stage 2 - Build

Maven builds the application.

```bash
mvn clean package
```

### Stage 3 - Unit Testing

Automated tests are executed.

```bash
mvn test
```

### Stage 4 - SonarQube

Source code is analyzed for quality and security issues.

### Stage 5 - Quality Gate

The pipeline verifies the SonarQube Quality Gate.

### Stage 6 - Docker Build

A container image is created.

```bash
docker build -t myapp:VERSION .
```

### Stage 7 - Security Scan

The Docker image and dependencies are scanned for vulnerabilities.

### Stage 8 - Kubernetes Deployment

The new application version is deployed to Kubernetes.

### Stage 9 - Health Check

The application is checked after deployment.

### Stage 10 - Rollback

If deployment or health checks fail, Kubernetes can roll back to the previous working version.

## 🔄 Kubernetes Rollout

Check deployment:

```bash
kubectl rollout status deployment/application
```

View deployment history:

```bash
kubectl rollout history deployment/application
```

Rollback:

```bash
kubectl rollout undo deployment/application
```

## ❤️ Health Checks

Kubernetes probes can be used to determine application health.

Typical probes include:

```text
Liveness Probe
Readiness Probe
Startup Probe
```

## 🚨 Automated Rollback Concept

```text
Deploy New Version
       |
       v
Health Check
       |
   +---+---+
   |       |
 PASS    FAIL
   |       |
   v       v
Continue  Rollback
           |
           v
      Previous Version
```

## 🔐 Security

Never commit:

```text
Passwords
API Keys
AWS Credentials
Docker Credentials
Jenkins Tokens
SonarQube Tokens
Private Keys
```

Use Jenkins Credentials or an appropriate secret-management system.

## 🎯 Learning Outcomes

After completing this project, you should understand:

* Production CI/CD
* Jenkins pipelines
* Maven
* Unit testing
* SonarQube
* Quality Gates
* Docker
* Security scanning
* Kubernetes
* Health checks
* Deployment strategies
* Automated rollback

## 🏆 Final DevOps Pipeline

```text
GitHub
   ↓
Jenkins
   ↓
Build
   ↓
Test
   ↓
SonarQube
   ↓
Quality Gate
   ↓
Security Scan
   ↓
Docker Build
   ↓
Docker Registry
   ↓
Kubernetes
   ↓
Health Check
   ↓
Production
   ↓
Automatic Rollback if Failure
```

## 🔮 Future Improvements

* AWS deployment
* Terraform infrastructure
* Prometheus monitoring
* Grafana dashboards
* Slack/Email notifications
* Canary deployments
* GitOps with Argo CD
* Advanced Kubernetes security
* Disaster recovery
