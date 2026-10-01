# Project 3 — Scaling Test

## Baseline

```powershell
aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names day7-p3-asg
```

## Generate CPU load

Connect to an ASG instance through SSM and run a controlled CPU workload, for example:

```bash
sudo dnf install -y stress-ng
stress-ng --cpu 2 --timeout 5m
```

Do not leave load running after the test.

## Observe

Check:

- CloudWatch CPU metric
- ASG desired capacity
- EC2 instance count
- ALB target health

Scaling can take several minutes. Do not expect an immediate new instance.
