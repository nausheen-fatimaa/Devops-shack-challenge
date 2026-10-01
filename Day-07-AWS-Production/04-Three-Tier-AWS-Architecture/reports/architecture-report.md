# Project 4 — Architecture Report

## Components

| Tier | Components | Network |
|---|---|---|
| Presentation | ALB | Public subnets |
| Application | EC2 x2 | Private subnets |
| Database | RDS MySQL Multi-AZ | Private DB subnets |

## Validation

- [ ] ALB accessible
- [ ] Both app targets healthy
- [ ] RDS available
- [ ] RDS not publicly accessible
- [ ] App → RDS connectivity works
- [ ] Internet → RDS blocked
