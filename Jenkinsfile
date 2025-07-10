pipeline {
  agent any

  environment {
    PATH = "/usr/bin:/bin:/usr/local/bin"
    APP_IMAGE = 'gs-rest-app'
    APP_CONTAINER = 'gs-rest-running'
    HOST_PORT = '7777'
    CONTAINER_PORT = '8080'
  }

  stages {
    stage('Test Docker Access') {
      steps {
        sh 'which docker || echo "Docker not available in PATH"'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh "docker build -t ${APP_IMAGE} gs-rest-service/complete"
      }
    }

    stage('Run Container') {
      steps {
        sh "docker run -d -p ${HOST_PORT}:${CONTAINER_PORT} --name ${APP_CONTAINER} ${APP_IMAGE}"
      }
    }
  }

  post {
    always {
      sh "docker rm -f ${APP_CONTAINER} || true"
    }
    success {
      echo '✅ Build and run completed.'
    }
    failure {
      echo '❌ Build failed.'
    }
  }
}
