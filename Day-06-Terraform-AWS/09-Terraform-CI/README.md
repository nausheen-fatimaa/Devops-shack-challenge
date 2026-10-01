# Project 9 - Infrastructure as Code CI Integration

This project demonstrates how Terraform can be executed from a CI pipeline such as Jenkins.

## Pipeline flow

```text
Checkout
   ↓
terraform init
   ↓
terraform fmt -check
   ↓
terraform validate
   ↓
terraform plan
   ↓
Manual approval
   ↓
terraform apply
```

## Jenkins requirements

The Jenkins agent must have:

- Terraform installed
- AWS CLI installed if needed by your workflow
- AWS credentials configured securely in Jenkins
- Git access to the repository

Do not hard-code AWS access keys in the Jenkinsfile.

## Local validation

```powershell
terraform fmt -recursive
terraform init
terraform validate
terraform plan
```
