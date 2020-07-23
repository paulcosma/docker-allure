pipeline {
  agent { label 'master' }
  environment {
    GIT_TAG = gitTagName()
    IMAGE_TAG = "${GIT_TAG}"
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '3'))
  }
  stages {
    stage('Build image') {
      steps {
        sh "docker image build -f Dockerfile -t paulcosma/docker-allure:${IMAGE_TAG} ."
      }
    }
    stage('Tag image as latest') {
      steps {
        sh "docker image tag paulcosma/docker-allure:${IMAGE_TAG} paulcosma/docker-allure:latest"
      }
    }
    stage('Push image') {
      steps {
        withDockerRegistry([ credentialsId: "e80fc77a-7fce-4fbd-98ee-c7aa4d5a6952", url: "" ]) {
          sh "docker image push paulcosma/docker-allure:${IMAGE_TAG}"
          sh "docker image push paulcosma/docker-allure:latest"
        }
      }
    }
  }
}

String gitTagName() {
  commit = getLatestTaggedCommit()
  sh "echo Debug: commit = $commit"
  if (commit) {
    desc = sh(script: "git describe --tags ${commit}", returnStdout: true)?.trim()
    sh "echo Debug: Tag = $desc"
  }
  return desc
}

String getLatestTaggedCommit() {
  return sh(script: 'git rev-list --tags --max-count=1', returnStdout: true)?.trim()
}