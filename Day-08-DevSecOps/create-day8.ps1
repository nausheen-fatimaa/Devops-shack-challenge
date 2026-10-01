$projects = @(
"01-Git-Secret-Scanning",
"02-SAST-Pipeline",
"03-Software-Composition-Analysis",
"04-Container-Image-Security",
"05-IaC-Security-Scanning",
"06-Kubernetes-Runtime-Security",
"07-DAST-Automation",
"08-HashiCorp-Vault-Integration",
"09-Kubernetes-Admission-Security",
"10-Complete-DevSecOps-Pipeline"
)

foreach ($project in $projects) {
    New-Item -ItemType Directory -Force -Path "$project/config","$project/docs","$project/logs","$project/reports","$project/screenshots","$project/scripts","$project/tests" | Out-Null
}
Write-Host "Day 8 structure created."
