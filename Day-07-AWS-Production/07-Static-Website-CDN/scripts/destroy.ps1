$ErrorActionPreference = "Stop"
Set-Location "$PSScriptRoot\..\terraform"
terraform destroy
