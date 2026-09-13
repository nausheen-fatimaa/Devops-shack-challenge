# Disk Usage Alerting Script

## 1. Project Overview

The Disk Usage Alerting Script is a Bash-based Linux automation project that monitors filesystem disk utilization and generates warnings when disk usage crosses configured thresholds.

## 2. Objectives

* Monitor disk utilization
* Identify high disk usage
* Generate warning messages
* Generate critical alerts
* Maintain logs
* Use configurable thresholds

## 3. Technologies Used

* Linux
* Bash
* df
* awk
* grep
* tee

## 4. Configuration

Example:

```bash
DISK_WARNING=70
DISK_CRITICAL=90
```

## 5. Working Process

1. The script reads configured thresholds.
2. It obtains filesystem usage using `df`.
3. Disk usage is extracted using `awk`.
4. Each filesystem is checked.
5. Usage below the warning threshold is considered normal.
6. Usage above the warning threshold generates a warning.
7. Usage above the critical threshold generates a critical alert.
8. Results are written to logs.

## 6. Testing

The script was tested with normal disk usage and with a temporarily reduced warning threshold to simulate an alert condition.

## 7. DevOps Skills Demonstrated

* Linux filesystem management
* Bash scripting
* Monitoring
* Alerting
* Threshold-based automation
* Log management

## 8. Interview Explanation

I created a Bash script that monitors Linux filesystem utilization and generates warning or critical alerts based on configurable thresholds. I used `df` to collect filesystem statistics and `awk` to process the usage percentage. The project demonstrates how basic infrastructure monitoring can be automated using shell scripting.
