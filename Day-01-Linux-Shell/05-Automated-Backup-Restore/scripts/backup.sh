#!/bin/bash

# ==========================================
# Automated Backup Script
# ==========================================

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

CONFIG_FILE="$BASE_DIR/config/backup.conf"
LOG_FILE="$BASE_DIR/logs/backup.log"
REPORT_FILE="$BASE_DIR/reports/backup-report.txt"

# Load configuration
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "ERROR: Configuration file not found."
    exit 1
fi

TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')

BACKUP_FILE="$BACKUP_DIR/backup-$TIMESTAMP.tar.gz"

echo "==========================================" | tee "$REPORT_FILE"
echo "        AUTOMATED BACKUP SYSTEM" | tee -a "$REPORT_FILE"
echo "==========================================" | tee -a "$REPORT_FILE"

echo "Timestamp : $TIMESTAMP" | tee -a "$REPORT_FILE"
echo "Source    : $BACKUP_SOURCE" | tee -a "$REPORT_FILE"
echo "Destination: $BACKUP_FILE" | tee -a "$REPORT_FILE"

echo | tee -a "$REPORT_FILE"

# ------------------------------------------
# Validate source
# ------------------------------------------

if [ ! -d "$BACKUP_SOURCE" ]; then

    echo "ERROR: Backup source does not exist."

    echo "[$TIMESTAMP] BACKUP FAILED - Source missing" >> "$LOG_FILE"

    exit 1
fi

# ------------------------------------------
# Create backup directory
# ------------------------------------------

mkdir -p "$BACKUP_DIR"

# ------------------------------------------
# Create compressed backup
# ------------------------------------------

echo "Creating backup..."

tar -czf "$BACKUP_FILE" -C "$(dirname "$BACKUP_SOURCE")" "$(basename "$BACKUP_SOURCE")"

if [ $? -eq 0 ]; then

    echo "Backup created successfully."

    echo "Backup file: $BACKUP_FILE"

    echo "[$TIMESTAMP] BACKUP SUCCESS - $BACKUP_FILE" >> "$LOG_FILE"

else

    echo "ERROR: Backup creation failed."

    echo "[$TIMESTAMP] BACKUP FAILED" >> "$LOG_FILE"

    exit 1
fi

# ------------------------------------------
# Verify backup
# ------------------------------------------

if tar -tzf "$BACKUP_FILE" >/dev/null 2>&1; then

    echo "Backup verification: SUCCESS"

else

    echo "Backup verification: FAILED"

    echo "[$TIMESTAMP] BACKUP VERIFICATION FAILED" >> "$LOG_FILE"

    exit 1
fi

# ------------------------------------------
# Backup Size
# ------------------------------------------

BACKUP_SIZE=$(du -h "$BACKUP_FILE" | awk '{print $1}')

echo "Backup size: $BACKUP_SIZE" | tee -a "$REPORT_FILE"

# ------------------------------------------
# Cleanup Old Backups
# ------------------------------------------

echo "Cleaning backups older than $RETENTION_DAYS days..."

find "$BACKUP_DIR" -type f -name "*.tar.gz" \
    -mtime +"$RETENTION_DAYS" -delete

echo "Old backup cleanup completed."

echo | tee -a "$REPORT_FILE"

echo "==========================================" | tee -a "$REPORT_FILE"
echo "BACKUP COMPLETED SUCCESSFULLY" | tee -a "$REPORT_FILE"
echo "==========================================" | tee -a "$REPORT_FILE"

exit 0