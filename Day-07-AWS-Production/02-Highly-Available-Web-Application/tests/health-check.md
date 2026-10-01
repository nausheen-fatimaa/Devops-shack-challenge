# Project 2 — Health and Failover Test

## 1. Get the ALB URL

```powershell
terraform output -raw alb_dns_name
```

## 2. Test

```powershell
$alb = terraform output -raw alb_dns_name
1..10 | ForEach-Object { Invoke-WebRequest "http://$alb" -UseBasicParsing | Select-Object -ExpandProperty Content }
```

The hostname in the response identifies the responding instance.

## 3. Failure test

Terminate one EC2 instance from the console or AWS CLI.

Wait for the target to become unhealthy.

Repeat the request. The ALB should continue returning the application from the remaining healthy instance.
