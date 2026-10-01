$ErrorActionPreference = "Stop"
$TerraformDir = Join-Path $PSScriptRoot "..\terraform"
Set-Location $TerraformDir
terraform destroy
