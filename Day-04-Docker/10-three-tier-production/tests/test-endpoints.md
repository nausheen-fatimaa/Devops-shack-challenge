# Endpoint Tests

## Frontend

http://localhost:8081

Expected:

Three-Tier Docker Application

## Backend Health

http://localhost:8081/api/health

Expected:

{
  "status": "healthy",
  "database": "connected"
}

## Backend API

http://localhost:8081/api/data

Expected:

Successful JSON response.