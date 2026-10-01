# DAY-7 — AWS Production Architecture

This bundle contains 10 independently deployable Terraform projects. Every project creates the networking resources it needs instead of relying on the AWS default VPC.

## Projects
1. Secure VPC Architecture
2. Highly Available Web Application
3. Auto Scaling Application Infrastructure
4. Three-Tier AWS Architecture
5. Private Application Using ALB
6. Serverless Application
7. Static Website + CloudFront CDN
8. Centralized Logging
9. AWS Disaster Recovery (S3 cross-region replication)
10. Production Multi-AZ Infrastructure

## Global prerequisites
- Terraform >= 1.6
- AWS CLI configured
- IAM permissions for each project's resources
- Two AZs available in the selected region

## Important validation note
The Terraform files are generated as self-contained lab configurations and avoid the common errors from earlier work: no default-VPC dependency, no duplicate resource declarations, outputs reference resources declared in the same project, and RDS passwords are generated with valid length/characters.

Terraform cannot guarantee a successful AWS API call in every account: service quotas, IAM policies, regional service availability, existing name collisions, and billing restrictions can still affect an apply. Always run `terraform validate` and `terraform plan` first.

## Cost control
NAT gateways, ALBs, RDS, CloudFront, and cross-region replication can incur charges. Destroy each lab when finished.
