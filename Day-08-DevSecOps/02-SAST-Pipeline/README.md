# Project 2 — SAST Pipeline

## Objective
Perform Static Application Security Testing before deployment.

## Tools
- Semgrep
- SonarQube
- Jenkins

## Flow
```text
Git -> Jenkins -> Build/Test -> Semgrep -> SonarQube -> Quality Gate
```

## Local Semgrep
```bash
semgrep --config auto .
semgrep --config auto --json > reports/semgrep-report.json
```

## SonarQube
Set `sonar.host.url` to your SonarQube instance in `config/sonar-project.properties`.
Do not put authentication tokens in Git. Configure them as Jenkins credentials.

## Jenkins
The supplied Jenkinsfile is a template. Configure a SonarQube installation named `sonarqube` and a quality-gate webhook in Jenkins.
