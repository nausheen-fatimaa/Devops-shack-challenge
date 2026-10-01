#!/usr/bin/env bash
set -euo pipefail
mkdir -p reports
docker run --rm -v "$PWD/reports:/zap/wrk/:rw" \
  ghcr.io/zaproxy/zaproxy:stable \
  zap-baseline.py -t http://host.docker.internal:8080 \
  -r zap-report.html -J zap-report.json
