pipeline {
    agent any

    environment {
        IMAGE_NAME = "gs-rest-app"
        CONTAINER_NAME = "gs-rest-running"
        PORT_MAP = "777:8080"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build + Test') {
            steps {
                dir("complete") {
                    sh "mvn clean install -DskipTests=false"
                }
            }
        }

        stage('Docker Cleanup') {
            steps {
                sh "docker rm -f $CONTAINER_NAME || true"
            }
        }

        stage('Docker Build') {
            steps {
                sh "docker build -t $IMAGE_NAME ."
            }
        }

        stage('Run Container') {
            steps {
                sh "docker run -d -p $PORT_MAP --name $CONTAINER_NAME $IMAGE_NAME"
            }
        }

        stage('Health Check') {
            steps {
                sh """
                    sleep 5
                    curl --fail http://localhost:777/greeting || echo '❌ Endpoint unreachable'
                """
            }
        }

        // Optional Slack notification
        // stage('Slack Notify') {
        //     steps {
        //         slackSend(channel: '#gs-rest-service-ci', message: "Build ✅ done", color: 'good')
        //     }
        // }
    }

    post {
        failure {
            echo "💥 Build failed!"
            // Optional Slack: slackSend(...)
        }
    }
}

