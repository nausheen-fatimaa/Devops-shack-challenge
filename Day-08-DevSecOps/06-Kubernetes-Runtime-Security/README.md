# Project 6 — Kubernetes Runtime Security

## Objective
Detect suspicious activity in running Kubernetes workloads.

## Tool
Falco

## Prerequisites
- Kubernetes cluster
- Helm
- Appropriate Falco privileges for the cluster/runtime

## Deploy demo workload
```bash
kubectl apply -f kubernetes/
```

## Install Falco
Use the current Falco Helm chart documentation for your Kubernetes/runtime version. A typical repository setup is:
```bash
helm repo add falcosecurity https://falcosecurity.github.io/charts
helm repo update
```

Then install the chart using the chart's current documented values for your environment.

## Test
```bash
kubectl apply -f tests/runtime-test.yaml
kubectl get pods -n devsecops-runtime
```

Review Falco alerts through the deployment logs:
```bash
kubectl get pods -n falco
kubectl logs -n falco <falco-pod>
```

Do not attempt attacks against systems you do not own or have authorization to test.
