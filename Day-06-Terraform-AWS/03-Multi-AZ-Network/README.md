# 03-Multi-AZ-Network

Project 3: Terraform creates public/private subnets across two AZs, an Internet Gateway, and one NAT Gateway per AZ.

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
