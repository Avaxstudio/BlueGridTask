pipeline {
  agent any

  environment {
    APP_IMAGE = 'gs-rest-app'
    APP_CONTAINER = 'gs-rest-running'
    HOST_PORT = '7777'
    CONTAINER_PORT = '8080'
    PATH = "/usr/bin:/bin:/usr/local/bin"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build Docker Image') {
      steps {
        sh "sudo docker build -t ${APP_IMAGE} gs-rest-service/complete"
      }
    }

    stage('Run Container') {
      steps {
        sh "sudo docker run -d -p ${HOST_PORT}:${CONTAINER_PORT} --name ${APP_CONTAINER} ${APP_IMAGE}"
      }
    }
  }

  post {
    always {
      sh "sudo docker rm -f ${APP_CONTAINER} || true"
    }

    success {
      echo '✅ Build and run completed.'
    }

    failure {
      echo '❌ Build failed.'
    }
  }
}
