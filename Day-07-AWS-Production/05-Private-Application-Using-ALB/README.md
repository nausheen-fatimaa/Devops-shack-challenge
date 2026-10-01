# Project 5 — Private Application Using ALB

## Overview

This project demonstrates how to expose a private application securely through an internet-facing Application Load Balancer.

The EC2 application servers have no public IP addresses.

## Architecture

```text
Internet
   |
Public ALB
   |
Private EC2
```

## Objectives

- Deploy EC2 instances in private subnets.
- Deploy a public ALB.
- Restrict application access to the ALB security group.
- Use NAT for private outbound connectivity.
- Verify that application servers are not directly internet-accessible.

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

## Verify private instances

```powershell
terraform output private_instance_public_ips
```

The output should contain no public IP addresses.

## Troubleshooting

### ALB returns 503

Check:

- Both targets are healthy.
- Nginx is running.
- App SG allows HTTP from ALB SG.
- NAT Gateway allowed package installation.
- User data completed.

### EC2 has a public IP

Check that:

```text
associate_public_ip_address = false
```

and that the subnet does not automatically assign public addresses.

### Direct internet access to EC2

There should be no public IP. Even if someone knows the private IP, it is not internet-routable.

## Cleanup

```powershell
terraform destroy
```

## Cost warning

NAT Gateway and ALB are billable. Destroy the lab when finished.

## Skills Demonstrated

Private networking, ALB, security groups, NAT, EC2, SSM, Multi-AZ, Terraform, production security.
