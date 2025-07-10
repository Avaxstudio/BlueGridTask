pipeline {
  agent {
    docker {
      image 'maven:3.9.4'
    }
  }

  stages {
    stage('Build') {
      steps {
        dir('gs-rest-service/complete') {
          sh 'mvn clean package -DskipTests'
        }
      }
    }

    stage('Deploy') {
      steps {
        echo '🚀 Deploy stage stub — spreman za EC2 ili Render kada poželiš!'
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

