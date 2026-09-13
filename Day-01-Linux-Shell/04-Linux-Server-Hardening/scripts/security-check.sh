#!/bin/bash

# ==========================================
# Linux Server Security Audit
# ==========================================

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

LOG_FILE="$BASE_DIR/logs/hardening.log"
REPORT_FILE="$BASE_DIR/reports/security-report.txt"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

PASS_COUNT=0
WARN_COUNT=0
FAIL_COUNT=0

log_message() {
    echo "[$TIMESTAMP] $1" >> "$LOG_FILE"
}

check_pass() {
    echo "[PASS] $1" | tee -a "$REPORT_FILE"
    PASS_COUNT=$((PASS_COUNT + 1))
}

check_warn() {
    echo "[WARN] $1" | tee -a "$REPORT_FILE"
    WARN_COUNT=$((WARN_COUNT + 1))
}

check_fail() {
    echo "[FAIL] $1" | tee -a "$REPORT_FILE"
    FAIL_COUNT=$((FAIL_COUNT + 1))
}

echo "==========================================" | tee "$REPORT_FILE"
echo "       LINUX SECURITY AUDIT" | tee -a "$REPORT_FILE"
echo "==========================================" | tee -a "$REPORT_FILE"
echo "Timestamp: $TIMESTAMP" | tee -a "$REPORT_FILE"
echo | tee -a "$REPORT_FILE"

# ------------------------------------------
# Root Check
# ------------------------------------------

if [ "$EUID" -eq 0 ]; then
    check_pass "Script is running with root privileges."
else
    check_warn "Script is not running as root."
fi

# ------------------------------------------
# Firewall Check
# ------------------------------------------

if command -v ufw >/dev/null 2>&1; then

    UFW_STATUS=$(sudo ufw status 2>/dev/null | head -n 1)

    if echo "$UFW_STATUS" | grep -q "active"; then
        check_pass "UFW firewall is active."
    else
        check_warn "UFW firewall is installed but not active."
    fi

else
    check_warn "UFW is not installed."
fi

# ------------------------------------------
# SSH Service Check
# ------------------------------------------

if command -v systemctl >/dev/null 2>&1; then

    if systemctl is-active --quiet ssh 2>/dev/null || \
       systemctl is-active --quiet sshd 2>/dev/null; then

        check_pass "SSH service is running."

    else

        check_warn "SSH service is not running or unavailable."

    fi

else

    check_warn "systemctl is unavailable."

fi

# ------------------------------------------
# Open Ports
# ------------------------------------------

echo | tee -a "$REPORT_FILE"
echo "Open Listening Ports:" | tee -a "$REPORT_FILE"

if command -v ss >/dev/null 2>&1; then

    ss -tuln | tee -a "$REPORT_FILE"

else

    check_warn "ss command is unavailable."

fi

# ------------------------------------------
# Failed Services
# ------------------------------------------

if command -v systemctl >/dev/null 2>&1; then

    FAILED_SERVICES=$(systemctl --failed --no-legend 2>/dev/null | wc -l)

    if [ "$FAILED_SERVICES" -eq 0 ]; then

        check_pass "No failed systemd services detected."

    else

        check_warn "$FAILED_SERVICES failed systemd service(s) detected."

    fi

else

    check_warn "Could not check systemd services."

fi

# ------------------------------------------
# World-Writable Files
# ------------------------------------------

echo | tee -a "$REPORT_FILE"
echo "Checking for world-writable files..." | tee -a "$REPORT_FILE"

WORLD_WRITABLE=$(find /etc /var -type f -perm -0002 2>/dev/null | head -n 10)

if [ -z "$WORLD_WRITABLE" ]; then

    check_pass "No world-writable files detected in checked directories."

else

    check_warn "World-writable files were detected."

    echo "$WORLD_WRITABLE" | tee -a "$REPORT_FILE"

fi

# ------------------------------------------
# Password Authentication Configuration
# ------------------------------------------

if [ -f /etc/ssh/sshd_config ]; then

    PASSWORD_AUTH=$(grep -Ei '^[[:space:]]*PasswordAuthentication[[:space:]]+' \
        /etc/ssh/sshd_config | tail -n 1)

    if [ -z "$PASSWORD_AUTH" ]; then

        check_warn "PasswordAuthentication is not explicitly configured."

    elif echo "$PASSWORD_AUTH" | grep -qi "no"; then

        check_pass "SSH password authentication is disabled."

    else

        check_warn "SSH password authentication is enabled."

    fi

else

    check_warn "SSH configuration file not found."

fi

# ------------------------------------------
# Root SSH Login
# ------------------------------------------

if [ -f /etc/ssh/sshd_config ]; then

    ROOT_LOGIN=$(grep -Ei '^[[:space:]]*PermitRootLogin[[:space:]]+' \
        /etc/ssh/sshd_config | tail -n 1)

    if echo "$ROOT_LOGIN" | grep -qi "no"; then

        check_pass "Direct SSH root login is disabled."

    else

        check_warn "Direct SSH root login may be enabled."

    fi

fi

# ------------------------------------------
# Summary
# ------------------------------------------

echo | tee -a "$REPORT_FILE"
echo "==========================================" | tee -a "$REPORT_FILE"
echo "              SUMMARY" | tee -a "$REPORT_FILE"
echo "==========================================" | tee -a "$REPORT_FILE"

echo "PASS : $PASS_COUNT" | tee -a "$REPORT_FILE"
echo "WARN : $WARN_COUNT" | tee -a "$REPORT_FILE"
echo "FAIL : $FAIL_COUNT" | tee -a "$REPORT_FILE"

if [ "$FAIL_COUNT" -gt 0 ]; then

    OVERALL_STATUS="CRITICAL"

elif [ "$WARN_COUNT" -gt 0 ]; then

    OVERALL_STATUS="NEEDS ATTENTION"

else

    OVERALL_STATUS="SECURE"

fi

echo "STATUS: $OVERALL_STATUS" | tee -a "$REPORT_FILE"

echo "==========================================" | tee -a "$REPORT_FILE"

log_message "Security audit completed - STATUS: $OVERALL_STATUS"

exit 0