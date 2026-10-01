resource "aws_s3_bucket" "ci_demo" {
  bucket = var.bucket_name

  tags = {
    Name        = "project9-ci-demo"
    ManagedBy   = "Terraform"
    Environment = "CI"
  }
}

resource "aws_s3_bucket_versioning" "ci_demo" {
  bucket = aws_s3_bucket.ci_demo.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "ci_demo" {
  bucket = aws_s3_bucket.ci_demo.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
