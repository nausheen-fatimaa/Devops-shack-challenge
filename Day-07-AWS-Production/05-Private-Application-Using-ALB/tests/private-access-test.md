# Project 5 — Private Access Test

## 1. Verify no public IP

```powershell
terraform output private_instance_public_ips
```

Expected:

```text
[
  null,
  null
]
```

## 2. Verify ALB works

```powershell
$alb = terraform output -raw alb_dns_name
Invoke-WebRequest "http://$alb" -UseBasicParsing
```

Expected: HTTP 200.

## 3. Verify direct EC2 access is not possible

There should be no public IP to connect to.

The application is exposed only through the ALB.

## 4. Verify security group design

The App SG should have:

```text
HTTP 80 <- ALB SG
```

not:

```text
HTTP 80 <- 0.0.0.0/0
```
