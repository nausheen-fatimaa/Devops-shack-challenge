# Day 7 — Project 10: Production Multi-AZ Infrastructure

Combines a two-AZ VPC, public ALB, private Auto Scaling application tier, isolated Multi-AZ RDS database, CloudWatch alarms, and SSM access into one production-style stack.

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
## Components
- Custom VPC in two AZs
- Internet-facing ALB
- Private ASG across two AZs
- Multi-AZ MySQL RDS in isolated subnets
- SSM IAM role
- CloudWatch CPU alarm

## Database password
Terraform generates a 20-character password and exposes it only as a sensitive output. No password is stored in a `.tfvars` file.

