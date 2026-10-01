# Project 1 — Git Secret Scanning

## Objective
Detect accidentally committed credentials before they reach a shared repository.

## Tool
Gitleaks

## Architecture
```text
Developer -> Git commit -> Gitleaks -> PASS -> Push
                              |
                              +-> Secret found -> Block/Investigate
```

## Run
```powershell
gitleaks version
gitleaks detect --source . --redact
gitleaks detect --source . --report-format json --report-path reports/gitleaks-report.json --redact
```

The included test fixture is intentionally a dummy value. Do not add real credentials.

## CI usage
The Jenkinsfile runs Gitleaks and fails when the scanner returns a finding.

## Important
If a real secret is ever exposed, remove it from the repository and rotate/revoke it. Removing it from the latest commit alone is not sufficient.
