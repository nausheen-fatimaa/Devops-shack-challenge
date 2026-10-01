$ErrorActionPreference = "Stop"
New-Item -ItemType Directory -Force reports | Out-Null
mvn org.owasp:dependency-check-maven:check
trivy fs --format json --output reports/trivy-report.json .
