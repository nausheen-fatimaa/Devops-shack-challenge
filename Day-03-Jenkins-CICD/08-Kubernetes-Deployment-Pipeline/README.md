# 08 - Kubernetes Deployment Pipeline

## ☸️ Project Overview

This project demonstrates automated Kubernetes deployment using Jenkins.

Jenkins builds the application, creates a Docker image, pushes it to a container registry and deploys the application to Kubernetes.

## 🏗️ Architecture

```text
GitHub
   |
   v
Jenkins
   |
   +----> Build
   |
   +----> Test
   |
   +----> Docker Build
   |
   +----> Push Image
   |
   +----> Kubernetes Deploy
   |
   v
Kubernetes Cluster
```

## 📂 Project Structure

```text
08-Kubernetes-Deployment-Pipeline/
├── k8s/
│   ├── namespace.yaml
│   ├── deployment.yaml
│   ├── service.yaml
│   └── configmap.yaml
├── Dockerfile
├── Jenkinsfile
├── README.md
├── docs/
│   └── kubernetes-deployment.md
└── screenshots/
    ├── pods.png
    ├── deployment.png
    └── service.png
```

## ☸️ Kubernetes Components

### Namespace

Creates an isolated Kubernetes environment.

```bash
kubectl apply -f k8s/namespace.yaml
```

### Deployment

Manages application Pods.

```bash
kubectl apply -f k8s/deployment.yaml
```

### Service

Provides network access to the application.

```bash
kubectl apply -f k8s/service.yaml
```

### ConfigMap

Stores non-sensitive configuration.

```bash
kubectl apply -f k8s/configmap.yaml
```

## 🔄 Pipeline

```text
Checkout
   ↓
Build
   ↓
Test
   ↓
Docker Build
   ↓
Docker Push
   ↓
kubectl Apply
   ↓
Deployment Verification
```

## 🔎 Useful Commands

Check Pods:

```bash
kubectl get pods
```

Check Deployments:

```bash
kubectl get deployments
```

Check Services:

```bash
kubectl get services
```

Check deployment status:

```bash
kubectl rollout status deployment/application
```

## 🎯 Learning Outcomes

* Kubernetes Deployments
* Pods
* Services
* ConfigMaps
* Jenkins Kubernetes deployment
* Containerized application deployment

## 🔮 Future Improvements

* Rolling deployments
* Blue/Green deployment
* Canary deployment
* Health checks
* Automated rollback
* Helm
