pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "user1378/cw2-devops:latest"
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'git@github.com:mind001/cw2-devops.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }
        stage('Test Docker Image') {
            steps {
                sh 'docker run -d --name test-container -p 8081:8081 $DOCKER_IMAGE'
                sh 'docker ps -a'
                sh 'docker rm -f test-container'
            }
        }
        stage('Push to DockerHub') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push $DOCKER_IMAGE'
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl set image deployment/cw2-app-deployment cw2-app=$DOCKER_IMAGE'
                sh 'kubectl rollout status deployment/cw2-app-deployment'
            }
        }
    }
}
