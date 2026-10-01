# Project 7 — DAST Automation

## Objective
Scan an application that is running.

## Tool
OWASP ZAP

## Safety
Only scan applications you own or are explicitly authorized to test.

## Start target
The included target is a tiny static web page. You can serve it with a local HTTP server:
```bash
cd target-app
python -m http.server 8080
```

## Baseline scan with Docker
```bash
docker run --rm --network host \
  -v "$(pwd)/reports:/zap/wrk/:rw" \
  ghcr.io/zaproxy/zaproxy:stable \
  zap-baseline.py -t http://127.0.0.1:8080 \
  -r zap-report.html -J zap-report.json
```

On Windows Docker Desktop, network behavior can differ; use `host.docker.internal` when the target is running on the host and verify connectivity.

## Flow
```text
Running App -> ZAP -> Spider/Passive Scan -> Report -> Review/Security Gate
```
