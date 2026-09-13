# 🚀 Day 01 — Linux & Shell Scripting

## DevOps 10 Days / 100 Projects Challenge

This repository contains **Day 01 of my DevOps hands-on project journey**, focused on Linux administration, Bash scripting, system monitoring, automation, backup/recovery, security, process management, and log management.

The goal of these projects is to transform Linux and shell scripting concepts into practical DevOps automation skills.

---

# 📌 Day 01 Overview

| #  | Project                             | Main Skills                       |
| -- | ----------------------------------- | --------------------------------- |
| 01 | Automated System Health Checker     | System Monitoring, Bash           |
| 02 | Disk Usage Alerting Script          | Disk Monitoring, Alerting         |
| 03 | Automated User Management           | User & Group Administration       |
| 04 | Linux Server Hardening              | Linux Security, SSH, Firewall     |
| 05 | Automated Backup & Restore          | Backup, Recovery, Automation      |
| 06 | Log Analysis & Error Detection      | Log Analysis, Troubleshooting     |
| 07 | Application Process Watchdog        | Process Monitoring, Auto Recovery |
| 08 | Log Rotation Automation             | Log Management, Compression       |
| 09 | Real-Time System Monitor            | Real-Time Monitoring              |
| 10 | Automated Backup & Restore Solution | Full/Incremental Backup, DR       |

---

# 🛠️ Technologies & Linux Tools

## Operating System

* Linux
* Ubuntu

## Scripting

* Bash Shell Scripting

## Linux Commands & Tools

* `top`
* `free`
* `df`
* `du`
* `uptime`
* `ps`
* `pgrep`
* `systemctl`
* `ss`
* `ip`
* `find`
* `grep`
* `awk`
* `sed`
* `sort`
* `uniq`
* `tar`
* `gzip`
* `sha256sum`
* `useradd`
* `userdel`
* `usermod`
* `passwd`
* `groupadd`
* `chmod`
* `chown`
* `nohup`

---

# 📂 Repository Structure

```text
Day-01-Linux-Shell/
│
├── 01-Automated-System-Health-Checker/
│   ├── config/
│   ├── docs/
│   ├── logs/
│   ├── reports/
│   ├── screenshots/
│   ├── scripts/
│   ├── tests/
│   ├── .gitignore
│   └── README.md
│
├── 02-Disk-Usage-Alerting-Script/
│   ├── config/
│   ├── docs/
│   ├── logs/
│   ├── reports/
│   ├── screenshots/
│   ├── scripts/
│   ├── tests/
│   └── README.md
│
├── 03-Automated-User-Management/
│
├── 04-Linux-Server-Hardening/
│
├── 05-Automated-Backup-Restore/
│
├── 06-Log-Analysis-Error-Detection/
│
├── 07-Application-Process-Watchdog/
│
├── 08-Log-Rotation-Automation/
│
├── 09-Realtime-System-Monitor/
│
└── 10-Automated-Backup-Restore-Solution/
```

Each project contains its own scripts, configuration, documentation, logs, reports, screenshots, and test resources.

---

# 1️⃣ Automated System Health Checker

## Description

A Bash-based Linux monitoring tool that checks the health of a system.

### Monitors

* CPU usage
* Memory usage
* Disk usage
* Load average
* System uptime
* Running processes
* Failed systemd services
* Network information

### Features

* Configurable thresholds
* Automated health checks
* Logging
* Report generation
* Status identification

---

# 2️⃣ Disk Usage Alerting Script

## Description

A Bash script that monitors filesystem utilization and generates alerts when disk usage exceeds configured thresholds.

### Features

* Disk utilization monitoring
* Warning threshold
* Critical threshold
* Multiple filesystem checks
* Logging
* Automated alert detection

Example configuration:

```bash
DISK_WARNING=70
DISK_CRITICAL=90
```

---

# 3️⃣ Automated User Management

## Description

A Linux user and group management automation tool.

### Supported Operations

```text
create
delete
lock
unlock
info
list
group-create
group-add
```

### Features

* User creation
* User deletion
* User locking/unlocking
* Group creation
* Group membership management
* User information
* Privilege validation
* Logging

