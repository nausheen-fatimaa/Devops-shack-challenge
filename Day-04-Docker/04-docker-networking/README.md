# 🌐 Docker Networking Lab

## 📌 Project Overview

This project demonstrates communication between multiple Docker containers using custom Docker networks.

## 🎯 Objectives

* Understand Docker networks
* Create custom networks
* Connect containers
* Test container-to-container communication
* Understand Docker DNS
* Understand service-name resolution

## 🏗️ Architecture

```text
Frontend
   |
   ↓
Backend
   |
   ↓
Database
```

All application services communicate using Docker networks.

## 📁 Project Structure

```text
04-docker-networking/
├── frontend/
├── backend/
├── database/
├── docker-compose.yml
├── network-test.md
├── README.md
└── screenshots/
```

## 🚀 Create Network

```bash
docker network create devops-network
```

Check:

```bash
docker network ls
```

Inspect:

```bash
docker network inspect devops-network
```

## 🧪 Test Communication

Start the services:

```bash
docker compose up -d
```

Enter a container:

```bash
docker exec -it <container-name> sh
```

Test another service:

```bash
ping backend
```

The service name can be used instead of manually finding the container IP.

## 🧠 Important Concept

Inside Docker networks:

```text
backend
mysql
frontend
```

can act as DNS names for the corresponding services.

Do not normally use:

```text
localhost
```

to access another container.

## 🧠 Key Concepts

* Bridge networks
* Custom networks
* Container DNS
* Service discovery
* Container-to-container communication

## 🏁 Result

Multiple containers successfully communicate through Docker networking without relying on hard-coded IP addresses.
