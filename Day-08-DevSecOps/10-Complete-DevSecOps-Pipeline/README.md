# Project 10 — Complete Code-to-Production DevSecOps Pipeline

## Objective
Combine the security controls from Projects 1–9 into one CI/CD workflow.

## Pipeline
```text
Git
 ↓
Gitleaks
 ↓
SAST (Semgrep/SonarQube)
 ↓
SCA
 ↓
Unit Tests
 ↓
Build
 ↓
Docker Image
 ↓
Trivy
 ↓
Terraform + Checkov
 ↓
Kubernetes
 ↓
Kyverno Admission
 ↓
DAST
 ↓
Falco Runtime Monitoring
 ↓
Production
```

## Project design

This project intentionally contains a small demo application and placeholder configuration. Reuse the validated tools/configuration from Projects 1–9 rather than copying blindly.

## Jenkins
Configure tools and credentials in Jenkins. Do not store passwords/tokens in the Jenkinsfile.

The pipeline is a template and may need adjustments for your Jenkins agents and installed plugins.

## Run locally
```bash
cd application
mvn test
docker build -t day8-devsecops-app:1.0 .
```

Terraform:
```bash
terraform -chdir=infrastructure/terraform init
terraform -chdir=infrastructure/terraform validate
```

## Security gates
Example gates:
- Secret detected: fail
- Critical SAST finding: fail/review according to policy
- Critical dependency/image issue: fail/review
- IaC policy violation: fail/review
- Admission policy violation: reject
- DAST high-risk issue: fail/review

Tune thresholds to your organization's risk policy; do not treat scanner severity as a substitute for human review.

## Evidence
Put screenshots and generated reports under the corresponding directories. Never commit secrets or sensitive production data.
