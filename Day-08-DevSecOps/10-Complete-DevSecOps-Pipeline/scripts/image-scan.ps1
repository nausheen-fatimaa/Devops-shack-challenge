docker build -t day8-devsecops-app:1.0 application
trivy image --severity HIGH,CRITICAL day8-devsecops-app:1.0
