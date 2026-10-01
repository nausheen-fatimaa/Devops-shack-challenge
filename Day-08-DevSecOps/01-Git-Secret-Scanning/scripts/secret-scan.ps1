$ErrorActionPreference = "Stop"
New-Item -ItemType Directory -Force reports | Out-Null
gitleaks detect --source . --redact --report-format json --report-path reports/gitleaks-report.json
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
Write-Host "Gitleaks scan passed."
