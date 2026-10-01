# Project 2 — Highly Available Web Application

## Overview

A two-Availability-Zone web application using an internet-facing Application Load Balancer and two private EC2 application servers.

## Architecture

```text
Internet
   |
  ALB
 /   \
EC2  EC2
 |    |
AZ-1 AZ-2
```

## Objectives

- Build Multi-AZ infrastructure.
- Use an ALB for traffic distribution.
- Keep application servers private.
- Configure ALB health checks.
- Demonstrate failure tolerance.

## Prerequisites

```powershell
aws sts get-caller-identity
terraform version
```

## Deploy

```powershell
cd terraform
Copy-Item terraform.tfvars.example terraform.tfvars
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

Get the URL:

```powershell
terraform output -raw alb_dns_name
```

Open it in a browser.

## Test

Run the health/failover tests in `tests/health-check.md`.

## Troubleshooting

### ALB returns 503

Check target health:

```powershell
aws elbv2 describe-target-health --target-group-arn <TARGET_GROUP_ARN>
```

Common causes:

- Nginx did not install.
- EC2 security group does not allow port 80 from ALB SG.
- User data has not finished.
- Target is still initializing.

### Private EC2 has no internet

Check the app subnet route table and NAT Gateway.

### No default VPC

Not applicable. The project creates a dedicated VPC.

## Cleanup

```powershell
terraform destroy
```

## Cost warning

NAT Gateway is billable. Destroy the lab after testing.

## Skills Demonstrated

VPC, Multi-AZ, ALB, target groups, health checks, private EC2, NAT, IAM, SSM, Terraform.
