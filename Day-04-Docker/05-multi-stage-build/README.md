# 🏗️ Multi-Stage Docker Build

## 📌 Project Overview

This project demonstrates Docker multi-stage builds.

A build stage contains the tools required to build the application, while the final production stage contains only the components required to run it.

## 🎯 Objectives

* Understand multi-stage Docker builds
* Reduce image size
* Separate build and runtime environments
* Improve production container security
* Reduce unnecessary dependencies

## 🏗️ Architecture

```text
Source Code
     |
     ↓
Build Stage
     |
     ↓
Production Stage
     |
     ↓
Small Runtime Image
```

## 📁 Project Structure

```text
05-multi-stage-build/
├── src/
│   └── server.js
├── package.json
├── package-lock.json
├── Dockerfile
├── .dockerignore
├── README.md
└── screenshots/
```

## 🚀 Build

```bash
docker build -t multistage-app:v1 .
```

Check image size:

```bash
docker images multistage-app
```

## ▶️ Run

```bash
docker run -d \
  --name multistage-app \
  -p 3000:3000 \
  multistage-app:v1
```

Open:

```text
http://localhost:3000
```

## 🧠 Benefits

Multi-stage builds help:

* Reduce image size
* Reduce attack surface
* Remove build tools from production
* Improve deployment efficiency

## 🧠 Key Concepts

* Build stage
* Runtime stage
* `COPY --from`
* Image optimization
* Production builds

## 🏁 Result

A production-ready runtime image is created without carrying unnecessary build dependencies.
