$ErrorActionPreference = "Stop"
New-Item -ItemType Directory -Force reports | Out-Null
semgrep --config auto --json --output reports/semgrep-report.json .
