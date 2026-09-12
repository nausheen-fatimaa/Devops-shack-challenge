# 05 - Jenkins Shared Library

## 📌 Project Overview

A Jenkins Shared Library allows commonly used pipeline logic to be stored centrally and reused across multiple Jenkins projects.

Instead of writing the same Jenkins pipeline code repeatedly, reusable functions can be created.

## 🏗️ Architecture

```text
              Jenkins Shared Library
                       |
        +--------------+--------------+
        |              |              |
        v              v              v
   Project 1       Project 2      Project 3
```

## 📂 Project Structure

```text
05-Jenkins-Shared-Library/
├── vars/
│   ├── devopsPipeline.groovy
│   ├── dockerBuild.groovy
│   ├── securityScan.groovy
│   └── deployApp.groovy
├── Jenkinsfile
├── README.md
├── docs/
│   └── shared-library-guide.md
└── screenshots/
    ├── shared-library-config.png
    └── pipeline-success.png
```

## 📚 Shared Functions

Example functions:

```text
devopsPipeline()
dockerBuild()
securityScan()
deployApp()
```

## 🧩 Example Usage

A Jenkinsfile can load the shared library:

```groovy
@Library('devops-shared-library') _
```

Then call:

```groovy
devopsPipeline()
```

## ⚙️ Jenkins Configuration

Configure the shared library under:

```text
Manage Jenkins
   ↓
System
   ↓
Global Pipeline Libraries
```

Configure:

```text
Name: devops-shared-library
Default Version: main
SCM: Git
```

Then provide the Git repository containing the library.

## 🎯 Benefits

Shared Libraries provide:

* Code reuse
* Standardized pipelines
* Easier maintenance
* Less duplicated code
* Centralized CI/CD logic

## 🎯 Learning Outcomes

* Groovy
* Jenkins Shared Libraries
* Reusable pipeline functions
* Pipeline standardization
* Enterprise Jenkins architecture

## 🔮 Future Improvements

Create reusable functions for:

```text
Build
Test
SonarQube
Security Scan
Docker
Kubernetes
Deployment
Rollback
Notifications
```
