# 📦 Private Docker Registry

## 📌 Project Overview

This project demonstrates how to deploy and use a private Docker Registry.

The registry stores Docker images internally instead of relying on a public registry.

## 🎯 Objectives

* Deploy a private registry
* Push Docker images
* Pull Docker images
* Understand image tagging
* Understand private image repositories

## 🏗️ Architecture

```text
Developer
    |
    | docker push
    ↓
Private Docker Registry
    |
    | docker pull
    ↓
Application Server
```

## 📁 Project Structure

```text
09-private-docker-registry/
├── registry/
│   └── README.md
├── scripts/
│   ├── start-registry.ps1
│   ├── push-image.ps1
│   └── pull-image.ps1
├── docker-compose.yml
├── README.md
└── screenshots/
```

## 🚀 Start Registry

```bash
docker compose up -d
```

Check:

```bash
docker ps
```

## 🏷️ Tag an Image

Example:

```bash
docker tag docker-web-app:v1 localhost:5000/docker-web-app:v1
```

## 📤 Push

```bash
docker push localhost:5000/docker-web-app:v1
```

## 🔍 List Repositories

```bash
curl http://localhost:5000/v2/_catalog
```

## 📥 Pull

```bash
docker pull localhost:5000/docker-web-app:v1
```

## 🧠 Key Concepts

* Docker Registry
* Image tagging
* Push
* Pull
* Private repositories
* Image distribution

## ⚠️ Production Considerations

A real production registry should include:

* TLS
* Authentication
* Access control
* Persistent storage
* Image scanning
* Backup

## 🏁 Result

A private Docker Registry is successfully deployed and used to store and distribute container images.
