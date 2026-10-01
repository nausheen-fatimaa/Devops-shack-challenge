# Day 7 — Project 07: Static Website with CDN

Hosts a private S3 website origin behind CloudFront using Origin Access Control (OAC), HTTPS redirect, and a simple HTML page.

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
## Architecture
S3 public access is blocked. CloudFront uses OAC to read the bucket.
## Smoke test
Open the `cloudfront_domain_name` output in a browser.

