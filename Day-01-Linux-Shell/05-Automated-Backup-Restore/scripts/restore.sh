#!/bin/bash

# ==========================================
# Automated Restore Script
# ==========================================

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

BACKUP_DIR="$BASE_DIR/backups"
RESTORE_DIR="$BASE_DIR/restore-test"
LOG_FILE="$BASE_DIR/logs/backup.log"

LATEST_BACKUP=$(ls -t "$BACKUP_DIR"/*.tar.gz 2>/dev/null | head -n 1)

if [ -z "$LATEST_BACKUP" ]; then
    echo "ERROR: No backup found."
    exit 1
fi

echo "=========================================="
echo "        BACKUP RESTORE SYSTEM"
echo "=========================================="

echo "Backup selected:"
echo "$LATEST_BACKUP"

rm -rf "$RESTORE_DIR"

mkdir -p "$RESTORE_DIR"

echo
echo "Restoring backup..."

tar -xzf "$LATEST_BACKUP" -C "$RESTORE_DIR"

if [ $? -eq 0 ]; then

    echo "Restore completed successfully."

    echo
    echo "Restored files:"
    find "$RESTORE_DIR" -type f

    echo
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] RESTORE SUCCESS - $LATEST_BACKUP" >> "$LOG_FILE"

else

    echo "ERROR: Restore failed."

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] RESTORE FAILED - $LATEST_BACKUP" >> "$LOG_FILE"

    exit 1
fi

echo
echo "=========================================="

exit 0