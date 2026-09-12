# Linux Server Hardening

## 1. Project Overview

This project automates and audits basic Linux server security configurations.

The project checks firewall configuration, SSH configuration, failed services, open ports, world-writable files, and other security-related settings.

## 2. Objectives

* Improve Linux server security
* Audit SSH configuration
* Check firewall status
* Identify open ports
* Detect failed services
* Identify potentially unsafe file permissions
* Generate security reports

## 3. Technologies Used

* Linux
* Bash
* UFW
* SSH
* systemctl
* ss
* find
* grep

## 4. Configuration

SSH settings and firewall ports are maintained in configuration files.

Example:

```bash
SSH_PORT=22
HTTP_PORT=80
HTTPS_PORT=443
```

## 5. Security Checks

The project checks:

* Root privileges
* UFW status
* SSH service
* Open ports
* Failed systemd services
* World-writable files
* SSH password authentication
* SSH root login configuration

## 6. Working Process

1. Load configuration.
2. Validate the environment.
3. Check firewall.
4. Check SSH service.
5. Check open ports.
6. Check failed services.
7. Check filesystem permissions.
8. Audit SSH settings.
9. Generate security report.
10. Write results to logs.

## 7. Testing

The security checker was executed and the generated report was reviewed for PASS, WARN, and FAIL results.

## 8. Important Safety Note

Server hardening changes should be tested carefully before applying them to production systems.

SSH and firewall changes should especially be tested in a lab environment before being applied to a remote production server.

## 9. DevOps Skills Demonstrated

* Linux security
* SSH administration
* Firewall management
* Security auditing
* Bash scripting
* System troubleshooting
* Server hardening

## 10. Interview Explanation

I created a Linux server hardening and security auditing project using Bash. It checks firewall status, SSH configuration, open ports, failed services, file permissions, and other security settings. The tool generates a security report so administrators can identify potential security issues before making configuration changes.



