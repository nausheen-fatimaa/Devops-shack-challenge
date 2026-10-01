# 05-Three-Tier-Infrastructure

Project 5: Terraform creates a three-tier VPC with ALB, private application ASG, and private MySQL RDS.

## Validation

```powershell
terraform fmt -recursive
terraform init
terraform validate
terraform plan
```

## Cleanup

```powershell
terraform destroy
```
