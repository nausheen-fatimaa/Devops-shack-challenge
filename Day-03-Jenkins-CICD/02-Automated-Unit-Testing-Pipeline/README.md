# 02 - Automated Unit Testing Pipeline

## 📌 Project Overview

This project demonstrates automated unit testing using Jenkins, Maven and JUnit.

Whenever code is pushed to GitHub, Jenkins builds the application and automatically executes the unit tests.

## 🛠️ Technologies Used

* Git
* GitHub
* Jenkins
* Java
* Maven
* JUnit

## 🏗️ Pipeline Architecture

```text
Developer
    |
    v
  GitHub
    |
    v
 Jenkins
    |
    +----> Checkout
    |
    +----> Build
    |
    +----> Unit Tests
    |
    +----> JUnit Report
    |
    v
 Build Result
```

## 📂 Project Structure

```text
02-Automated-Unit-Testing-Pipeline/
├── Jenkinsfile
├── README.md
├── docs/
│   └── testing-documentation.md
├── reports/
│   └── .gitkeep
└── screenshots/
    ├── test-success.png
    ├── test-failure.png
    └── junit-report.png
```

## 🔄 Pipeline Stages

### 1. Checkout

Jenkins downloads the application source code.

### 2. Build

Maven compiles the application.

### 3. Unit Testing

Jenkins executes:

```bash
mvn test
```

### 4. Test Reporting

Jenkins publishes JUnit test results.

## 🧪 Test Example

The project contains unit tests under:

```text
src/test/java/
```

Example:

```text
AppTest.java
```

## ❌ Failure Testing

You can intentionally modify a test so that it fails.

Jenkins should report:

```text
BUILD FAILURE
```

After correcting the test:

```text
BUILD SUCCESS
```

## 🚀 Jenkins Setup

Create a Pipeline job and connect it to your GitHub repository.

Use:

```text
Pipeline script from SCM
```

Set:

```text
Branch: main
Script Path: Jenkinsfile
```

## ▶️ Run

Click:

```text
Build Now
```

Then open:

```text
Console Output
```

to view the test execution.

## ✅ Expected Result

```text
Checkout       SUCCESS
Build          SUCCESS
Unit Tests     SUCCESS
JUnit Report   SUCCESS
------------------------
Pipeline       SUCCESS
```

## 🎯 Learning Outcomes

* Automated testing
* JUnit
* Maven test lifecycle
* Jenkins test reporting
* CI failure handling
* Test-driven CI concepts

## 🔮 Future Improvements

* Code coverage
* SonarQube
* Security scanning
* Docker image creation
* Deployment pipeline
