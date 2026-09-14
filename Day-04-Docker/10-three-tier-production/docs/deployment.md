# Deployment Guide

## 1. Create environment file

Copy `.env.example` to `.env`.

## 2. Build images

docker compose build

## 3. Start services

docker compose up -d

## 4. Check services

docker compose ps

## 5. Test application

Open:

http://localhost:8081

## 6. Check logs

docker compose logs

## 7. Stop application

docker compose down