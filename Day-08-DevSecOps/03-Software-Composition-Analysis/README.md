# Project 3 — Software Composition Analysis

## Objective
Find known vulnerabilities in third-party dependencies.

## Tools
- OWASP Dependency-Check
- Trivy

## Run
```bash
mvn test
mvn org.owasp:dependency-check-maven:check
trivy fs .
```

For JSON:
```bash
trivy fs --format json --output reports/trivy-report.json .
```

## Flow
```text
pom.xml -> Dependency resolution -> SCA -> CVEs -> Review/Security Gate
```

Do not copy vulnerable sample dependencies into production projects merely to reproduce a CVE.
