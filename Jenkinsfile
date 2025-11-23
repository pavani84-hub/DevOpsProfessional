pipeline {

    agent none

    environment {
        // Using the DockerHub credential ID created by Jenkins
        DOCKERHUB_CREDENTIALS = credentials('docker-cred')
    }

    stages {

        stage('Checkout Code') {
            steps {
                git 'https://github.com/pavani84-hub/DevOpsProfessional.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    echo "=== BUILDING DOCKER IMAGE ==="
                    docker build -t pavaniambica/devopspro:latest .
                '''
            }
        }

        stage('Login to DockerHub') {
            steps {
                sh '''
                    echo "=== LOGGING INTO DOCKER HUB ==="
                    echo "$DOCKERHUB_CREDENTIALS_PSW" | docker login -u "$DOCKERHUB_CREDENTIALS_USR" --password-stdin
                '''
            }
        }

        stage('Push Docker Image') {
            steps {
                sh '''
                    echo "=== PUSHING IMAGE TO DOCKER HUB ==="
                    docker push pavaniambica/devopspro:latest
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
    sh "kubectl --kubeconfig=$KUBECONFIG apply -f deploy.yml"
}

                   

                    # Verify connectivity
                    kubectl cluster-info
                    kubectl get nodes
                    echo "=== APPLYING KUBERNETES FILES ==="
                   


                    kubectl apply -f svc.yml
                '''
            }
        }
    }
}
