#!/bin/bash

# ==========================================
# Real-Time System Monitor Dashboard
# ==========================================

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

CONFIG_FILE="$BASE_DIR/config/monitor.conf"

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
# Logging function
# ------------------------------------------

log_event() {

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"

}

# ------------------------------------------
# CPU Usage
# ------------------------------------------

get_cpu_usage() {

    CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | \
        awk '{print $8}' | cut -d. -f1)

    CPU_USAGE=$((100 - CPU_IDLE))

    echo "$CPU_USAGE"

}

# ------------------------------------------
# Memory Usage
# ------------------------------------------

get_memory_usage() {

    free | awk '/Mem:/ {
        printf "%.0f", ($3/$2)*100
    }'

}

# ------------------------------------------
# Disk Usage
# ------------------------------------------

get_disk_usage() {

    df / | awk 'NR==2 {print $5}' | tr -d '%'

}

# ------------------------------------------
# System Load
# ------------------------------------------

get_load() {

    uptime | awk -F'load average:' '{print $2}'

}

# ------------------------------------------
# Dashboard
# ------------------------------------------

display_dashboard() {

    clear

    CURRENT_TIME=$(date '+%Y-%m-%d %H:%M:%S')

    CPU=$(get_cpu_usage)

    MEMORY=$(get_memory_usage)

    DISK=$(get_disk_usage)

    LOAD=$(get_load)

    UPTIME=$(uptime -p)

    HOSTNAME=$(hostname)

    PROCESS_COUNT=$(ps -e --no-headers | wc -l)

    echo "=============================================================="

    echo "              REAL-TIME SYSTEM MONITOR"

    echo "=============================================================="

    echo "Host        : $HOSTNAME"

    echo "Date/Time   : $CURRENT_TIME"

    echo "Uptime      : $UPTIME"

    echo

    echo "--------------------------------------------------------------"

    echo "SYSTEM RESOURCES"

    echo "--------------------------------------------------------------"

    printf "CPU Usage   : %s%%\n" "$CPU"

    printf "Memory      : %s%%\n" "$MEMORY"

    printf "Disk        : %s%%\n" "$DISK"

    printf "Load Average:%s\n" "$LOAD"

    echo "Processes   : $PROCESS_COUNT"

    echo

    echo "--------------------------------------------------------------"

    echo "TOP CPU PROCESSES"

    echo "--------------------------------------------------------------"

    ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -6

    echo

    echo "--------------------------------------------------------------"

    echo "TOP MEMORY PROCESSES"

    echo "--------------------------------------------------------------"

    ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -6

    echo

    echo "--------------------------------------------------------------"

    echo "NETWORK INFORMATION"

    echo "--------------------------------------------------------------"

    ip -brief address 2>/dev/null | head -5

    echo

    echo "--------------------------------------------------------------"

    echo "SYSTEM STATUS"

    echo "--------------------------------------------------------------"

    if [ "$CPU" -ge "$CPU_THRESHOLD" ]; then
        echo "CPU STATUS    : HIGH"
    else
        echo "CPU STATUS    : NORMAL"
    fi

    if [ "$MEMORY" -ge "$MEMORY_THRESHOLD" ]; then
        echo "MEMORY STATUS : HIGH"
    else
        echo "MEMORY STATUS : NORMAL"
    fi

    if [ "$DISK" -ge "$DISK_THRESHOLD" ]; then
        echo "DISK STATUS   : HIGH"
    else
        echo "DISK STATUS   : NORMAL"
    fi

    echo

    echo "Refresh interval: ${REFRESH_INTERVAL}s"

    echo "Press Ctrl+C to exit."

}

# ------------------------------------------
# Generate snapshot report
# ------------------------------------------

generate_report() {

    CPU=$(get_cpu_usage)

    MEMORY=$(get_memory_usage)

    DISK=$(get_disk_usage)

    LOAD=$(get_load)

    echo "==========================================" > "$REPORT_FILE"

    echo "       SYSTEM MONITOR REPORT" >> "$REPORT_FILE"

    echo "==========================================" >> "$REPORT_FILE"

    echo "Timestamp : $(date '+%Y-%m-%d %H:%M:%S')" >> "$REPORT_FILE"

    echo "Hostname  : $(hostname)" >> "$REPORT_FILE"

    echo "CPU       : ${CPU}%" >> "$REPORT_FILE"

    echo "Memory    : ${MEMORY}%" >> "$REPORT_FILE"

    echo "Disk      : ${DISK}%" >> "$REPORT_FILE"

    echo "Load      : $LOAD" >> "$REPORT_FILE"

    echo "Uptime    : $(uptime -p)" >> "$REPORT_FILE"

    echo "Processes : $(ps -e --no-headers | wc -l)" >> "$REPORT_FILE"

}

# ------------------------------------------
# Main
# ------------------------------------------

log_event "System monitor started."

while true
do

    display_dashboard

    generate_report

    log_event "Monitoring snapshot generated."

    sleep "$REFRESH_INTERVAL"

done