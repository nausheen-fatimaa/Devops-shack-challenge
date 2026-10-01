$ErrorActionPreference = "Stop"
Set-Location "$PSScriptRoot\..\terraform"
terraform fmt -check -recursive
terraform init
terraform validate
Write-Host "Validation completed successfully."
