output "bucket_name" {
  value = aws_s3_bucket.ci_demo.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.ci_demo.arn
}
