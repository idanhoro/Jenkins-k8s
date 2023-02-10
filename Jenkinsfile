pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t hello-world-app .'
            }
        }
        stage('Push to ECR') {
            steps {
                withAWS(credentials: 'c5c12a95-f7c1-4e0a-99e5-f930528187c3', region: 'us-east-1') {
                    sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin c5c12a95-f7c1-4e0a-99e5-f930528187c3.dkr.ecr.us-east-1.amazonaws.com/ecridanho'
                    sh 'docker push hello-world-app'
                }
            }
        }
    }
}
