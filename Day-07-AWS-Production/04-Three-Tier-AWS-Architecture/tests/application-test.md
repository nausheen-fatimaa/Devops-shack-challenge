# Project 4 — Application Test

## ALB test

```powershell
$alb = terraform output -raw alb_dns_name
Invoke-WebRequest "http://$alb" -UseBasicParsing
```

Expected: HTTP 200.

## Database test

The RDS endpoint should be private and should not be reachable from the public internet.

From an application instance, install a MySQL client and test connectivity:

```bash
sudo dnf install -y mariadb105
mysql -h <RDS_ENDPOINT> -u appadmin -p
```

The connection should work from the application tier.

A direct public connection should not be possible because RDS is private.
