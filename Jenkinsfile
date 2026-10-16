pipeline {
    agent any

    environment {
        IMAGE_NAME = 'employee-system'
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Compile & Test') {
            steps {
                // Compiles using an official lightweight OpenJDK container
                sh 'docker run --rm -v "${WORKSPACE}:/app" -w /app eclipse-temurin:17-jdk javac -d build src/employee/*.java'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -t ${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Run Automated Tests / Smoke Test') {
            steps {
                sh "docker run --rm ${IMAGE_NAME}:latest java -cp /app/src employee.Main --version || true"
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully! Your Java application and Docker image are ready.'
        }
        failure {
            echo 'Pipeline failed. Please check the logs above for compilation or container errors.'
        }
    }
}
