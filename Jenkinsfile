pipeline {
  agent any

  environment {
    APP_IMAGE = 'gs-rest-app'
    APP_CONTAINER = 'gs-rest-running'
    HOST_PORT = '7777'
    CONTAINER_PORT = '8080'
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build Docker Image') {
      steps {
        echo '🐳 Building Docker image...'
        sh "docker build -t ${APP_IMAGE} gs-rest-service/complete"
      }
    }

    stage('Run Container') {
      steps {
        echo '🚀 Running container...'
        sh "docker run -d -p ${HOST_PORT}:${CONTAINER_PORT} --name ${APP_CONTAINER} ${APP_IMAGE}"
      }
    }
  }

  post {
    always {
      echo '🧹 Cleaning up container...'
      sh "docker rm -f ${APP_CONTAINER} || true"
    }

    success {
      echo '✅ Docker build and run completed successfully!'
    }

    failure {
      echo '❌ Build failed — check logs and Docker setup.'
    }
  }
}
