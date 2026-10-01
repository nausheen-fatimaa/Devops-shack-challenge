# Project 6 - Terraform Remote State with S3

## Important bootstrap note

A Terraform S3 backend cannot create the S3 bucket that it uses for its own backend. Create the bucket first with the AWS CLI or a separate bootstrap configuration.

### 1. Create the bucket

Use a globally unique name:

```powershell
aws s3api create-bucket --bucket YOUR_UNIQUE_BUCKET_NAME --region ap-south-1 --create-bucket-configuration LocationConstraint=ap-south-1
aws s3api put-bucket-versioning --bucket YOUR_UNIQUE_BUCKET_NAME --versioning-configuration Status=Enabled
aws s3api put-public-access-block --bucket YOUR_UNIQUE_BUCKET_NAME --public-access-block-configuration BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true
```

### 2. Update providers.tf

Replace:

```text
REPLACE_WITH_YOUR_UNIQUE_BUCKET_NAME
```

with your actual bucket name.

### 3. Initialize the backend

```powershell
terraform init -reconfigure
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

This project demonstrates the S3 remote-state pattern and state locking through the S3 backend lockfile.

## Important

Do not run `terraform destroy` on the state bucket unless you intentionally want to remove the backend. The resource has `prevent_destroy = true`.
