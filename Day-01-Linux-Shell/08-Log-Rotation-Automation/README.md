# Log Rotation Automation Script

## 1. Project Overview

This project automates application log rotation to prevent log files from continuously growing and consuming disk space.

When the configured size threshold is reached, the log is rotated, compressed, and older backups are removed according to the retention policy.

## 2. Objectives

* Monitor log file size
* Automatically rotate logs
* Compress rotated logs
* Maintain a fixed number of backups
* Prevent excessive disk consumption
* Generate rotation reports

## 3. Technologies Used

* Linux
* Bash
* du
* mv
* gzip
* find

## 4. Configuration

```bash
MAX_SIZE_KB=10
MAX_BACKUPS=5
COMPRESS=true
```

## 5. Working Process

1. Check the log file size.
2. Compare size against configured threshold.
3. If below threshold, no rotation is performed.
4. If threshold is exceeded, rename the current log.
5. Create a new empty log.
6. Compress the rotated log.
7. Remove old backups.
8. Generate a report.

## 6. Testing

The project was tested with:

* A log below the threshold
* A log above the threshold
* Log rotation
* Compression
* Backup retention

## 7. DevOps Skills Demonstrated

* Log management
* Linux administration
* Bash scripting
* Disk management
* Compression
* Automation
* Retention policies

## 8. Interview Explanation

I created an automated log rotation script that monitors application log size and rotates logs when they exceed a configured threshold. Rotated logs can be compressed and older backups are automatically removed based on the retention policy. This helps prevent logs from consuming excessive disk space.

