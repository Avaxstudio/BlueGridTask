pipeline {
    agent any

    environment {
        APP_IMAGE = 'gs-rest-service'
        APP_CONTAINER = 'test-app'
        HOST_PORT = '777'
        CONTAINER_PORT = '8080'
        HEALTH_URL = "http://localhost:${HOST_PORT}/greeting"
        DOCKER = "/usr/bin/docker"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "${DOCKER} build -t ${APP_IMAGE} ."
            }
        }

        stage('Run Container') {
            steps {
                sh "${DOCKER} run -d -p ${HOST_PORT}:${CONTAINER_PORT} --name ${APP_CONTAINER} ${APP_IMAGE}"
            }
        }

        stage('Health Check') {
            steps {
                sh '''
                    sleep 5
                    curl --fail ${HEALTH_URL}
                '''
            }
        }
    }

    post {
        always {
            sh "${DOCKER} rm -f ${APP_CONTAINER} || true"
        }
        success {
            echo "✅ Build and deployment successful!"
        }
        failure {
            echo "💥 Build failed — proveri Docker build, port binding ili health check."
        }
    }
}
