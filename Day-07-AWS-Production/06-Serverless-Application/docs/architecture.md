# 06 — Serverless Application

## Purpose
Creates a small serverless REST API using API Gateway HTTP API, Lambda, DynamoDB, and CloudWatch Logs. No servers or VPC are required.

## Architecture
- AWS Region: `var.aws_region` (default `ap-south-1`)
- Terraform creates all networking resources explicitly; no default VPC is required.
- Resources are tagged with `Project` and `ManagedBy=Terraform`.

## Security
- Least-privilege security-group rules.
- No SSH key is required by the default configurations; use AWS Systems Manager where applicable.
- Secrets are generated or supplied as sensitive Terraform variables and are excluded from Git.

## Validation
1. `terraform fmt -check -recursive`
2. `terraform init`
3. `terraform validate`
4. `terraform plan`
5. Apply only after reviewing the plan.

## Cost
Several projects create billable resources such as NAT gateways, ALB, RDS, CloudFront, or cross-region replication. Destroy resources after practice.
