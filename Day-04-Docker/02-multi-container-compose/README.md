# 🐳 Multi-Container Application with Docker Compose

## 📌 Project Overview

This project demonstrates how to run multiple application services using Docker Compose.

The application contains a frontend and backend service managed through a single `docker-compose.yml` file.

## 🎯 Objectives

* Understand Docker Compose
* Run multiple containers together
* Build services using Dockerfiles
* Connect services through Docker networking
* Manage application lifecycle using Compose

## 🏗️ Architecture

```text
User
 |
 ↓
Frontend Container
 |
 ↓
Backend Container
```

## 🛠️ Technologies

* HTML
* NGINX
* Python
* Flask
* Docker
* Docker Compose

## 📁 Project Structure

```text
02-multi-container-compose/
├── frontend/
│   ├── index.html
│   └── Dockerfile
├── backend/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── README.md
└── screenshots/
```

## 🚀 Start the Application

```bash
docker compose up -d --build
```

Check services:

```bash
docker compose ps
```

## 🌐 Access

Frontend:

```text
http://localhost:8080
```

Backend:

```text
http://localhost:5000
```

## 📋 Useful Commands

View logs:

```bash
docker compose logs
```

View service logs:

```bash
docker compose logs backend
```

Stop:

```bash
docker compose down
```

Rebuild:

```bash
docker compose up -d --build
```

## 🧠 Key Concepts Learned

* Docker Compose
* Services
* Container networking
* Service dependencies
* Port mapping
* Compose lifecycle management

## 📸 Screenshots

Add:

1. `docker compose ps`
2. Frontend browser
3. Backend response
4. Docker containers

## 🏁 Result

Multiple application components are successfully deployed and managed using Docker Compose.
