# Log Analysis & Error Detection Tool

## 1. Project Overview

This project analyzes application logs using Bash scripting and identifies errors, warnings, failures, and HTTP error responses.

The tool generates a structured report containing log statistics and detected problems.

## 2. Objectives

* Automate log analysis
* Detect errors
* Detect warnings
* Identify HTTP 4xx and 5xx responses
* Count log severity levels
* Generate reports
* Maintain analyzer logs

## 3. Technologies Used

* Linux
* Bash
* grep
* awk
* sed
* sort
* uniq

## 4. Configuration

```bash
ERROR_PATTERN="ERROR|CRITICAL|FAILED|FAILURE"
WARNING_PATTERN="WARNING|WARN"
```

## 5. Working Process

1. Read the application log.
2. Count total log entries.
3. Detect errors.
4. Detect warnings.
5. Detect informational messages.
6. Search for HTTP 4xx responses.
7. Search for HTTP 5xx responses.
8. Identify frequent errors.
9. Determine severity.
10. Generate a report.

## 6. Testing

Testing included:

* Normal application logs
* Added ERROR entries
* Added HTTP 503 errors
* Verified generated reports
* Tested missing log file handling

## 7. DevOps Skills Demonstrated

* Log analysis
* Troubleshooting
* Bash scripting
* Error detection
* Pattern matching
* Incident investigation
* Automation

## 8. Interview Explanation

I created a Bash-based log analysis tool that automatically analyzes application logs and identifies errors, warnings, failures, and HTTP 4xx/5xx responses. It also counts occurrences and identifies frequently occurring errors. The project demonstrates how shell scripting can automate basic log monitoring and troubleshooting.


