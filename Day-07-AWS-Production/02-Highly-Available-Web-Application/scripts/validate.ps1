$ErrorActionPreference = "Stop"
$TerraformDir = Join-Path $PSScriptRoot "..\terraform"
Set-Location $TerraformDir
Write-Host "== Terraform Format Check =="
terraform fmt -check -recursive
Write-Host "== Terraform Init (upgrade=false) =="
terraform init -upgrade=false
Write-Host "== Terraform Validate =="
terraform validate
Write-Host "Validation completed successfully."
