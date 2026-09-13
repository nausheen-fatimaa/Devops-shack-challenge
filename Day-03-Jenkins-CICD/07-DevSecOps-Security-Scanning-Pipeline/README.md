# 07 - DevSecOps Security Scanning Pipeline

## 🔐 Project Overview

This project integrates security testing into the Jenkins CI/CD pipeline.

The objective is to detect security vulnerabilities before an application reaches production.

## 🛠️ Technologies Used

* Jenkins
* GitHub
* Maven
* Docker
* Trivy
* OWASP Dependency-Check

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
   +----> Dependency Scan
   |
   +----> Docker Build
   |
   +----> Trivy Image Scan
   |
   v
Security Decision
```

## 📂 Project Structure

```text
07-DevSecOps-Security-Scanning-Pipeline/
├── security/
│   ├── trivy/
│   └── dependency-check/
├── Dockerfile
├── Jenkinsfile
├── README.md
├── reports/
│   ├── trivy-report.txt
│   └── dependency-report.html
├── docs/
│   └── security-scanning.md
└── screenshots/
    ├── trivy-scan.png
    ├── vulnerability-report.png
    └── security-failure.png
```

## 🔄 Pipeline

```text
Checkout
   ↓
Build
   ↓
Unit Test
   ↓
Dependency Scan
   ↓
Docker Build
   ↓
Trivy Scan
   ↓
Security Validation
   ↓
Continue / Fail
```

## 🔍 Trivy

Trivy can scan container images for vulnerabilities.

Example:

```bash
trivy image myapp:latest
```

## 📦 Dependency-Check

OWASP Dependency-Check identifies vulnerable application dependencies.

## 🚨 Security Failure

The pipeline can be configured to fail when serious vulnerabilities are detected.

Example:

```text
Critical vulnerability
        ↓
Pipeline FAILED
```

## 🔐 Security Best Practices

Never commit:

```text
Passwords
API keys
Access tokens
Cloud credentials
Private keys
Docker credentials
```

## 🎯 Learning Outcomes

* DevSecOps
* Vulnerability scanning
* Container security
* Dependency security
* Security gates
* Secure CI/CD

## 🔮 Future Improvements

Add:

* Secret scanning
* SAST
* DAST
* IaC scanning
* Kubernetes security scanning
* Runtime security
