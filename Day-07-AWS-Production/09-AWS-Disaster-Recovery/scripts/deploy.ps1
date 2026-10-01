$ErrorActionPreference = "Stop"
Set-Location "$PSScriptRoot\..\terraform"
terraform init
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
