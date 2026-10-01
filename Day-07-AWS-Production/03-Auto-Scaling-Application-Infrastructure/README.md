# Project 3 — Auto Scaling Application Infrastructure

## Overview

This project deploys a private EC2 application tier behind an Application Load Balancer and manages the application servers with an EC2 Auto Scaling Group.

## Architecture

```text
Internet
   |
  ALB
   |
Target Group
   |
Auto Scaling Group
 /             \
EC2           EC2
AZ-1          AZ-2
```

## Objectives

- Create a Launch Template.
- Create an Auto Scaling Group.
- Maintain minimum/desired/maximum capacity.
- Use ELB health checks.
- Configure CPU target tracking.
- Test scale-out and scale-in.

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

## Verify

```powershell
terraform output -raw alb_dns_name
terraform output -raw autoscaling_group_name
```

## Troubleshooting

### Instances launch but target is unhealthy

Check:

- User data completed.
- Nginx is running.
- App SG allows HTTP from ALB SG.
- Target group port is 80.
- Health check path is `/`.

### Scaling does not happen immediately

Target tracking uses CloudWatch metrics and has evaluation/provisioning delays. Verify CPU is actually elevated and the ASG has room to scale.

### Capacity cannot launch

Check:

- Subnet IP availability.
- EC2 service quotas.
- Instance type availability in the AZ.
- IAM role/profile.
- Launch Template configuration.

## Cleanup

```powershell
terraform destroy
```

## Cost warning

NAT Gateway, ALB, and EC2 are billable resources.

## Skills Demonstrated

Launch Templates, Auto Scaling, target tracking, ALB, CloudWatch metrics, private EC2, Terraform.
