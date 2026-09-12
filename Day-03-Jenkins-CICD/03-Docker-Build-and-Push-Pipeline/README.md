# 03 - Docker Build and Push Pipeline

## 📌 Project Overview

This project demonstrates how Jenkins can automatically build a Docker image and push it to a container registry.

The pipeline connects GitHub, Jenkins, Maven, Docker and Docker Hub.

## 🛠️ Technologies Used

* Git
* GitHub
* Jenkins
* Java
* Maven
* Docker
* Docker Hub

## 🏗️ Architecture

```text
GitHub
   |
   v
Jenkins
   |
   +----> Checkout
   |
   +----> Maven Build
   |
   +----> Docker Build
   |
   +----> Docker Tag
   |
   +----> Docker Login
   |
   +----> Docker Push
   |
   v
Docker Hub
```

## 📂 Project Structure

```text
03-Docker-Build-and-Push-Pipeline/
├── Dockerfile
├── .dockerignore
├── Jenkinsfile
├── README.md
├── docs/
│   └── docker-pipeline-documentation.md
├── screenshots/
│   ├── docker-build.png
│   ├── docker-image.png
│   └── docker-hub.png
└── logs/
    └── pipeline-log.txt
```

## 🔄 Pipeline Stages

```text
Checkout
   ↓
Maven Build
   ↓
Docker Build
   ↓
Docker Tag
   ↓
Docker Login
   ↓
Docker Push
```

## 🐳 Build Docker Image

Example:

```bash
docker build -t myapp:latest .
```

## ▶️ Run Container

```bash
docker run -d -p 8080:8080 myapp:latest
```

## 🔐 Jenkins Credentials

Docker Hub credentials should be stored inside Jenkins Credentials.

Do **not** store:

```text
username
password
access token
```

inside the Git repository.

## 🏷️ Image Tagging

A Jenkins build number can be used as the image version.

Example:

```text
myapp:1
myapp:2
myapp:3
```

This makes image versions traceable to Jenkins builds.

## 🚀 Expected Pipeline

```text
GitHub
   ↓
Jenkins
   ↓
Maven Build
   ↓
Docker Build
   ↓
Docker Push
   ↓
Docker Hub
```

## 🎯 Learning Outcomes

* Dockerfile
* Docker image creation
* Docker registry
* Jenkins Docker integration
* Credential management
* Image versioning

## 🔮 Future Improvements

* Kubernetes deployment
* Vulnerability scanning
* SonarQube
* Automated rollback
* Production deployment
