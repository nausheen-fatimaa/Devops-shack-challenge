# Project 2 — Highly Available Web Application

## Architecture

```text
                    Internet
                       |
                      ALB
                 /           \
             Public-A       Public-B
                 |             |
             App-A           App-B
          Private-A       Private-B
                 \             /
                  Application
```

The ALB spans two Availability Zones. Each application instance is placed in a different AZ.

## Availability test

Stop or terminate one application instance and verify that the ALB continues serving traffic from the remaining healthy target.
