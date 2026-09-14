# Three-Tier Architecture

## Layers

### Presentation Layer

NGINX serves the frontend application.

### Application Layer

Flask provides REST API endpoints.

### Data Layer

MySQL stores persistent application data.

## Docker Networks

Frontend network:

- frontend
- backend

Backend network:

- backend
- database

The frontend cannot directly communicate with MySQL.

## Storage

MySQL uses the `mysql-data` Docker volume.

## Health Checks

Both backend and database use Docker health checks.

## Restart Policy

All services use:

restart: unless-stopped