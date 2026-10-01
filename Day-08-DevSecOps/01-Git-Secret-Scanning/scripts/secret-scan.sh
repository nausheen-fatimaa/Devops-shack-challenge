#!/usr/bin/env bash
set -euo pipefail
mkdir -p reports
gitleaks detect --source . --redact \
  --report-format json \
  --report-path reports/gitleaks-report.json
