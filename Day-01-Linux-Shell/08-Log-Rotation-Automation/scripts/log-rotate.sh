#!/bin/bash

# ==========================================
# Log Rotation Automation Script
# ==========================================

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

CONFIG_FILE="$BASE_DIR/config/log-rotate.conf"
LOG_FILE_EXEC="$BASE_DIR/logs/rotation.log"
REPORT_FILE="$BASE_DIR/reports/rotation-report.txt"

# ------------------------------------------
# Load configuration
# ------------------------------------------

if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "ERROR: Configuration file not found."
    exit 1
fi

TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')

# ------------------------------------------
# Logging function
# ------------------------------------------

log_message() {

    MESSAGE="$1"

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $MESSAGE" \
        | tee -a "$LOG_FILE_EXEC"
}

# ------------------------------------------
# Validate log
# ------------------------------------------

if [ ! -f "$LOG_FILE" ]; then

    log_message "ERROR: Log file does not exist."

    exit 1
fi

# ------------------------------------------
# Calculate size
# ------------------------------------------

SIZE_KB=$(du -k "$LOG_FILE" | awk '{print $1}')

log_message "Current log size: ${SIZE_KB} KB"

# ------------------------------------------
# Create report
# ------------------------------------------

echo "==========================================" > "$REPORT_FILE"
echo "        LOG ROTATION REPORT" >> "$REPORT_FILE"
echo "==========================================" >> "$REPORT_FILE"

echo "Timestamp : $TIMESTAMP" >> "$REPORT_FILE"
echo "Log File  : $LOG_FILE" >> "$REPORT_FILE"
echo "Size      : ${SIZE_KB} KB" >> "$REPORT_FILE"
echo "Threshold : ${MAX_SIZE_KB} KB" >> "$REPORT_FILE"

echo >> "$REPORT_FILE"

# ------------------------------------------
# Rotation decision
# ------------------------------------------

if [ "$SIZE_KB" -lt "$MAX_SIZE_KB" ]; then

    log_message "Log size is below rotation threshold."

    echo "STATUS: NO ROTATION REQUIRED" >> "$REPORT_FILE"

    exit 0
fi

# ------------------------------------------
# Perform rotation
# ------------------------------------------

log_message "Log size exceeded threshold."
log_message "Starting log rotation."

ROTATED_FILE="$ROTATION_DIR/application-$TIMESTAMP.log"

mv "$LOG_FILE" "$ROTATED_FILE"

if [ $? -ne 0 ]; then

    log_message "ERROR: Failed to rotate log."

    echo "STATUS: ROTATION FAILED" >> "$REPORT_FILE"

    exit 1
fi

log_message "Log rotated successfully."

# ------------------------------------------
# Create new empty log
# ------------------------------------------

touch "$LOG_FILE"

if [ $? -ne 0 ]; then

    log_message "ERROR: Failed to create new log."

    exit 1
fi

log_message "New log file created."

# ------------------------------------------
# Compress rotated log
# ------------------------------------------

if [ "$COMPRESS" = true ]; then

    gzip "$ROTATED_FILE"

    if [ $? -eq 0 ]; then

        log_message "Rotated log compressed."

    else

        log_message "WARNING: Compression failed."

    fi
fi

# ------------------------------------------
# Cleanup old backups
# ------------------------------------------

BACKUP_COUNT=$(find "$ROTATION_DIR" \
    -maxdepth 1 \
    -type f \
    -name "application-*.log.gz" \
    | wc -l)

log_message "Current rotated backup count: $BACKUP_COUNT"

if [ "$BACKUP_COUNT" -gt "$MAX_BACKUPS" ]; then

    DELETE_COUNT=$((BACKUP_COUNT - MAX_BACKUPS))

    log_message "Removing $DELETE_COUNT old backup(s)."

    find "$ROTATION_DIR" \
        -maxdepth 1 \
        -type f \
        -name "application-*.log.gz" \
        -printf '%T@ %p\n' \
        | sort -n \
        | head -n "$DELETE_COUNT" \
        | cut -d' ' -f2- \
        | xargs -r rm -f
fi

# ------------------------------------------
# Final report
# ------------------------------------------

echo "STATUS: ROTATION SUCCESSFUL" >> "$REPORT_FILE"

echo >> "$REPORT_FILE"

echo "Rotated Files:" >> "$REPORT_FILE"

find "$ROTATION_DIR" \
    -maxdepth 1 \
    -type f \
    -name "application-*.log.gz" \
    -printf "%f\n" >> "$REPORT_FILE"

echo >> "$REPORT_FILE"

echo "==========================================" >> "$REPORT_FILE"
echo "LOG ROTATION COMPLETED" >> "$REPORT_FILE"
echo "==========================================" >> "$REPORT_FILE"

log_message "Log rotation completed successfully."

exit 0