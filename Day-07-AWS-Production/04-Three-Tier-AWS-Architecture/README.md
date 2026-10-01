# Project 4 — Three-Tier AWS Architecture

## Overview

A production-style three-tier AWS architecture separating the presentation, application, and database layers.

## Architecture

```text
                  Internet
                     |
                    ALB
               Public Subnets
                     |
          -----------------------
          |                     |
       App EC2               App EC2
      Private-A             Private-B
          |                     |
          -----------+-----------
                      |
                 Private DB
                RDS MySQL
                 Multi-AZ
```

## Objectives

- Implement public, application, and database tiers.
- Use Multi-AZ networking.
- Keep application and database resources private.
- Restrict traffic between tiers using security groups.
- Deploy RDS Multi-AZ.
- Demonstrate production-style segmentation.

## Prerequisites

Use a strong database password and never commit the real `terraform.tfvars`.

## Deploy

```powershell
cd terraform
Copy-Item terraform.tfvars.example terraform.tfvars
notepad terraform.tfvars
```

Change:

```text
# RDS password is generated automatically by Terraform.
# Do not add db_password to this file.
```

Then:

```powershell
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

## Verify

```powershell
terraform output -raw alb_dns_name
terraform output -raw rds_endpoint
```

Open the ALB URL.

## Troubleshooting

### Terraform password validation

Use at least 8 characters.

### RDS creation fails

Check:

- DB subnet group contains subnets in at least two AZs.
- DB SG allows 3306 from App SG.
- DB password meets engine requirements.
- Instance class is available in the selected region.

### ALB 503

Check target health, EC2 user data, Nginx, and the App SG rule.

### Database publicly reachable

It should not be. Confirm:

```text
publicly_accessible = false
```

and verify the RDS SG does not allow `0.0.0.0/0` on port 3306.

## Cleanup

```powershell
terraform destroy
```

## Cost warning

RDS Multi-AZ, NAT Gateway, ALB and EC2 are billable. Destroy when the lab is complete.

## Skills Demonstrated

Three-tier architecture, VPC, subnetting, ALB, EC2, RDS, Multi-AZ, security groups, private networking, Terraform.
