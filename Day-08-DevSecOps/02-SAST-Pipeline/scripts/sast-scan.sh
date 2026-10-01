#!/usr/bin/env bash
set -euo pipefail
mkdir -p reports
semgrep --config auto --json --output reports/semgrep-report.json .
