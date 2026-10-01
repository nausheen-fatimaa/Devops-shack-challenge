# Tests

Run `terraform validate` before deployment. After deployment, use the project outputs and AWS console/CLI to perform the smoke checks described in the README.

These are intentionally non-destructive checks; they do not contain hard-coded AWS account IDs, credentials, or private keys.
