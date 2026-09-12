#!/bin/bash

# ==========================================
# Log Analysis & Error Detection Tool
# ==========================================

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

CONFIG_FILE="$BASE_DIR/config/log-analyzer.conf"

# Load configuration
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "ERROR: Configuration file not found."
    exit 1
fi

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "==========================================" | tee "$REPORT_FILE"
echo "       LOG ANALYSIS REPORT" | tee -a "$REPORT_FILE"
echo "==========================================" | tee -a "$REPORT_FILE"

echo "Analysis Time : $TIMESTAMP" | tee -a "$REPORT_FILE"
echo "Log File      : $LOG_FILE" | tee -a "$REPORT_FILE"

echo | tee -a "$REPORT_FILE"

# ------------------------------------------
# Validate log file
# ------------------------------------------

if [ ! -f "$LOG_FILE" ]; then
    echo "ERROR: Log file does not exist."
    echo "[$TIMESTAMP] ANALYSIS FAILED - Log file missing" >> "$ANALYZER_LOG"
    exit 1
fi

# ------------------------------------------
# Basic statistics
# ------------------------------------------

TOTAL_LINES=$(wc -l < "$LOG_FILE")

ERROR_COUNT=$(grep -Ei "$ERROR_PATTERN" "$LOG_FILE" | wc -l)

WARNING_COUNT=$(grep -Ei "$WARNING_PATTERN" "$LOG_FILE" | wc -l)

INFO_COUNT=$(grep -Ei "INFO" "$LOG_FILE" | wc -l)

echo "Total Log Entries : $TOTAL_LINES" | tee -a "$REPORT_FILE"
echo "Error Count       : $ERROR_COUNT" | tee -a "$REPORT_FILE"
echo "Warning Count     : $WARNING_COUNT" | tee -a "$REPORT_FILE"
echo "Info Count        : $INFO_COUNT" | tee -a "$REPORT_FILE"

echo | tee -a "$REPORT_FILE"

# ------------------------------------------
# Error Details
# ------------------------------------------

echo "==========================================" | tee -a "$REPORT_FILE"
echo "ERROR / CRITICAL / FAILURE EVENTS" | tee -a "$REPORT_FILE"
echo "==========================================" | tee -a "$REPORT_FILE"

grep -Ei "$ERROR_PATTERN" "$LOG_FILE" | tee -a "$REPORT_FILE"

echo | tee -a "$REPORT_FILE"

# ------------------------------------------
# Warning Details
# ------------------------------------------

echo "==========================================" | tee -a "$REPORT_FILE"
echo "WARNING EVENTS" | tee -a "$REPORT_FILE"
echo "==========================================" | tee -a "$REPORT_FILE"

grep -Ei "$WARNING_PATTERN" "$LOG_FILE" | tee -a "$REPORT_FILE"

echo | tee -a "$REPORT_FILE"

# ------------------------------------------
# HTTP Errors
# ------------------------------------------

echo "==========================================" | tee -a "$REPORT_FILE"
echo "HTTP ERRORS" | tee -a "$REPORT_FILE"
echo "==========================================" | tee -a "$REPORT_FILE"

grep -E "HTTP (4[0-9][0-9]|5[0-9][0-9])" "$LOG_FILE" \
    | tee -a "$REPORT_FILE"

echo | tee -a "$REPORT_FILE"

# ------------------------------------------
# Most Frequent Errors
# ------------------------------------------

echo "==========================================" | tee -a "$REPORT_FILE"
echo "MOST FREQUENT ERROR MESSAGES" | tee -a "$REPORT_FILE"
echo "==========================================" | tee -a "$REPORT_FILE"

grep -Ei "$ERROR_PATTERN" "$LOG_FILE" \
    | sed -E 's/^[^ ]+ [^ ]+ //' \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -10 \
    | tee -a "$REPORT_FILE"

echo | tee -a "$REPORT_FILE"

# ------------------------------------------
# Severity Assessment
# ------------------------------------------

echo "==========================================" | tee -a "$REPORT_FILE"
echo "SEVERITY ASSESSMENT" | tee -a "$REPORT_FILE"
echo "==========================================" | tee -a "$REPORT_FILE"

if [ "$ERROR_COUNT" -eq 0 ]; then

    echo "STATUS: HEALTHY" | tee -a "$REPORT_FILE"
    echo "No errors detected."

elif [ "$ERROR_COUNT" -le 3 ]; then

    echo "STATUS: WARNING" | tee -a "$REPORT_FILE"
    echo "Some errors detected. Investigation recommended."

else

    echo "STATUS: CRITICAL" | tee -a "$REPORT_FILE"
    echo "Multiple errors detected. Immediate investigation recommended."

fi

echo | tee -a "$REPORT_FILE"

echo "==========================================" | tee -a "$REPORT_FILE"
echo "LOG ANALYSIS COMPLETED" | tee -a "$REPORT_FILE"
echo "==========================================" | tee -a "$REPORT_FILE"

# ------------------------------------------
# Execution Log
# ------------------------------------------

echo "[$TIMESTAMP] ANALYSIS SUCCESS - Errors: $ERROR_COUNT, Warnings: $WARNING_COUNT" \
    >> "$ANALYZER_LOG"

echo
echo "Report generated:"
echo "$REPORT_FILE"

exit 0