$ErrorActionPreference = "Stop"
$TerraformDir = Join-Path $PSScriptRoot "..\terraform"
Set-Location $TerraformDir
terraform init
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
