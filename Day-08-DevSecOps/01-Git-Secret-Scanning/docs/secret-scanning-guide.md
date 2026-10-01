# Secret Scanning Guide

1. Install Gitleaks.
2. Run a local scan.
3. Review findings.
4. Add a pre-commit/CI scan.
5. Rotate any real exposed credentials.
6. Store runtime secrets in a secret manager such as Vault.

Never use real credentials for the test fixture.