---

# 4️⃣ Linux Server Hardening

## Description

A Linux security auditing and hardening project.

### Security Checks

* Firewall status
* SSH service
* SSH configuration
* Open ports
* Failed services
* World-writable files
* Root SSH access
* SSH password authentication

### Technologies

```text
UFW
SSH
systemctl
ss
find
Bash
```

The project generates a security report containing:

```text
PASS
WARN
FAIL
```

---

# 5️⃣ Automated Backup & Restore

## Description

A Bash-based backup and recovery solution for application data.

### Features

* Timestamped backups
* Compressed archives
* Archive integrity verification
* Restore functionality
* Retention policy
* Logging
* Reports

Example:

```bash
RETENTION_DAYS=7
```

---

# 6️⃣ Log Analysis & Error Detection

## Description

A Bash-based application log analysis tool.

### Detects

* ERROR
* CRITICAL
* FAILED
* FAILURE
* WARNING
* HTTP 4xx
* HTTP 5xx

### Features

* Error counting
* Warning counting
* HTTP error detection
* Frequent error identification
* Severity assessment
* Report generation
* Error logging

---

# 7️⃣ Application Process Watchdog

## Description

A process monitoring and automatic recovery tool.

The watchdog continuously checks whether an application process is running.

If the application stops:

```text
Application stops
       ↓
Watchdog detects failure
       ↓
Watchdog restarts application
       ↓
Restart recorded in log
       ↓
Monitoring continues
```

### Features

* Process monitoring
* Automatic restart
* Restart limit
* Logging
* Failure recovery

---

# 8️⃣ Log Rotation Automation

## Description

A Bash automation tool that prevents application logs from growing indefinitely.

### Features

* Log size monitoring
* Automatic rotation
* Compression
* Backup retention
* Report generation

Example:

```bash
MAX_SIZE_KB=10
MAX_BACKUPS=5
COMPRESS=true
```

---

# 9️⃣ Real-Time System Monitor

## Description

A terminal-based real-time Linux monitoring dashboard.

### Displays

* CPU utilization
* Memory utilization
* Disk utilization
* Load average
* Uptime
* Running processes
* Top CPU processes
* Top memory processes
* Network information

The dashboard refreshes automatically based on the configured interval.

Example:

```bash
REFRESH_INTERVAL=3
```

---

# 🔟 Automated Backup & Restore Solution

## Description

An advanced backup and disaster recovery automation project.

Unlike Project 5, this solution supports **full and incremental backups**.

### Features

* Full backup
* Incremental backup
* Compression
* Backup verification
* SHA256 checksums
* Restore functionality
* Retention policies
* Logging
* Reporting

Example:

```text
Application Data
       ↓
Full Backup
       ↓
Incremental Changes
       ↓
Compressed Archives
       ↓
Integrity Verification
       ↓
Checksum
       ↓
Retention Management
       ↓
Restore
```

---

# 📊 Day 01 Skills Covered

After completing these projects, the following DevOps skills were practiced:

### Linux Administration

* Filesystem management
* Process management
* User management
* Group management
* Permissions
* Services
* Networking
* System monitoring

### Bash Scripting

* Variables
* Conditions
* Loops
* Functions
* Command-line arguments
* Exit codes
* Input validation
* Error handling
* Configuration files

### Monitoring

* CPU monitoring
* Memory monitoring
* Disk monitoring
* Process monitoring
* Service monitoring
* Network monitoring

### Security

* SSH
* Firewall
* Open ports
* File permissions
* Security auditing
* Server hardening

### Backup & Recovery

* Full backups
* Incremental backups
* Compression
* Integrity verification
* SHA256 checksums
* Restore operations
* Retention policies

### Logging

* Application logs
* Error detection
* Log rotation
* Compression
* Log retention

---

# 🧪 Testing Strategy

Each project was tested using real Linux commands and controlled test scenarios.

Testing included:

* Normal execution
* Error conditions
* Threshold conditions
* Failure simulation
* Process termination
* Disk alert simulation
* Log rotation
* Backup restoration
* Security checks

