# 🚀 Three-Tier Production Application with Docker

## 📌 Project Overview

This project demonstrates a production-style three-tier web application deployed using Docker and Docker Compose.

The application consists of:

1. NGINX frontend
2. Flask backend
3. MySQL database

Docker networking, persistent storage, health checks, restart policies, and container security practices are incorporated into the deployment.

## 🏗️ Architecture

```text
                    USER
                      |
                      ↓
              ┌──────────────┐
              │    NGINX     │
              │   FRONTEND   │
              └──────┬───────┘
                     |
                     ↓
              ┌──────────────┐
              │    FLASK     │
              │   BACKEND    │
              └──────┬───────┘
                     |
                     ↓
              ┌──────────────┐
              │    MYSQL     │
              │   DATABASE   │
              └──────┬───────┘
                     |
                     ↓
              ┌──────────────┐
              │    VOLUME    │
              │ mysql-data   │
              └──────────────┘
```

## 🎯 Objectives

* Build a complete multi-tier application
* Containerize frontend and backend
* Deploy MySQL using Docker
* Use Docker Compose
* Configure Docker networks
* Persist database data using volumes
* Configure health checks
* Configure restart policies
* Run backend as a non-root user
* Use environment-based configuration

## 🛠️ Technologies

* HTML
* NGINX
* Python
* Flask
* MySQL
* Docker
* Docker Compose
* Docker Networks
* Docker Volumes

## 📁 Project Structure

```text
10-three-tier-production/
├── frontend/
├── backend/
├── database/
├── docs/
├── screenshots/
├── tests/
├── docker-compose.yml
├── .env.example
├── .gitignore
├── .dockerignore
└── README.md
```

## ⚙️ Prerequisites

Install:

* Docker
* Docker Compose

Verify:

```bash
docker --version
docker compose version
```

## 🔐 Environment Configuration

Copy:

```text
.env.example
```

to:

```text
.env
```

Configure database credentials.

Never commit the real `.env` file.

## 🚀 Deploy

Build and start all services:

```bash
docker compose up -d --build
```

Check:

```bash
docker compose ps
```

## 🌐 Access Application

Open:

```text
http://localhost:8080
```

## 🧪 Test Backend

```text
http://localhost:8080/api/health
```

Expected:

```json
{
  "status": "healthy"
}
```

## 🗄️ Test Database

```text
http://localhost:8080/api/db
```

The backend should successfully communicate with MySQL.

## 🔍 Check Containers

```bash
docker compose ps
```

## 📋 View Logs

All services:

```bash
docker compose logs
```

Backend:

```bash
docker compose logs backend
```

Frontend:

```bash
docker compose logs frontend
```

Database:

```bash
docker compose logs mysql
```

## 🌐 Check Networks

```bash
docker network ls
```

Inspect:

```bash
docker network inspect <network-name>
```

## 💾 Check Volumes

```bash
docker volume ls
```

Inspect:

```bash
docker volume inspect <volume-name>
```

## ❤️ Health Checks

Check service health:

```bash
docker compose ps
```

The MySQL service uses a health check before the backend starts depending on it.

The backend also exposes a health endpoint.

## 🔄 Restart Policy

Services use:

```yaml
restart: unless-stopped
```

This allows Docker to restart containers after failures.

## 🧪 Persistence Test

Stop the application:

```bash
docker compose down
```

Start it again:

```bash
docker compose up -d
```

Verify that database data remains available.

## 🔐 Security Practices

This project demonstrates:

* Non-root backend container
* Environment-based configuration
* `.env` exclusion from Git
* Minimal base images
* Health checks
* Separation of frontend and backend networks
* No hard-coded production secrets

## 🧹 Stop Application

```bash
docker compose down
```

To also remove volumes:

```bash
docker compose down -v
```

⚠️ Removing volumes deletes persistent database data.

## 🧠 Docker Concepts Demonstrated

### Containerization

Application components run independently inside containers.

### Docker Compose

All services are managed through one Compose configuration.

### Networking

Services communicate through Docker networks.

### Volumes

Database data persists outside the database container lifecycle.

### Health Checks

Docker can monitor service health.

### Restart Policies

Containers can automatically restart after failures.

### Security

Containers use production-oriented security practices.

## 📸 Screenshots

Add screenshots demonstrating:

1. Application running
2. `docker compose ps`
3. Backend health
4. Database connection
5. Docker networks
6. Docker volumes
7. Container logs
8. Container recovery

## 🧪 Testing Checklist

* [ ] Frontend loads
* [ ] Backend health endpoint works
* [ ] Backend communicates with database
* [ ] MySQL is healthy
* [ ] Docker networks work
* [ ] Database volume exists
* [ ] Database data persists
* [ ] Container restart works
* [ ] Backend runs as non-root
* [ ] No secrets are committed

## 🏁 Final Result

A production-style three-tier application is successfully deployed using Docker Compose with container networking, persistent storage, health checks, restart policies, and security best practices.

