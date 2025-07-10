pipeline {
    agent {
        docker {
            image 'maven:3.9.6-eclipse-temurin-17'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        DOCKER_IMAGE = 'gs-rest-app'
        CONTAINER_NAME = 'gs-rest-running'
        APP_PORT = '777'
        GREETING_ENDPOINT = "http://16.16.217.54:${APP_PORT}/greeting"
    }

    stages {
        stage('Docker Check') {
            steps {
                sh 'docker version'
            }
        }

        stage('Docker Cleanup') {
            steps {
                sh '''
                    docker rm -f ${CONTAINER_NAME} || true
                    docker rmi ${DOCKER_IMAGE} || true
                '''
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }

        stage('Run Container') {
            steps {
                sh 'docker run -d -p ${APP_PORT}:8080 --name ${CONTAINER_NAME} ${DOCKER_IMAGE}'
            }
        }

        stage('Health Check') {
            steps {
                sh '''
                    sleep 5
                    curl --fail ${GREETING_ENDPOINT}
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Build and deployment successful!"
        }
        failure {
            echo "💥 Build failed — proveri Docker CLI, imidž ili port."
        }
    }
}
