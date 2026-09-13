# 04 - Multi-Environment CI/CD Pipeline

## 📌 Project Overview

This project demonstrates deployment of an application through multiple environments.

The application progresses through:

```text
Development → Staging → Production
```

This approach allows applications to be tested before production deployment.

## 🏗️ Architecture

```text
Developer
    |
    v
 GitHub
    |
    v
 Jenkins
    |
    v
 Build + Test
    |
    v
 Docker Image
    |
    v
 Development
    |
    v
 Staging
    |
    v
 Approval
    |
    v
 Production
```

## 📂 Project Structure

```text
04-Multi-Environment-CICD-Pipeline/
├── environments/
│   ├── dev/
│   │   └── deployment.yaml
│   ├── staging/
│   │   └── deployment.yaml
│   └── production/
│       └── deployment.yaml
├── Jenkinsfile
├── Dockerfile
├── README.md
├── docs/
│   └── environment-strategy.md
└── screenshots/
    ├── dev.png
    ├── staging.png
    └── production.png
```

## 🌎 Environments

### Development

Used for initial testing.

```text
DEV
```

### Staging

Used to validate the application before production.

```text
STAGING
```

### Production

The final environment used by end users.

```text
PRODUCTION
```

## 🔄 Pipeline

```text
Checkout
   ↓
Build
   ↓
Test
   ↓
Docker Build
   ↓
Deploy DEV
   ↓
Deploy STAGING
   ↓
Manual Approval
   ↓
Deploy PRODUCTION
```

## 🛡️ Production Approval

Production deployment should require manual approval.

This prevents accidental production deployments.

## 🎯 Learning Outcomes

* CI/CD
* Environment management
* Deployment promotion
* Jenkins approval gates
* Dev → Staging → Production workflow
* Release management

## 🔮 Future Improvements

* Kubernetes
* Blue/Green deployment
* Canary deployment
* Automated rollback
* Security scanning
* Infrastructure as Code
