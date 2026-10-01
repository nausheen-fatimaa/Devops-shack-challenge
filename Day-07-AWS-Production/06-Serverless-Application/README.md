# Day 7 — Project 06: Serverless Application

Creates a small serverless REST API using API Gateway HTTP API, Lambda, DynamoDB, and CloudWatch Logs. No servers or VPC are required.

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
## API
The Lambda function accepts `GET /` and writes/reads a simple DynamoDB counter.
## Smoke test
```powershell
$url = terraform -chdir=terraform output -raw api_url
Invoke-RestMethod "$url/"
```

