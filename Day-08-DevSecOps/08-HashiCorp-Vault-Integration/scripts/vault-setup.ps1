$ErrorActionPreference = "Stop"
if (-not $env:VAULT_ADDR) { $env:VAULT_ADDR = "http://127.0.0.1:8200" }
Write-Host "Configure VAULT_TOKEN from the local dev-server output."
Write-Host "Example: vault kv put secret/devsecops-demo username=training-user password=training-password"
