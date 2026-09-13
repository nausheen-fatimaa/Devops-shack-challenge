# 01 - Basic Application CI Pipeline

## 📌 Project Overview

This project demonstrates a basic Continuous Integration (CI) pipeline using Jenkins.

The pipeline automatically:

* Pulls source code from GitHub
* Builds the Java application
* Packages the application using Maven
* Reports whether the build was successful or failed

## 🛠️ Technologies Used

* Git
* GitHub
* Jenkins
* Java
* Maven
* JUnit

## 🏗️ Architecture

```text
Developer
    |
    v
  GitHub
    |
    v
 Jenkins
    |
    +----> Checkout Source Code
    |
    +----> Maven Build
    |
    +----> Package Application
    |
    v
 Build Result
```

## 📂 Project Structure

```text
01-Basic-Application-CI-Pipeline/
├── src/
│   ├── main/
│   │   └── java/
│   └── test/
│       └── java/
├── Jenkinsfile
├── pom.xml
├── README.md
├── docs/
│   └── pipeline-documentation.md
├── screenshots/
│   ├── jenkins-dashboard.png
│   ├── successful-build.png
│   └── pipeline-stages.png
└── logs/
    └── build-log.txt
```

## 🔄 Pipeline Stages

### Stage 1 - Checkout

Jenkins retrieves the source code from GitHub.

### Stage 2 - Build

Maven compiles the Java application.

```bash
mvn clean package
```

### Stage 3 - Package

The application is packaged into its distributable artifact.

## 🚀 Jenkins Configuration

Create a Jenkins Pipeline job.

Select:

```text
Pipeline
    ↓
Pipeline script from SCM
    ↓
Git
    ↓
GitHub Repository URL
    ↓
Branch: main
    ↓
Script Path: Jenkinsfile
```

## ▶️ Run the Pipeline

Click:

```text
Build Now
```

Jenkins will execute all pipeline stages.

## ✅ Expected Result

A successful pipeline should show:

```text
Checkout       SUCCESS
Build          SUCCESS
Package        SUCCESS
------------------------
Pipeline       SUCCESS
```

## 🎯 Learning Outcomes

After completing this project, you will understand:

* Jenkins basics
* Jenkins Pipeline
* Jenkinsfile
* GitHub integration
* Maven builds
* CI concepts
* Pipeline stages

## 🔮 Future Improvements

* Add automated testing
* Add SonarQube
* Add Docker image creation
* Add security scanning
* Add Kubernetes deployment
