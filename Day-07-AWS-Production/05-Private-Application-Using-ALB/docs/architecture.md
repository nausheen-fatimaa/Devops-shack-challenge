# Project 5 — Private Application Using ALB

## Architecture

```text
                    Internet
                       |
                  Public ALB
                 /          \
             Private-A    Private-B
                 |            |
              EC2-A          EC2-B
```

## Security boundary

```text
Internet -> ALB SG -> App SG -> EC2
```

The EC2 security group does not allow HTTP from the public internet. It accepts HTTP only from the ALB security group.

The EC2 instances do not receive public IPv4 addresses.

## Why NAT?

NAT provides outbound-only internet access for private instances, allowing package installation and updates without making the instances public.
