# Automated System Health Checker

## 1. Project Overview

The Automated System Health Checker is a Linux shell scripting project that automatically checks the health and resource utilization of a Linux system.

The script monitors CPU usage, memory usage, disk usage, system load, uptime, running processes, failed systemd services, and network information.

The project demonstrates Linux administration, Bash scripting, monitoring, logging, configuration management, and basic automation.

## 2. Objectives

* Monitor Linux system health automatically
* Check CPU utilization
* Check memory utilization
* Check disk utilization
* Monitor system load
* Display system uptime
* Count running processes
* Detect failed systemd services
* Collect network information
* Generate health reports
* Maintain execution logs

## 3. Technologies Used

* Linux
* Bash Shell Scripting
* top
* free
* df
* uptime
* ps
* systemctl
* ip
* awk
* grep
* sed

## 4. Project Structure

```text
01-Automated-System-Health-Checker/
├── config/
│   └── thresholds.conf
├── docs/
│   └── project-documentation.md
├── logs/
├── reports/
├── screenshots/
├── scripts/
│   └── health-check.sh
├── tests/
├── .gitignore
└── README.md
```

## 5. Configuration

The project uses `config/thresholds.conf`.

Example configuration:

```bash
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80
```

These values determine when the script reports a resource as being above the configured threshold.

## 6. Working Process

The script performs the following operations:

1. Reads threshold configuration.
2. Collects CPU usage.
3. Collects memory usage.
4. Checks disk utilization.
5. Checks system load.
6. Displays uptime.
7. Counts running processes.
8. Checks failed systemd services.
9. Collects network information.
10. Displays the health status.
11. Writes execution information to the log.
12. Generates a health report.

## 7. Testing

The project was tested by:

* Running the health checker normally.
* Checking CPU information.
* Checking memory usage.
* Checking disk usage.
* Checking system uptime.
* Checking running processes.
* Checking failed services.
* Verifying generated reports.
* Verifying log files.

## 8. Expected Output

The script displays a Linux system health summary containing:

* CPU usage
* Memory usage
* Disk usage
* Load average
* Uptime
* Process count
* Failed services
* Network information
* Overall status

## 9. Screenshots

The `screenshots/` directory contains screenshots showing the execution and testing of the project.

## 10. DevOps Skills Demonstrated

* Linux administration
* Bash scripting
* System monitoring
* Configuration management
* Log management
* Error handling
* Automation
* Resource monitoring
* Troubleshooting

## 11. Interview Explanation

I created an automated Linux system health checker using Bash scripting. The script collects CPU, memory, disk, load, uptime, process, service, and network information. I also added configurable thresholds so that abnormal resource utilization can be identified. The script generates reports and maintains logs, making it useful as a basic Linux monitoring automation tool.

