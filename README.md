# Allure commandline
Light container with Allure commandline.

## Usage on Kubernetes in a Jenkins pipeline
```groovy
#!groovy

podTemplate(cloud: '...',
    name: ...,
    namespace: '...',
    yaml: """
apiVersion: v1
kind: Pod
spec:
  serviceAccount: jenkins
  containers:
  - name: maven
    image: maven:3.6.3-jdk-8-slim
    command: ['cat']
    tty: true
  ... 
  - name: allure
    image: paulcosma/docker-allure:3.1.5
    command: ['cat']
    tty: true
"""
) {
  node(...) {
    timestamps {
          stage('Run Tests') {
            ...
          }

          stage ('Generate Reports') {
            container('allure') {
              sh "allure generate -c target/allure-results -o results/allure-report"
            }
          }

          stage('Publish Results') {
            archiveArtifacts allowEmptyArchive: false, artifacts: 'results/allure-report/,target/allure-results/'
            publishHTML([allowMissing: true, alwaysLinkToLastBuild: true, keepAll: true, reportDir: 'results/allure-report', reportFiles: 'index.html', reportName: 'Report Allure', reportTitles: ''])
          }
    }
  }
}
```

