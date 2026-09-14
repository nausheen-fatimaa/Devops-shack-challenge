# 💾 Persistent Database with Docker Volumes

## 📌 Project Overview

This project demonstrates how Docker volumes provide persistent storage for databases.

A MySQL database is deployed as a container, while its data is stored in a Docker named volume.

## 🎯 Objectives

* Understand Docker volumes
* Deploy MySQL using Docker
* Persist database data
* Understand container storage
* Test data persistence after container recreation

## 🏗️ Architecture

```text
Application
     |
     ↓
MySQL Container
     |
     ↓
Docker Named Volume
```

## 📁 Project Structure

```text
03-persistent-database-volumes/
├── app/
├── database/
│   └── init.sql
├── docker-compose.yml
├── .env.example
├── .gitignore
├── README.md
└── screenshots/
```

## 🚀 Start

Create your environment file from `.env.example`.

Then:

```bash
docker compose up -d
```

Check:

```bash
docker compose ps
```

## 🔍 Check Volume

```bash
docker volume ls
```

Inspect:

```bash
docker volume inspect <volume-name>
```

## 🧪 Persistence Test

Stop the application:

```bash
docker compose down
```

Start it again:

```bash
docker compose up -d
```

Verify that the database data remains available.

## ⚠️ Important

Do not commit `.env` containing real passwords.

Only commit:

```text
.env.example
```

## 🧠 Key Concepts

* Docker volumes
* Persistent storage
* MySQL containers
* Named volumes
* Database persistence

## 🏁 Result

The database successfully maintains its data even when the database container is recreated.
