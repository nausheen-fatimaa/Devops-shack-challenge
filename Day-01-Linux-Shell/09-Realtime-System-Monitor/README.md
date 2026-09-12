# Real-Time System Monitor Dashboard

## 1. Project Overview

The Real-Time System Monitor Dashboard is a Bash-based terminal monitoring tool that continuously displays Linux system resource information.

The dashboard refreshes automatically and displays CPU, memory, disk, load, uptime, process, and network information.

## 2. Objectives

* Monitor Linux systems in real time
* Display CPU utilization
* Display memory utilization
* Display disk utilization
* Display load average
* Display uptime
* Display running processes
* Display network information
* Generate monitoring logs

## 3. Technologies Used

* Linux
* Bash
* top
* free
* df
* uptime
* ps
* ip

## 4. Configuration

```bash
REFRESH_INTERVAL=3
DISK_THRESHOLD=80
MEMORY_THRESHOLD=80
CPU_THRESHOLD=80
```

## 5. Working Process

The dashboard:

1. Clears the terminal.
2. Collects CPU usage.
3. Collects memory usage.
4. Checks disk utilization.
5. Displays load average.
6. Displays uptime.
7. Displays process information.
8. Displays top CPU-consuming processes.
9. Displays top memory-consuming processes.
10. Displays network information.
11. Checks configured thresholds.
12. Refreshes automatically.

## 6. Testing

Testing included:

* Normal system monitoring
* CPU load generation
* Disk monitoring
* Memory monitoring
* Process monitoring
* Threshold alert testing
* Network information testing

## 7. DevOps Skills Demonstrated

* Linux monitoring
* Bash scripting
* System administration
* Resource analysis
* Troubleshooting
* Automation

## 8. Interview Explanation

I developed a real-time Linux monitoring dashboard using Bash. It continuously displays CPU, memory, disk, load, uptime, process, and network information. I also added configurable thresholds so that resource utilization can be identified when it exceeds acceptable limits.
