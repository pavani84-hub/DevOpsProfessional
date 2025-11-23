pipeline {
    agent none

    environment {
        DOCKERHUB_CREDENTIALS = credentials('b3b25228-666d-4167-b34a-2183c205a2b2')
    }

    stages {

        stage('Git Checkout') {
            agent { label 'kmaster' }

            steps {
                git 'https://github.com/pavani84-hub/DevOpsProfessional.git'
            }
        }

        stage('Docker Build & Push') {
            agent { label 'kmaster' }

            steps {
                sh '''
                    docker build -t devopspro/image .
                    echo "$DOCKERHUB_CREDENTIALS_PSW" | docker login -u "$DOCKERHUB_CREDENTIALS_USR" --password-stdin
                    docker push devopspro/image
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            agent { label 'kmaster' }

            steps {
                sh '''
                    kubectl apply -f deploy.yml
                    kubectl apply -f svc.yml
                '''
            }
        }
    }
}
