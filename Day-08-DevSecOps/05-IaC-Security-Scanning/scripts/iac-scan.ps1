$ErrorActionPreference = "Stop"
checkov -d terraform
tfsec terraform
