# Project 8 - Terraform Modules

This project demonstrates reusable Terraform modules.

## Structure

```text
08-Terraform-Modules/
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
├── .gitignore
└── modules/
    ├── network/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── web/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Commands

```powershell
terraform fmt -recursive
terraform init
terraform validate
terraform plan
terraform apply
terraform output
terraform destroy
```
