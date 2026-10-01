$ErrorActionPreference = "Stop"
docker build -t devsecops-container-demo:1.0 .
trivy image --severity HIGH,CRITICAL --exit-code 1 devsecops-container-demo:1.0
