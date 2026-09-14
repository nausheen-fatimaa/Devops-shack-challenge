# 🐳 Containerize a Real Web Application

## 📌 Project Overview

This project demonstrates how to containerize a Python Flask web application using Docker.

The application is packaged into a Docker image and executed as an isolated container.

## 🎯 Objectives

* Understand Docker fundamentals
* Create a Dockerfile
* Build a Docker image
* Run a Docker container
* Publish container ports
* View container logs
* Access a running container
* Test application health

## 🛠️ Technologies

* Python
* Flask
* Docker
* Dockerfile

## 📁 Project Structure

```text
01-containerize-web-app/
├── app.py
├── requirements.txt
├── Dockerfile
├── .dockerignore
├── README.md
└── screenshots/
```

## 🚀 Build the Docker Image

```bash
docker build -t docker-web-app:v1 .
```

Check the image:

```bash
docker images
```

## ▶️ Run the Container

```bash
docker run -d \
  --name docker-web-app \
  -p 5000:5000 \
  docker-web-app:v1
```

## 🔍 Verify

```bash
docker ps
```

Open:

```text
http://localhost:5000
```

Health endpoint:

```text
http://localhost:5000/health
```

## 📋 Useful Commands

View logs:

```bash
docker logs docker-web-app
```

Enter the container:

```bash
docker exec -it docker-web-app sh
```

Stop:

```bash
docker stop docker-web-app
```

Remove:

```bash
docker rm docker-web-app
```

## 🧠 Key Concepts Learned

* Docker image
* Docker container
* Dockerfile
* Port mapping
* Container lifecycle
* Docker logs
* Container shell access

## 📸 Screenshots

Add screenshots showing:

1. Docker image successfully built
2. Running container
3. Application in browser
4. Health endpoint

## 🏁 Result

The Flask application successfully runs inside a Docker container and is accessible through the host machine.
