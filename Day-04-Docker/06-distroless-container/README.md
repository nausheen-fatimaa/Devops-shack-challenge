# 🔐 Distroless / Minimal Production Container

## 📌 Project Overview

This project demonstrates the use of a minimal or distroless runtime image for production workloads.

The application is built using a full JDK environment and then executed using a minimal runtime image.

## 🎯 Objectives

* Understand distroless containers
* Reduce production image size
* Reduce attack surface
* Separate build and runtime environments
* Understand production container hardening

## 🏗️ Architecture

```text
Java Source
     |
     ↓
JDK Build Image
     |
     ↓
Application JAR
     |
     ↓
Distroless Runtime
```

## 📁 Project Structure

```text
06-distroless-container/
├── src/
│   └── Main.java
├── pom.xml
├── Dockerfile
├── .dockerignore
├── README.md
└── screenshots/
```

## 🚀 Build

```bash
docker build -t distroless-app:v1 .
```

## ▶️ Run

```bash
docker run -d \
  --name distroless-app \
  -p 8080:8080 \
  distroless-app:v1
```

## 🔐 Security Advantage

Distroless images contain fewer operating-system components than traditional base images.

This reduces unnecessary packages and the potential attack surface.

## ⚠️ Important

A distroless container may not contain:

```text
bash
sh
package managers
common debugging utilities
```

Therefore, commands such as:

```bash
docker exec -it container sh
```

may not work.

## 🧠 Key Concepts

* Distroless images
* Minimal runtime
* Multi-stage builds
* Attack surface reduction
* Production container hardening

## 🏁 Result

The Java application successfully runs using a minimal production runtime image.
