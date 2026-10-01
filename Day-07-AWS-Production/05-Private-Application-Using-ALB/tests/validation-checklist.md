# Validation Checklist

Run from this project directory:

```powershell
.\scripts\validate.ps1
```

Then inspect the plan before applying:

```powershell
cd terraform
terraform plan
```

For AWS apply, ensure AWS credentials are configured and the selected region has at least two Availability Zones.
