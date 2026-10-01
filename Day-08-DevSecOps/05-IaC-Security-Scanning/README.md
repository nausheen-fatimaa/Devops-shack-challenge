# Project 5 — IaC Security Scanning

## Objective
Scan Terraform before `terraform apply`.

## Tools
- Checkov
- tfsec

## Run
```bash
terraform -chdir=terraform init
terraform -chdir=terraform fmt -check
checkov -d terraform
tfsec terraform
```

This lab uses a minimal AWS VPC example. Review every finding instead of blindly suppressing checks.

## Security workflow
```text
Terraform -> Checkov/tfsec -> Review -> terraform plan -> approved apply
```

Never put AWS access keys in `.tf` files. Use AWS CLI profiles, environment-based credentials, or an appropriate CI identity.
