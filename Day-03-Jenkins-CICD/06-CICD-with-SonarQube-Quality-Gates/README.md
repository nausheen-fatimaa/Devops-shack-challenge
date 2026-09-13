# 06 - CI/CD with SonarQube Quality Gates

## 📌 Project Overview

This project integrates SonarQube into a Jenkins CI/CD pipeline.

SonarQube analyzes source code for:

* Bugs
* Vulnerabilities
* Code smells
* Code duplication
* Reliability issues
* Maintainability issues

The pipeline uses a Quality Gate to determine whether the build should continue.

## 🏗️ Architecture

```text
GitHub
   |
   v
Jenkins
   |
   +----> Build
   |
   +----> Unit Tests
   |
   +----> SonarQube Analysis
   |
   +----> Quality Gate
              |
        +-----+-----+
        |           |
       PASS        FAIL
        |           |
        v           v
     Continue      Stop
```

## 📂 Project Structure

```text
06-CICD-with-SonarQube-Quality-Gates/
├── Jenkinsfile
├── sonar-project.properties
├── README.md
├── docs/
│   └── sonarqube-documentation.md
├── reports/
│   └── .gitkeep
└── screenshots/
    ├── sonarqube-dashboard.png
    ├── quality-gate-pass.png
    └── quality-gate-fail.png
```

## 🔄 Pipeline

```text
Checkout
   ↓
Build
   ↓
Unit Tests
   ↓
SonarQube Analysis
   ↓
Quality Gate
   ↓
Continue / Stop
```

## 🔐 SonarQube Credentials

SonarQube tokens should be stored securely in Jenkins Credentials.

Never commit tokens to GitHub.

## 🚦 Quality Gate

A successful Quality Gate allows the pipeline to continue.

A failed Quality Gate should stop the pipeline.

Example Jenkins logic:

```groovy
waitForQualityGate abortPipeline: true
```

## 📊 SonarQube Metrics

Important metrics include:

```text
Bugs
Vulnerabilities
Code Smells
Coverage
Duplications
Maintainability
Reliability
Security
```

## 🎯 Learning Outcomes

* SonarQube
* Static code analysis
* Quality Gates
* Jenkins integration
* Code quality automation

## 🔮 Future Improvements

* Docker scanning
* Dependency scanning
* Secret scanning
* SAST
* DAST
* Kubernetes security
* Production deployment
