# Project 1 — Connectivity Test

## Checks

1. Confirm the VPC exists.
2. Confirm two public and two private subnets exist.
3. Confirm the private instance has no public IP.
4. Confirm the private route table points to the NAT Gateway.
5. Connect to the private instance using AWS Systems Manager Session Manager.
6. From the private instance, test outbound HTTPS:

```bash
curl -I https://aws.amazon.com
```

## Expected result

The private instance can make outbound connections through NAT, but it is not directly reachable from the public internet.
