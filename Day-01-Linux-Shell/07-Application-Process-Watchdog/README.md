# Application Process Watchdog

## 1. Project Overview

The Application Process Watchdog is a Bash automation tool that continuously monitors an application process and automatically restarts it when the process stops.

## 2. Objectives

* Monitor application processes
* Detect stopped processes
* Automatically restart applications
* Maintain restart limits
* Generate logs
* Track watchdog activity

## 3. Technologies Used

* Linux
* Bash
* pgrep
* ps
* nohup
* sleep

## 4. Configuration

```bash
PROCESS_NAME="test-app.sh"
PROCESS_COMMAND="$BASE_DIR/scripts/test-app.sh"
CHECK_INTERVAL=5
MAX_RESTARTS=3
```

## 5. Working Process

1. Start the application.
2. Watchdog checks the process.
3. If the process is running, continue monitoring.
4. If the process stops, watchdog detects the failure.
5. Watchdog starts the application again.
6. Restart activity is logged.
7. Restart attempts are limited according to configuration.

## 6. Testing

The application process was intentionally stopped during testing.

The watchdog detected the stopped process and automatically restarted it.

## 7. DevOps Skills Demonstrated

* Process monitoring
* Linux administration
* Bash scripting
* Application availability
* Automatic recovery
* Logging
* Fault handling

## 8. Interview Explanation

I developed a Linux application watchdog using Bash that continuously monitors a process. If the application stops unexpectedly, the watchdog detects the failure and automatically restarts it. I also implemented a maximum restart limit and logging to prevent uncontrolled restart loops.


