#!/bin/bash

# ==========================================
# Disk Usage Alerting Script
# ==========================================

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

CONFIG_FILE="$BASE_DIR/config/disk-threshold.conf"
LOG_FILE="$BASE_DIR/logs/disk-alert.log"
REPORT_FILE="$BASE_DIR/reports/disk-report.txt"

# Load configuration
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "ERROR: Configuration file not found."
    exit 1
fi

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "==========================================" | tee "$REPORT_FILE"
echo "        DISK USAGE MONITOR" | tee -a "$REPORT_FILE"
echo "==========================================" | tee -a "$REPORT_FILE"
echo "Timestamp: $TIMESTAMP" | tee -a "$REPORT_FILE"
echo | tee -a "$REPORT_FILE"

# Check all mounted filesystems
df -P | awk 'NR>1 {print $5, $6}' | while read usage mountpoint
do

    usage=${usage%\%}

    if [ "$usage" -ge "$DISK_CRITICAL" ]; then
        status="CRITICAL"

    elif [ "$usage" -ge "$DISK_WARNING" ]; then
        status="WARNING"

    else
        status="OK"
    fi

    echo "Filesystem: $mountpoint" | tee -a "$REPORT_FILE"
    echo "Usage     : $usage%" | tee -a "$REPORT_FILE"
    echo "Status    : $status" | tee -a "$REPORT_FILE"
    echo "------------------------------------------" | tee -a "$REPORT_FILE"

    if [ "$status" = "CRITICAL" ]; then
        echo "[$TIMESTAMP] CRITICAL: $mountpoint is ${usage}% full" >> "$LOG_FILE"

    elif [ "$status" = "WARNING" ]; then
        echo "[$TIMESTAMP] WARNING: $mountpoint is ${usage}% full" >> "$LOG_FILE"
    fi

done

echo "Disk monitoring completed." | tee -a "$REPORT_FILE"

exit 0