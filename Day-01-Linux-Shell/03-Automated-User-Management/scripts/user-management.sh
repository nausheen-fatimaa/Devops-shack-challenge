#!/bin/bash

# ==========================================
# Automated User Management System
# ==========================================

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

CONFIG_FILE="$BASE_DIR/config/users.conf"
LOG_FILE="$BASE_DIR/logs/user-management.log"
REPORT_FILE="$BASE_DIR/reports/user-report.txt"

# ------------------------------------------
# Root Privilege Check
# ------------------------------------------

if [ "$EUID" -ne 0 ]; then
    echo "ERROR: This script must be run with sudo/root privileges."
    echo "Usage: sudo $0 <command> <username>"
    exit 1
fi

# ------------------------------------------
# Load Configuration
# ------------------------------------------

if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "ERROR: Configuration file not found."
    exit 1
fi

# ------------------------------------------
# Logging Function
# ------------------------------------------

log_message() {

    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    echo "[$TIMESTAMP] $1" >> "$LOG_FILE"
}

# ------------------------------------------
# Usage Function
# ------------------------------------------

usage() {

    echo
    echo "=========================================="
    echo "     AUTOMATED USER MANAGEMENT"
    echo "=========================================="
    echo
    echo "Usage:"
    echo
    echo "sudo $0 create <username>"
    echo "sudo $0 delete <username>"
    echo "sudo $0 lock <username>"
    echo "sudo $0 unlock <username>"
    echo "sudo $0 info <username>"
    echo "sudo $0 list"
    echo "sudo $0 group-create <groupname>"
    echo "sudo $0 group-add <username> <groupname>"
    echo
}

# ------------------------------------------
# Check Username
# ------------------------------------------

check_username() {

    if id "$1" &>/dev/null; then
        return 0
    else
        return 1
    fi
}

# ------------------------------------------
# Create User
# ------------------------------------------

create_user() {

    USERNAME="$1"

    if [ -z "$USERNAME" ]; then
        echo "ERROR: Username is required."
        exit 1
    fi

    if check_username "$USERNAME"; then

        echo "ERROR: User '$USERNAME' already exists."

        log_message "CREATE FAILED - User $USERNAME already exists"

        exit 1
    fi

    useradd -m -s "$DEFAULT_SHELL" "$USERNAME"

    if [ $? -eq 0 ]; then

        echo
        echo "User '$USERNAME' created successfully."

        echo
        echo "Set password using:"
        echo "sudo passwd $USERNAME"

        log_message "USER CREATED - $USERNAME"

    else

        echo "ERROR: Failed to create user."

        log_message "CREATE FAILED - $USERNAME"

        exit 1
    fi
}

# ------------------------------------------
# Delete User
# ------------------------------------------

delete_user() {

    USERNAME="$1"

    if ! check_username "$USERNAME"; then

        echo "ERROR: User '$USERNAME' does not exist."

        log_message "DELETE FAILED - $USERNAME does not exist"

        exit 1
    fi

    userdel -r "$USERNAME"

    if [ $? -eq 0 ]; then

        echo "User '$USERNAME' deleted successfully."

        log_message "USER DELETED - $USERNAME"

    else

        echo "ERROR: Failed to delete user."

        log_message "DELETE FAILED - $USERNAME"

        exit 1
    fi
}

# ------------------------------------------
# Lock User
# ------------------------------------------

lock_user() {

    USERNAME="$1"

    if ! check_username "$USERNAME"; then

        echo "ERROR: User '$USERNAME' does not exist."
        exit 1
    fi

    usermod -L "$USERNAME"

    echo "User '$USERNAME' locked successfully."

    log_message "USER LOCKED - $USERNAME"
}

# ------------------------------------------
# Unlock User
# ------------------------------------------

unlock_user() {

    USERNAME="$1"

    if ! check_username "$USERNAME"; then

        echo "ERROR: User '$USERNAME' does not exist."
        exit 1
    fi

    usermod -U "$USERNAME"

    echo "User '$USERNAME' unlocked successfully."

    log_message "USER UNLOCKED - $USERNAME"
}

# ------------------------------------------
# User Information
# ------------------------------------------

user_info() {

    USERNAME="$1"

    if ! check_username "$USERNAME"; then

        echo "ERROR: User '$USERNAME' does not exist."
        exit 1
    fi

    echo
    echo "=========================================="
    echo "          USER INFORMATION"
    echo "=========================================="

    echo "Username      : $USERNAME"
    echo "User ID       : $(id -u "$USERNAME")"
    echo "Group ID      : $(id -g "$USERNAME")"
    echo "Groups        : $(id -Gn "$USERNAME")"
    echo "Home Directory: $(getent passwd "$USERNAME" | cut -d: -f6)"
    echo "Shell         : $(getent passwd "$USERNAME" | cut -d: -f7)"

    echo
}

# ------------------------------------------
# List Users
# ------------------------------------------

list_users() {

    echo
    echo "=========================================="
    echo "              SYSTEM USERS"
    echo "=========================================="

    awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd

    echo
}

# ------------------------------------------
# Create Group
# ------------------------------------------

create_group() {

    GROUPNAME="$1"

    if [ -z "$GROUPNAME" ]; then

        echo "ERROR: Group name required."
        exit 1
    fi

    if getent group "$GROUPNAME" >/dev/null; then

        echo "ERROR: Group '$GROUPNAME' already exists."

        log_message "GROUP CREATE FAILED - $GROUPNAME exists"

        exit 1
    fi

    groupadd "$GROUPNAME"

    if [ $? -eq 0 ]; then

        echo "Group '$GROUPNAME' created successfully."

        log_message "GROUP CREATED - $GROUPNAME"

    else

        echo "ERROR: Failed to create group."

        log_message "GROUP CREATE FAILED - $GROUPNAME"

        exit 1
    fi
}

# ------------------------------------------
# Add User to Group
# ------------------------------------------

add_to_group() {

    USERNAME="$1"
    GROUPNAME="$2"

    if ! check_username "$USERNAME"; then

        echo "ERROR: User '$USERNAME' does not exist."
        exit 1
    fi

    if ! getent group "$GROUPNAME" >/dev/null; then

        echo "ERROR: Group '$GROUPNAME' does not exist."
        exit 1
    fi

    usermod -aG "$GROUPNAME" "$USERNAME"

    if [ $? -eq 0 ]; then

        echo "User '$USERNAME' added to group '$GROUPNAME'."

        log_message "GROUP MEMBERSHIP - $USERNAME added to $GROUPNAME"

    else

        echo "ERROR: Failed to add user to group."

        exit 1
    fi
}

# ------------------------------------------
# Main Program
# ------------------------------------------

COMMAND="$1"

case "$COMMAND" in

    create)
        create_user "$2"
        ;;

    delete)
        delete_user "$2"
        ;;

    lock)
        lock_user "$2"
        ;;

    unlock)
        unlock_user "$2"
        ;;

    info)
        user_info "$2"
        ;;

    list)
        list_users
        ;;

    group-create)
        create_group "$2"
        ;;

    group-add)
        add_to_group "$2" "$3"
        ;;

    *)
        usage
        exit 1
        ;;

esac

exit 0