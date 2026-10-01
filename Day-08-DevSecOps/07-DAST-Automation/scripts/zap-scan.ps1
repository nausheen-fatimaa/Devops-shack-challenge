$ErrorActionPreference = "Stop"
New-Item -ItemType Directory -Force reports | Out-Null
Write-Host "Start target-app first, then run a ZAP baseline scan."
docker run --rm -v "${PWD}/reports:/zap/wrk/:rw" `
  ghcr.io/zaproxy/zaproxy:stable `
  zap-baseline.py -t http://host.docker.internal:8080 -r zap-report.html -J zap-report.json
