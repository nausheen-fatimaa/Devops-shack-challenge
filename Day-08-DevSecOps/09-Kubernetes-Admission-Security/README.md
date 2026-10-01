# Project 9 — Kubernetes Admission Security

## Objective
Use Kyverno policy-as-code to validate Kubernetes workloads before admission.

## Policies
- Disallow privileged containers
- Require CPU/memory resources
- Require non-root execution

## Install Kyverno
Use the current Kyverno Helm installation documentation for your cluster. Typical repository setup:
```bash
helm repo add kyverno https://kyverno.github.io/kyverno/
helm repo update
```

## Apply policies
```bash
kubectl apply -f policies/
```

## Test
```bash
kubectl apply -f tests/insecure-pod.yaml
kubectl apply -f tests/secure-pod.yaml
```

The insecure pod should be rejected once the policies are installed and enforcing.

Policy behavior can vary with Kyverno version and policy settings; inspect the admission response and policy reports.
