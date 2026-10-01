# Project 4 — Three-Tier Architecture

## Layers

### Presentation tier

Internet-facing Application Load Balancer in public subnets.

### Application tier

Two private EC2 instances across two Availability Zones.

### Database tier

Private RDS MySQL in dedicated database subnets with Multi-AZ enabled.

## Security flow

```text
Internet
   |
ALB Security Group
   |
Application Security Group
   |
Database Security Group
```

The database accepts MySQL traffic only from the application security group.

## Important

Do not open port 3306 to `0.0.0.0/0`.
