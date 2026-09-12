# Automated User Management System

## 1. Project Overview

This project automates common Linux user and group management operations using Bash scripting.

The script supports creating, deleting, locking, unlocking, inspecting users, listing users, creating groups, and adding users to groups.

## 2. Objectives

* Automate Linux user management
* Automate group management
* Reduce repetitive administrative commands
* Implement validation and error handling
* Maintain operation logs

## 3. Technologies Used

* Linux
* Bash
* useradd
* userdel
* passwd
* usermod
* groupadd
* id
* getent

## 4. Configuration

```bash
DEFAULT_SHELL=/bin/bash
DEFAULT_GROUP=devops
```

## 5. Supported Operations

```text
create
delete
lock
unlock
info
list
group-create
group-add
```

## 6. Working Process

The script:

1. Checks whether the user has sufficient privileges.
2. Validates the requested operation.
3. Executes the required Linux user/group command.
4. Handles errors.
5. Records the operation in the log.

## 7. Testing

Testing included:

* Creating a test user
* Creating a group
* Adding a user to the group
* Locking a user
* Unlocking a user
* Displaying user information
* Listing users
* Deleting the test user
* Removing the test group

## 8. DevOps Skills Demonstrated

* Linux administration
* User management
* Group management
* Bash automation
* Privilege management
* Error handling
* Logging

## 9. Interview Explanation

I created a Bash-based Linux user management automation tool. It supports common operations such as user creation, deletion, locking, unlocking, information retrieval, and group management. I implemented privilege checks and logging so that administrative operations can be performed consistently and tracked.


