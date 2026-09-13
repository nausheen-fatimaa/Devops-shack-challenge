# Automated Backup & Restore

## 1. Project Overview

This project automates backup creation and restoration of application data on Linux.

The backup script creates compressed archives, verifies archive integrity, maintains logs, generates reports, and removes old backups according to the retention policy.

## 2. Objectives

* Automate application backups
* Compress backup files
* Verify backup integrity
* Restore application data
* Implement retention
* Maintain backup logs and reports

## 3. Technologies Used

* Linux
* Bash
* tar
* gzip
* find
* date

## 4. Configuration

```bash
BACKUP_SOURCE="$BASE_DIR/test-data"
BACKUP_DIR="$BASE_DIR/backups"
RETENTION_DAYS=7
```

## 5. Working Process

### Backup

1. Validate source directory.
2. Create timestamp.
3. Create compressed archive.
4. Verify archive integrity.
5. Write operation to log.
6. Generate backup report.
7. Remove backups older than the retention period.

### Restore

1. Identify the latest backup.
2. Extract the archive.
3. Restore files into the restore directory.
4. Verify restored content.
5. Record the operation.

## 6. Testing

The project was tested by:

* Creating test application data
* Running the backup script
* Verifying the generated archive
* Running the restore script
* Checking restored files
* Testing an invalid backup source
* Testing retention behavior

## 7. DevOps Skills Demonstrated

* Backup automation
* Linux administration
* Bash scripting
* Data recovery
* Archive management
* Retention policies
* Error handling
* Logging

## 8. Interview Explanation

I developed an automated Linux backup and restore solution using Bash. It creates timestamped compressed backups, verifies their integrity, maintains logs and reports, and supports restoration of the latest backup. I also implemented a retention policy to automatically remove older backup files.

