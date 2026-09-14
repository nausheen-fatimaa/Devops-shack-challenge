# 🔐 Docker Image Security

## 📌 Project Overview

This project demonstrates Docker image security practices, vulnerability scanning, and container hardening.

## 🎯 Objectives

* Scan Docker images for vulnerabilities
* Understand vulnerability severity
* Use minimal base images
* Run containers as non-root users
* Avoid embedding secrets
* Follow secure Dockerfile practices

## 📁 Project Structure

```text
08-docker-image-security/
├── app/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
├── security/
│   ├── scan-results.md
│   └── security-checklist.md
├── .dockerignore
├── README.md
└── screenshots/
```

## 🚀 Build

```bash
docker build -t secure-app:v1 .
```

## 🔍 Scan

If Docker Scout is available:

```bash
docker scout quickview secure-app:v1
```

Scan vulnerabilities:

```bash
docker scout cves secure-app:v1
```

## 🔐 Security Practices

### Use trusted base images

Avoid unnecessary or unknown images.

### Avoid `latest`

Prefer explicit versions:

```dockerfile
FROM python:3.12-slim
```

### Run as non-root

Use:

```dockerfile
USER appuser
```

where appropriate.

### Never hard-code secrets

Avoid:

```dockerfile
ENV DB_PASSWORD=password
```

Use secure configuration mechanisms instead.

### Use `.dockerignore`

Exclude:

```text
.git
.env
node_modules
__pycache__
*.log
```

## 🧠 Key Concepts

* Vulnerability scanning
* CVEs
* Minimal images
* Non-root containers
* Secret management
* Dockerfile security

## 🏁 Result

The Docker image is scanned and hardened using production-oriented security practices.
