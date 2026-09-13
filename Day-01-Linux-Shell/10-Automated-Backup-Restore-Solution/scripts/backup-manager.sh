#!/bin/bash

# ==========================================
# Automated Backup & Restore Solution
# Backup Manager
# ==========================================

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

CONFIG_FILE="$BASE_DIR/config/backup-manager.conf"

LOG_FILE="$BASE_DIR/logs/backup-manager.log"

REPORT_FILE="$BASE_DIR/reports/backup-report.txt"

# ------------------------------------------
# Load configuration
# ------------------------------------------

if [ ! -f "$CONFIG_FILE" ]; then
    echo "ERROR: Configuration file not found."
    exit 1
fi

source "$CONFIG_FILE"

TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')

# ------------------------------------------
# Logging
# ------------------------------------------

log_message() {

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" \
        | tee -a "$LOG_FILE"

}

# ------------------------------------------
# Validate source
# ------------------------------------------

if [ ! -d "$BACKUP_SOURCE" ]; then

    log_message "ERROR: Backup source does not exist."

    exit 1

fi

# ------------------------------------------
# Create directories
# ------------------------------------------

mkdir -p "$FULL_BACKUP_DIR"
mkdir -p "$INCREMENTAL_BACKUP_DIR"

# ------------------------------------------
# Determine backup type
# ------------------------------------------

FULL_BACKUP_COUNT=$(find "$FULL_BACKUP_DIR" \
    -type f \
    -name "*.tar.gz" \
    | wc -l)

if [ "$FULL_BACKUP_COUNT" -eq 0 ]; then

    BACKUP_TYPE="FULL"

else

    BACKUP_TYPE="INCREMENTAL"

fi

# ------------------------------------------
# Start report
# ------------------------------------------

echo "==========================================" > "$REPORT_FILE"

echo "     AUTOMATED BACKUP MANAGER REPORT" >> "$REPORT_FILE"

echo "==========================================" >> "$REPORT_FILE"

echo "Timestamp : $TIMESTAMP" >> "$REPORT_FILE"

echo "Source    : $BACKUP_SOURCE" >> "$REPORT_FILE"

echo "Backup Type: $BACKUP_TYPE" >> "$REPORT_FILE"

echo >> "$REPORT_FILE"

# ==========================================
# FULL BACKUP
# ==========================================

if [ "$BACKUP_TYPE" = "FULL" ]; then

    BACKUP_FILE="$FULL_BACKUP_DIR/full-backup-$TIMESTAMP.tar.gz"

    log_message "Creating FULL backup."

    tar -czf "$BACKUP_FILE" \
        -C "$(dirname "$BACKUP_SOURCE")" \
        "$(basename "$BACKUP_SOURCE")"

    if [ $? -ne 0 ]; then

        log_message "ERROR: Full backup failed."

        echo "STATUS: FAILED" >> "$REPORT_FILE"

        exit 1

    fi

    log_message "Full backup created: $BACKUP_FILE"

# ==========================================
# INCREMENTAL BACKUP
# ==========================================

else

    BACKUP_FILE="$INCREMENTAL_BACKUP_DIR/incremental-backup-$TIMESTAMP.tar.gz"

    LAST_BACKUP=$(find "$FULL_BACKUP_DIR" "$INCREMENTAL_BACKUP_DIR" \
        -type f \
        -name "*.tar.gz" \
        -printf "%T@ %p\n" \
        | sort -n \
        | tail -1 \
        | cut -d' ' -f2-)

    log_message "Creating INCREMENTAL backup."

    if [ -z "$LAST_BACKUP" ]; then

        log_message "No previous backup found. Creating full backup."

        tar -czf "$BACKUP_FILE" \
            -C "$(dirname "$BACKUP_SOURCE")" \
            "$(basename "$BACKUP_SOURCE")"

    else

        find "$BACKUP_SOURCE" -type f \
            -newer "$LAST_BACKUP" \
            -print > /tmp/backup-file-list.txt

        if [ -s /tmp/backup-file-list.txt ]; then

            tar -czf "$BACKUP_FILE" \
                -C / \
                -T /tmp/backup-file-list.txt

        else

            log_message "No files changed since previous backup."

            rm -f /tmp/backup-file-list.txt

            echo "STATUS: NO CHANGES" >> "$REPORT_FILE"

            exit 0

        fi

        rm -f /tmp/backup-file-list.txt

    fi

    if [ $? -ne 0 ]; then

        log_message "ERROR: Incremental backup failed."

        echo "STATUS: FAILED" >> "$REPORT_FILE"

        exit 1

    fi

    log_message "Incremental backup created: $BACKUP_FILE"

