# Project 1 — Secure VPC Architecture

## Overview

A Terraform-based AWS VPC lab demonstrating secure network segmentation with public/private subnets, Internet Gateway, NAT Gateway, route tables, security groups, and a private EC2 test instance.

## Architecture

```text
                  Internet
                     |
              Internet Gateway
                     |
          +----------+----------+
          |                     |
      Public-A             Public-B
          |
      NAT Gateway
          |
     Private-A -------- Private-B
          |
      Private EC2
```

## Objectives

- Create a VPC without relying on a default VPC.
- Create two public and two private subnets.
- Configure public and private routing.
- Provide private outbound access through NAT.
- Keep the EC2 test instance private.
- Use SSM instead of public SSH.

## Prerequisites

- AWS account
- AWS CLI configured
- Terraform >= 1.6
- IAM permissions to create VPC, EC2, IAM, NAT Gateway and related resources.

Verify:

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

## Test

```powershell
aws ec2 describe-instances --instance-ids (terraform output -raw private_test_instance_id)
```

Use AWS Systems Manager Session Manager to connect to the instance, then:

```bash
curl -I https://aws.amazon.com
```

## Troubleshooting

### No default VPC

This project does not use a default VPC. It creates its own VPC.

### NAT Gateway cost

NAT Gateway is billable. Destroy the project after testing.

### SSM instance not online

Check:

- Instance IAM role has `AmazonSSMManagedInstanceCore`.
- Private subnet has a working NAT route.
- Instance has network egress.
- SSM agent is running.

## Cleanup

```powershell
terraform destroy
```

## Skills Demonstrated

VPC, subnetting, route tables, IGW, NAT, Security Groups, IAM, SSM, Terraform, network troubleshooting.
