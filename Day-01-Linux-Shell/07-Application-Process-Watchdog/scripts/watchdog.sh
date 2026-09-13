#!/bin/bash

# ==========================================
# Application Process Watchdog
# ==========================================

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

CONFIG_FILE="$BASE_DIR/config/watchdog.conf"
LOG_FILE="$BASE_DIR/logs/watchdog.log"
REPORT_FILE="$BASE_DIR/reports/watchdog-report.txt"

# ------------------------------------------
# Load configuration
# ------------------------------------------

if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "ERROR: Configuration file not found."
    exit 1
fi

# ------------------------------------------
# Functions
# ------------------------------------------

log_message() {

    MESSAGE="$1"

    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    echo "[$TIMESTAMP] $MESSAGE" | tee -a "$LOG_FILE"
}

is_process_running() {

    pgrep -f "$PROCESS_NAME" >/dev/null 2>&1
}

start_process() {

    log_message "Starting process: $PROCESS_NAME"

    nohup "$PROCESS_COMMAND" >/dev/null 2>&1 &

    sleep 2

    if is_process_running; then
        log_message "Process started successfully."
        return 0
    else
        log_message "ERROR: Failed to start process."
        return 1
    fi
}

# ------------------------------------------
# Initial report
# ------------------------------------------

echo "==========================================" > "$REPORT_FILE"
echo "       APPLICATION WATCHDOG REPORT" >> "$REPORT_FILE"
echo "==========================================" >> "$REPORT_FILE"

echo "Process Name : $PROCESS_NAME" >> "$REPORT_FILE"
echo "Check Interval : $CHECK_INTERVAL seconds" >> "$REPORT_FILE"
echo "Max Restarts : $MAX_RESTARTS" >> "$REPORT_FILE"

echo >> "$REPORT_FILE"

# ------------------------------------------
# Check process
# ------------------------------------------

if is_process_running; then

    log_message "Process is running normally."

    echo "Initial Status: RUNNING" >> "$REPORT_FILE"

else

    log_message "Process is NOT running."

    echo "Initial Status: STOPPED" >> "$REPORT_FILE"

    start_process
fi

# ------------------------------------------
# Monitoring Loop
# ------------------------------------------

RESTART_COUNT=0

log_message "Watchdog monitoring started."

while true
do

    if is_process_running; then

        log_message "STATUS: $PROCESS_NAME is running."

    else

        log_message "ALERT: $PROCESS_NAME is DOWN."

        if [ "$RESTART_COUNT" -lt "$MAX_RESTARTS" ]; then

            RESTART_COUNT=$((RESTART_COUNT + 1))

            log_message "Restart attempt $RESTART_COUNT of $MAX_RESTARTS."

            if start_process; then
                log_message "Automatic recovery successful."
            else
                log_message "Automatic recovery failed."
            fi

        else

            log_message "Maximum restart limit reached."

            echo "STATUS: CRITICAL" >> "$REPORT_FILE"

            break
        fi

    fi

    sleep "$CHECK_INTERVAL"

done

# ------------------------------------------
# Final report
# ------------------------------------------

echo >> "$REPORT_FILE"
echo "==========================================" >> "$REPORT_FILE"
echo "WATCHDOG SUMMARY" >> "$REPORT_FILE"
echo "==========================================" >> "$REPORT_FILE"

echo "Total Automatic Restarts: $RESTART_COUNT" >> "$REPORT_FILE"
echo "Monitoring completed: $(date '+%Y-%m-%d %H:%M:%S')" >> "$REPORT_FILE"

exit 0