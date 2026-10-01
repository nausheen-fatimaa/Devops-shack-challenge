# Project 3 — Auto Scaling Architecture

```text
Internet
   |
  ALB
   |
Target Group
   |
Auto Scaling Group
  /        \
AZ-1      AZ-2
EC2       EC2
```

The ASG maintains the desired number of instances. Target tracking scales the group toward an average CPU utilization target of 60%.
