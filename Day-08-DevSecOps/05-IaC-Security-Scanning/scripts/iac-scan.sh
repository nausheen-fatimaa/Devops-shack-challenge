#!/usr/bin/env bash
set -euo pipefail
checkov -d terraform
tfsec terraform
