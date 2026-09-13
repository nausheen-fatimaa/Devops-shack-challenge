#!/bin/bash

# ==========================================
# Automated Linux System Health Checker
# ==========================================

# Load configuration
CONFIG_FILE="$(dirname "$0")/../config/thresholds.conf"

if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "ERROR: Configuration file not found."
    exit 1
fi

# Project directories
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

LOG_FILE="$BASE_DIR/logs/health-check.log"
REPORT_FILE="$BASE_DIR/reports/health-report.txt"

# Create timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# ------------------------------------------
# Functions
# ------------------------------------------

log_message() {
    echo "[$TIMESTAMP] $1" >> "$LOG_FILE"
}

print_header() {
    echo "=========================================="
    echo "       LINUX SYSTEM HEALTH CHECK"
    echo "=========================================="
    echo
}

# ------------------------------------------
# System Information
# ------------------------------------------

HOSTNAME=$(hostname)
UPTIME=$(uptime -p)
LOAD_AVERAGE=$(awk '{print $1}' /proc/loadavg)

# ------------------------------------------
# CPU Usage
# ------------------------------------------

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | \
    awk '{print 100 - $8}' | cut -d. -f1)

# ------------------------------------------
# Memory Usage
# ------------------------------------------

MEMORY_USAGE=$(free | awk '/Mem:/ {
    printf "%.0f", ($3/$2) * 100
}')

# ------------------------------------------
# Disk Usage
# ------------------------------------------

DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

# ------------------------------------------
# Process Information
# ------------------------------------------

PROCESS_COUNT=$(ps aux --no-heading | wc -l)

# ------------------------------------------
# Failed Services
# ------------------------------------------

FAILED_SERVICES=$(systemctl --failed --no-legend 2>/dev/null | wc -l)

# ------------------------------------------
# Network Check
# ------------------------------------------

NETWORK_STATUS="DOWN"

if ip route | grep -q default; then
    NETWORK_STATUS="UP"
fi

# ------------------------------------------
# Health Evaluation
# ------------------------------------------

STATUS="HEALTHY"

if [ "$CPU_USAGE" -ge "$CPU_THRESHOLD" ]; then
    STATUS="WARNING"
fi

if [ "$MEMORY_USAGE" -ge "$MEMORY_THRESHOLD" ]; then
    STATUS="WARNING"
fi

if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
    STATUS="WARNING"
fi

if [ "$FAILED_SERVICES" -gt 0 ]; then
    STATUS="WARNING"
fi

if [ "$NETWORK_STATUS" = "DOWN" ]; then
    STATUS="WARNING"
fi

# ------------------------------------------
# Display Report
# ------------------------------------------

{
    print_header

    echo "Timestamp        : $TIMESTAMP"
    echo "Hostname         : $HOSTNAME"
    echo "Uptime           : $UPTIME"
    echo "Load Average     : $LOAD_AVERAGE"
    echo
    echo "CPU Usage        : $CPU_USAGE%"
    echo "Memory Usage     : $MEMORY_USAGE%"
    echo "Disk Usage       : $DISK_USAGE%"
    echo
    echo "Running Processes: $PROCESS_COUNT"
    echo "Failed Services  : $FAILED_SERVICES"
    echo "Network Status   : $NETWORK_STATUS"
    echo
    echo "Overall Status   : $STATUS"
    echo
    echo "=========================================="

} | tee "$REPORT_FILE"

# ------------------------------------------
# Logging
# ------------------------------------------

log_message "System health check completed - STATUS: $STATUS"

exit 0