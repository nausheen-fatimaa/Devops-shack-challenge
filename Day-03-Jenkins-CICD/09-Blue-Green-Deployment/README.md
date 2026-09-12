# 09 - Blue/Green Deployment

## 🔵🟢 Project Overview

Blue/Green deployment is a deployment strategy that maintains two application environments.

```text
BLUE  → Current Production Version
GREEN → New Application Version
```

Traffic can be switched between them with minimal downtime.

## 🏗️ Architecture

```text
                 Kubernetes Service
                        |
                        v
                  Production
                        |
             +----------+----------+
             |                     |
             v                     v
        BLUE VERSION         GREEN VERSION
        Version 1             Version 2
```

## 📂 Project Structure

```text
09-Blue-Green-Deployment/
├── k8s/
│   ├── blue-deployment.yaml
│   ├── green-deployment.yaml
│   └── service.yaml
├── scripts/
│   ├── deploy-blue.bat
│   ├── deploy-green.bat
│   └── switch-traffic.bat
├── Jenkinsfile
├── README.md
├── docs/
│   └── blue-green-strategy.md
└── screenshots/
    ├── blue.png
    ├── green.png
    └── traffic-switch.png
```

## 🔵 Blue Environment

Blue represents the currently running production version.

Example:

```text
BLUE = v1.0
```

## 🟢 Green Environment

Green contains the new version.

Example:

```text
GREEN = v2.0
```

The new version can be tested before receiving production traffic.

## 🔄 Deployment Process

```text
Current Production
      |
      v
     BLUE
      |
Deploy GREEN
      |
      v
Test GREEN
      |
      v
Switch Service
      |
      v
Production → GREEN
```

## 🔁 Rollback

If the new version fails:

```text
Production → GREEN
       ↓
Switch back
       ↓
Production → BLUE
```

This provides a fast rollback mechanism.

## ☸️ Kubernetes Service

The Service selector determines which version receives traffic.

Example concept:

```yaml
selector:
  version: blue
```

Traffic can be changed to:

```yaml
selector:
  version: green
```

## 🎯 Learning Outcomes

* Blue/Green deployment
* Kubernetes Services
* Traffic switching
* Zero/minimal downtime deployment
* Deployment rollback
* Jenkins deployment automation

## 🔮 Future Improvements

* Automated health checks
* Automated traffic switching
* Jenkins approval
* Canary deployment
* Monitoring
* Automatic rollback
