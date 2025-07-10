pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        dir('gs-rest-service/complete') {
          sh 'mvn clean package -DskipTests'
        }
      }
    }
  }

  post {
    success {
      echo '✅ Build finished successfully!'
    }
    failure {
      echo '❌ Build failed!'
    }
  }
}