Screenshots of important tests are stored inside each project's:

```text
screenshots/
```

directory.

---

# 📚 Documentation

Detailed technical documentation for every project is available inside:

```text
docs/
```

Each documentation file explains:

* Project objective
* Architecture/workflow
* Technologies
* Configuration
* Implementation
* Testing
* DevOps skills
* Interview explanation
* Future improvements

---

# 📸 Screenshots

Project execution and testing screenshots are stored inside each project's:

```text
screenshots/
```

directory.

These screenshots demonstrate the actual hands-on execution of the projects.

---

# 🎯 Learning Outcomes

By completing Day 01, I practiced how to:

* Automate Linux administration tasks
* Write Bash automation scripts
* Monitor Linux infrastructure
* Analyze application logs
* Automate backup and recovery
* Monitor application processes
* Implement automatic process recovery
* Manage Linux users and groups
* Perform basic Linux security auditing
* Automate log rotation
* Implement retention policies
* Troubleshoot Linux systems

---

# 💼 DevOps Interview Preparation

## Question 1

### Why is Bash scripting useful in DevOps?

Bash scripting is useful in DevOps because it allows engineers to automate repetitive Linux administration and operational tasks such as system monitoring, backups, deployments, log analysis, user management, and health checks.

## Question 2

### How did you monitor CPU and memory?

I used Linux commands such as `top` and `free` to collect CPU and memory information and processed the output using Bash and tools such as `awk`.

## Question 3

### How did you implement automatic process recovery?

I used a watchdog script that periodically checks whether the target process exists. If the process is not running, the script starts it again and records the restart in a log.

## Question 4

### Why is log rotation required?

Log rotation prevents log files from growing indefinitely and consuming excessive disk space. Rotated logs can also be compressed and retained according to a defined policy.

## Question 5

### What is the difference between full and incremental backup?

A full backup contains all selected data, while an incremental backup contains data that has changed since the relevant previous backup.

---

# 🚀 Future Improvements

These projects can later be integrated with:

* Jenkins
* Docker
* Kubernetes
* Ansible
* Terraform
* Prometheus
* Grafana
* ELK Stack
* OpenSearch
* AWS
* CI/CD pipelines
* Alertmanager
* Slack
* Microsoft Teams

This will allow the Day 01 Linux automation projects to evolve into production-style DevOps solutions.

---

# 🏆 Day 01 Status

```text
┌─────────────────────────────────────────────┐
│          DEVOPS DAY 01 — COMPLETED          │
├─────────────────────────────────────────────┤
│                                             │
│  ✅ Project 01 — System Health Checker      │
│  ✅ Project 02 — Disk Usage Alerting        │
│  ✅ Project 03 — User Management            │
│  ✅ Project 04 — Linux Server Hardening     │
│  ✅ Project 05 — Backup & Restore           │
│  ✅ Project 06 — Log Analysis               │
│  ✅ Project 07 — Process Watchdog           │
│  ✅ Project 08 — Log Rotation               │
│  ✅ Project 09 — System Monitor             │
│  ✅ Project 10 — Backup & Restore Solution  │
│                                             │
│              10 / 10 COMPLETED              │
└─────────────────────────────────────────────┘
```

---

# 👨‍💻 Project Approach

For every project, I followed a practical DevOps workflow:

```text
Understand Requirement
        ↓
Create Project Structure
        ↓
Create Configuration
        ↓
Write Bash Script
        ↓
Execute Script
        ↓
Test Normal Scenario
        ↓
Test Failure Scenario
        ↓
Generate Logs/Reports
        ↓
Capture Screenshots
        ↓
Document Project
        ↓
Git Version Control
```

---

# 📌 Conclusion

Day 01 focused on building a strong practical foundation in Linux and Bash scripting.

The projects progressed from basic system monitoring to advanced automation involving security auditing, process recovery, log management, and backup/disaster recovery.

These projects provide the Linux and scripting foundation required for the next stages of the DevOps journey, including Git, Jenkins, Docker, Kubernetes, Ansible, Terraform, CI/CD, monitoring, and DevSecOps.
