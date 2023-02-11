pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker build -t myflaskapp .'
            }
        }
        stage('Push to ECR') {
            steps {
                withAWS(credentials: 'c5c12a95-f7c1-4e0a-99e5-f930528187c3', region: 'us-east-1') {
                    sh 'aws configure set region us-east-1'
                    sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 141752139587.dkr.ecr.us-east-1.amazonaws.com'
                    sh 'docker tag myflaskapp:latest 141752139587.dkr.ecr.us-east-1.amazonaws.com/ecridanho:latest'
                    sh 'docker push 141752139587.dkr.ecr.us-east-1.amazonaws.com/ecridanho:latest'
                }
            }
        }
        stage('Deploy to EKS') {
            steps {
            withAWS(credentials: 'c5c12a95-f7c1-4e0a-99e5-f930528187c3', region: 'us-east-1') {
                    sh 'kubectl apply -f deployment.yml'
                    sh 'kubectl apply -f service.yml'
                }
            }
        }
    }
}
