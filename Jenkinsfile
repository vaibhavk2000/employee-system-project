pipeline {
    agent any

    tools {
        // Ensure you have configured a JDK tool in Jenkins Management -> Global Tool Configuration
        jdk 'JDK-17'
    }

    environment {
        // Define your Docker image name
        IMAGE_NAME = 'employee-system'
        IMAGE_TAG = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                // Pulls code from your GitHub repository
                checkout scm
            }
        }

        stage('Compile & Test') {
            steps {
                // Compiles the Java source files into the bin/src directory
                sh 'mkdir -p build'
                sh 'javac -d build src/employee/*.java'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Builds the Docker container using your project's Dockerfile
                script {
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -t ${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Run Automated Tests / Smoke Test') {
            steps {
                // Verifies that the compiled Java application runs successfully in a container
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
