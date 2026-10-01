# Project 10 - Production AWS Infrastructure Using Terraform

This is a production-style learning lab combining:

- Custom VPC
- Two public subnets
- Two private subnets
- Internet Gateway
- NAT Gateway per AZ
- Application Load Balancer
- Auto Scaling Group
- Private application instances
- CloudWatch log group

It is intentionally a learning/portfolio environment and is not a complete production security baseline.

## Deploy

```powershell
terraform fmt -recursive
terraform init
terraform validate
terraform plan
terraform apply
terraform output application_url
```

## Test

Open the `application_url` output in a browser.

Terminate one ASG instance from the AWS console and observe the Auto Scaling Group replace it.

## Cleanup

NAT gateways and other AWS resources can incur charges.

```powershell
terraform destroy
```
