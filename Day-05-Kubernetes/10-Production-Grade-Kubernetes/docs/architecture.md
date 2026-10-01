User
 |
 v
Ingress
 |
 v
Frontend Service
 |
 v
Frontend Deployment
 |
 +---- Pod
 |
 +---- Pod
 |
 +---- Pod
 |
 v
Backend Service
 |
 v
Backend Deployment
 |
 +---- Pod
 +---- Pod
 +---- Pod

Supporting components:
- ConfigMap
- Secret
- HPA
- Readiness Probe
- Liveness Probe
- Resource Requests/Limits
- RollingUpdate