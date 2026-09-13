#!/bin/bash

# ==========================================
# Automated Restore Manager
# ==========================================

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

BACKUP_DIR="$BASE_DIR/backups"

RESTORE_DIR="$BASE_DIR/restore-test"

LOG_FILE="$BASE_DIR/logs/backup-manager.log"

LATEST_BACKUP=$(find "$BACKUP_DIR" \
    -type f \
    -name "*.tar.gz" \
    -printf "%T@ %p\n" \
    | sort -n \
    | tail -1 \
    | cut -d' ' -f2-)

if [ -z "$LATEST_BACKUP" ]; then

    echo "ERROR: No backup available."

    exit 1

fi

echo "=========================================="

echo "        AUTOMATED RESTORE MANAGER"

echo "=========================================="

echo "Selected backup:"

echo "$LATEST_BACKUP"

echo

# ------------------------------------------
# Prepare restore directory
# ------------------------------------------

rm -rf "$RESTORE_DIR"

mkdir -p "$RESTORE_DIR"

# ------------------------------------------
# Restore
# ------------------------------------------

echo "Restoring backup..."

tar -xzf "$LATEST_BACKUP" -C "$RESTORE_DIR"

if [ $? -ne 0 ]; then

    echo "ERROR: Restore failed."

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] RESTORE FAILED" \
        >> "$LOG_FILE"

    exit 1

fi

echo "Restore completed successfully."

echo

echo "Restored files:"

find "$RESTORE_DIR" -type f -print

echo

# ------------------------------------------
# Count files
# ------------------------------------------

FILE_COUNT=$(find "$RESTORE_DIR" -type f | wc -l)

echo "Restored file count: $FILE_COUNT"

echo

echo "[$(date '+%Y-%m-%d %H:%M:%S')] RESTORE SUCCESS - $LATEST_BACKUP" \
    >> "$LOG_FILE"

echo "=========================================="

exit 0