fi

# ------------------------------------------
# Verify archive
# ------------------------------------------

if tar -tzf "$BACKUP_FILE" >/dev/null 2>&1; then

    log_message "Backup integrity verification: SUCCESS"

else

    log_message "ERROR: Backup integrity verification failed."

    echo "STATUS: VERIFICATION FAILED" >> "$REPORT_FILE"

    exit 1

fi

# ------------------------------------------
# Calculate checksum
# ------------------------------------------

CHECKSUM=$(sha256sum "$BACKUP_FILE" | awk '{print $1}')

echo "Backup File : $BACKUP_FILE" >> "$REPORT_FILE"

echo "Backup Size : $(du -h "$BACKUP_FILE" | awk '{print $1}')" >> "$REPORT_FILE"

echo "SHA256      : $CHECKSUM" >> "$REPORT_FILE"

echo >> "$REPORT_FILE"

# ------------------------------------------
# Retention cleanup
# ------------------------------------------

log_message "Applying retention policy."

find "$FULL_BACKUP_DIR" \
    -type f \
    -name "*.tar.gz" \
    -mtime +"$RETENTION_DAYS" \
    -delete

find "$INCREMENTAL_BACKUP_DIR" \
    -type f \
    -name "*.tar.gz" \
    -mtime +"$RETENTION_DAYS" \
    -delete

# Keep only configured number of full backups

FULL_COUNT=$(find "$FULL_BACKUP_DIR" \
    -type f \
    -name "*.tar.gz" \
    | wc -l)

if [ "$FULL_COUNT" -gt "$MAX_FULL_BACKUPS" ]; then

    DELETE_COUNT=$((FULL_COUNT - MAX_FULL_BACKUPS))

    find "$FULL_BACKUP_DIR" \
        -type f \
        -name "*.tar.gz" \
        -printf "%T@ %p\n" \
        | sort -n \
        | head -n "$DELETE_COUNT" \
        | cut -d' ' -f2- \
        | xargs -r rm -f

fi

# Keep only configured number of incremental backups

INCREMENTAL_COUNT=$(find "$INCREMENTAL_BACKUP_DIR" \
    -type f \
    -name "*.tar.gz" \
    | wc -l)

if [ "$INCREMENTAL_COUNT" -gt "$MAX_INCREMENTAL_BACKUPS" ]; then

    DELETE_COUNT=$((INCREMENTAL_COUNT - MAX_INCREMENTAL_BACKUPS))

    find "$INCREMENTAL_BACKUP_DIR" \
        -type f \
        -name "*.tar.gz" \
        -printf "%T@ %p\n" \
        | sort -n \
        | head -n "$DELETE_COUNT" \
        | cut -d' ' -f2- \
        | xargs -r rm -f

fi

# ------------------------------------------
# Final report
# ------------------------------------------

echo "STATUS: BACKUP SUCCESSFUL" >> "$REPORT_FILE"

echo >> "$REPORT_FILE"

echo "Full Backups:" >> "$REPORT_FILE"

find "$FULL_BACKUP_DIR" \
    -type f \
    -name "*.tar.gz" \
    -printf "%f\n" >> "$REPORT_FILE"

echo >> "$REPORT_FILE"

echo "Incremental Backups:" >> "$REPORT_FILE"

find "$INCREMENTAL_BACKUP_DIR" \
    -type f \
    -name "*.tar.gz" \
    -printf "%f\n" >> "$REPORT_FILE"

echo >> "$REPORT_FILE"

echo "==========================================" >> "$REPORT_FILE"

echo "BACKUP COMPLETED" >> "$REPORT_FILE"

echo "==========================================" >> "$REPORT_FILE"

log_message "Backup process completed successfully."

exit 0