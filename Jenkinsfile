pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        dir('gs-rest-service/complete') {
          sh '/usr/bin/mvn clean package -DskipTests'
        }
      }
    }

    stage('Deploy') {
      steps {
        echo '🚀 Deploy stub...'
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
