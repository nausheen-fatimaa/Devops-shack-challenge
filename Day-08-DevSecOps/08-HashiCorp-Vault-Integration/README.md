# Project 8 — HashiCorp Vault Integration

## Objective
Store application secrets outside source code and retrieve them through an authenticated secret-management workflow.

## Important
The included examples are for a local learning environment. Do not use Vault dev mode or hardcoded root tokens for production.

## Local dev server
If Vault is installed:
```bash
vault server -dev
```
Follow the terminal output for the temporary root token and VAULT_ADDR. Keep that token out of Git.

## Store a training secret
```bash
vault kv put secret/devsecops-demo username=training-user password=training-password
vault kv get secret/devsecops-demo
```

## Kubernetes
The Kubernetes directory contains a service account and example deployment. A production setup should use Kubernetes authentication and a least-privilege policy.

## Architecture
```text
Application -> Auth -> Vault -> Secret
```
