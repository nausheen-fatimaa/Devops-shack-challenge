# Project 1 — Architecture

## Goal

Create a secure VPC with two public and two private subnets across two Availability Zones.

## Traffic flow

```text
Internet
   |
Internet Gateway
   |
Public Subnets
   |
NAT Gateway
   |
Private Subnets
   |
Private EC2
```

## Security model

- Public subnets are internet-routable.
- Private subnets have no direct route to the Internet Gateway.
- Private instances can use NAT for outbound internet access.
- The test EC2 instance has no public IP.
- AWS Systems Manager is used instead of opening SSH to the internet.

## Production note

For higher resilience, a production design can use one NAT Gateway per Availability Zone. This lab uses one NAT Gateway to control cost.
