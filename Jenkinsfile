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
                    sh '''
                    aws configure set region us-east-1
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 141752139587.dkr.ecr.us-east-1.amazonaws.com
                    docker tag myflaskapp:latest 141752139587.dkr.ecr.us-east-1.amazonaws.com/ecridanho:latest
                    docker push 141752139587.dkr.ecr.us-east-1.amazonaws.com/ecridanho:latest
                    '''
                }
            }
        }
        stage('Deploy deployment.yml') {
            steps {
                withAWS(credentials: 'cf171af7-c23f-4afe-be45-bba9e45a6c11', region: 'us-east-1') {
                    dir('k8s') {
                        sh 'kubectl apply -f deployment.yml'
                    }
                }
            }
        }
        stage('Deploy service.yml') {
            steps {
            withAWS(credentials: 'cf171af7-c23f-4afe-be45-bba9e45a6c11', region: 'us-east-1') {
                    dir('k8s'){
                        sh 'kubectl apply -f service.yml'
                    }
            }
            }
        }
        stage('Create output url') {
            steps {
                    dir('k8s'){
                        sh '''
                        output=$(kubectl get service myflaskapp-service -o jsonpath="{.status.loadBalancer.ingress[0].hostname}" | tr -d '[:space:]')
                        echo "Service URL: http://${output}"
                        '''
                    }   
                 }
        }
    }
}