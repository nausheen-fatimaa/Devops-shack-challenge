# ❤️ Container Health Check & Auto-Recovery

## 📌 Project Overview

This project demonstrates Docker health checks and restart policies.

Docker monitors the application health and can restart containers according to the configured restart policy.

## 🎯 Objectives

* Implement Docker health checks
* Monitor application health
* Configure restart policies
* Simulate container failure
* Understand basic container self-recovery

## 🏗️ Architecture

```text
Application
     |
     ↓
Docker Health Check
     |
     ↓
Healthy / Unhealthy
     |
     ↓
Restart Policy
```

## 📁 Project Structure

```text
07-health-check-auto-recovery/
├── app/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
├── docker-compose.yml
├── README.md
└── screenshots/
```

## 🚀 Start

```bash
docker compose up -d --build
```

Check:

```bash
docker compose ps
```

## 🔍 View Health

```bash
docker inspect <container-name>
```

Look for:

```text
Health
```

## 🧪 Test Recovery

Stop the application container:

```bash
docker stop <container-name>
```

Check:

```bash
docker ps
```

The configured restart policy should restart the container.

## 🧠 Key Concepts

* HEALTHCHECK
* Container health
* Restart policies
* Fault recovery
* Application monitoring

## 🏁 Result

The application is monitored using Docker health checks and configured for automatic restart after container failure.
