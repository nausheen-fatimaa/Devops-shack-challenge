resource "aws_s3_bucket" "site" { bucket_prefix="${var.project_name}-" }
resource "aws_s3_bucket_public_access_block" "site" { bucket=aws_s3_bucket.site.id block_public_acls=true block_public_policy=true ignore_public_acls=true restrict_public_buckets=true }
resource "aws_s3_bucket_ownership_controls" "site" { bucket=aws_s3_bucket.site.id rule {object_ownership="BucketOwnerEnforced"} }
resource "aws_s3_object" "index" { bucket=aws_s3_bucket.site.id key="index.html" content=<<-HTML
<!doctype html><html><head><title>Day 7 AWS CDN</title></head><body><h1>Static Website + CloudFront</h1><p>Deployed by Terraform.</p></body></html>
HTML content_type="text/html" }
resource "aws_cloudfront_origin_access_control" "site" { name="${var.project_name}-oac" description="OAC for private S3 origin" origin_access_control_origin_type="s3" signing_behavior="always" signing_protocol="sigv4" }
resource "aws_cloudfront_distribution" "site" { enabled=true default_root_object="index.html" price_class="PriceClass_100" origin { domain_name=aws_s3_bucket.site.bucket_regional_domain_name origin_id="s3-site" origin_access_control_id=aws_cloudfront_origin_access_control.site.id } default_cache_behavior { target_origin_id="s3-site" viewer_protocol_policy="redirect-to-https" allowed_methods=["GET","HEAD"] cached_methods=["GET","HEAD"] compress=true forwarded_values {query_string=false cookies {forward="none"}} } restrictions {geo_restriction {restriction_type="none"}} viewer_certificate {cloudfront_default_certificate=true minimum_protocol_version="TLSv1.2_2021"} }
data "aws_caller_identity" "current" {}
resource "aws_s3_bucket_policy" "site" { bucket=aws_s3_bucket.site.id policy=jsonencode({Version="2012-10-17",Statement=[{Sid="AllowCloudFrontServicePrincipalReadOnly",Effect="Allow",Principal={Service="cloudfront.amazonaws.com"},Action=["s3:GetObject"],Resource="${aws_s3_bucket.site.arn}/*",Condition={StringEquals={"AWS:SourceArn"=aws_cloudfront_distribution.site.arn}}}]}) }
