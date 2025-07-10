pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'gs-rest-app'
        CONTAINER_NAME = 'gs-rest-running'
        APP_PORT = '777'
        GREETING_ENDPOINT = "http://16.16.217.54:${APP_PORT}/greeting"
        // SLACK_WEBHOOK = credentials('slack-url') // ako koristiš Slack notifikacije
    }

    stages {
        stage('Build + Test') {
            steps {
                withEnv(["PATH+MAVEN=${tool 'M3'}/bin"]) {
                    dir('complete') {
                        sh 'mvn clean install -DskipTests=false'
                    }
                }
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
                    echo "🩺 Waiting for app to boot..."
                    sleep 5
                    curl --fail ${GREETING_ENDPOINT}
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Build + Docker deploy prošli su bez greške!"
            // sh 'curl -X POST -H "Content-Type: application/json" --data \'{"text":"✅ Jenkins build passed!"}\' $SLACK_WEBHOOK'
        }
        failure {
            echo "💥 Build se srušio. Proveri mvn, docker, health check."
            // sh 'curl -X POST -H "Content-Type: application/json" --data \'{"text":"💥 Jenkins build failed!"}\' $SLACK_WEBHOOK'
        }
    }
}
