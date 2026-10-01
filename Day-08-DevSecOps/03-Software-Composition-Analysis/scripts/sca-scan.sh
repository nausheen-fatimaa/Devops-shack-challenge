#!/usr/bin/env bash
set -euo pipefail
mkdir -p reports
mvn org.owasp:dependency-check-maven:check
trivy fs --format json --output reports/trivy-report.json .
