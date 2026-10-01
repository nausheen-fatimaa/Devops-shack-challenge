# Project 7 - Infrastructure Drift Detection and Recovery

## Goal

Create an S3 bucket with Terraform, intentionally change a tag or setting outside Terraform, then use Terraform to detect and recover from drift.

## Commands

```powershell
terraform fmt -recursive
terraform init
terraform validate
terraform apply
terraform plan
```

## Drift exercise

After `apply`, change a managed tag in the AWS console.

Then run:

```powershell
terraform plan
```

Terraform should show a difference between the configuration/state and the remote infrastructure.

Restore the desired configuration with:

```powershell
terraform apply
```

You can also refresh state information with:

```powershell
terraform plan -refresh-only
```

Do not add resource blocks to `outputs.tf`; it must contain outputs only.
