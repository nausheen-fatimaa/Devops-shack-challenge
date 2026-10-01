# Day 7 — Project 08: Centralized Logging

Creates a central CloudWatch Logs group, VPC Flow Logs delivery, and an EC2 test workload that sends application logs to CloudWatch through the CloudWatch Agent.

## Folder structure
```text
project/
├── terraform/
├── scripts/
├── docs/
│   └── architecture.md
├── screenshots/
├── tests/
├── reports/
└── README.md
```

## Prerequisites
- Terraform >= 1.6
- AWS CLI configured (`aws sts get-caller-identity`)
- An AWS account with permissions for the resources in this project
- Region defaults to `ap-south-1` and can be overridden with `-var="aws_region=..."`

## Deploy
```powershell
cd terraform
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

## Destroy
```powershell
cd terraform
terraform destroy
```

## Windows helper scripts
From the project directory:
```powershell
.\scripts\validate.ps1
.\scripts\deploy.ps1
.\scripts\destroy.ps1
```

## Important
- Do not commit `*.tfvars`, state files, credentials, private keys, or generated secrets.
- Review AWS costs before applying.
## Log sources
- VPC Flow Logs -> CloudWatch Logs
- EC2 application log -> CloudWatch Logs

## Smoke checks
After apply, inspect the log groups beginning with `/day7/`.

