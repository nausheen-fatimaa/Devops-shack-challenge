#!/bin/bash

# ==========================================
# Backup Verification Tool
# ==========================================

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

BACKUP_DIR="$BASE_DIR/backups"

LATEST_BACKUP=$(find "$BACKUP_DIR" \
    -type f \
    -name "*.tar.gz" \
    -printf "%T@ %p\n" \
    | sort -n \
    | tail -1 \
    | cut -d' ' -f2-)

if [ -z "$LATEST_BACKUP" ]; then

    echo "ERROR: No backup found."

    exit 1

fi

echo "=========================================="

echo "       BACKUP VERIFICATION"

echo "=========================================="

echo "Backup:"
echo "$LATEST_BACKUP"

echo

echo "Checking archive integrity..."

if tar -tzf "$LATEST_BACKUP" >/dev/null 2>&1; then

    echo "Integrity: PASS"

else

    echo "Integrity: FAIL"

    exit 1

fi

echo

echo "SHA256 checksum:"

sha256sum "$LATEST_BACKUP"

echo

echo "Backup contents:"

tar -tzf "$LATEST_BACKUP" | head -20

echo

echo "=========================================="

echo "BACKUP VERIFICATION COMPLETED"

echo "=========================================="

exit 0