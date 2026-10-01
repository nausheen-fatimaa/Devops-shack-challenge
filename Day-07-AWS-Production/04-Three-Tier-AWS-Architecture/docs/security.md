# Project 4 — Security Design

## Controls

- No public IP on application EC2.
- No public IP on RDS.
- ALB is the only public entry point.
- Application SG accepts HTTP only from ALB SG.
- Database SG accepts MySQL only from App SG.
- SSM is used for EC2 administration instead of public SSH.
- RDS storage encryption is enabled.
- Terraform variables are used for the database password.

## Secrets

Do not commit:

```text
terraform.tfvars
terraform.tfstate
```

For a real production deployment, use AWS Secrets Manager or another secret-management system instead of placing database credentials directly in Terraform variables.
