pipeline {

    agent none

    environment {
        // Using the DockerHub credential ID created by Jenkins
        DOCKERHUB_CREDENTIALS = credentials('b3b25228-666d-4167-b34a-2183c205a2b2')
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
                    # Copy kubeconfig to Jenkins (done once, or on every run)
                    echo "$KUBECONFIG_CONTENT" > /tmp/kubeconfig
                    export KUBECONFIG=/tmp/kubeconfig

                    # Verify connectivity
                    kubectl cluster-info
                    kubectl get nodes
                    echo "=== APPLYING KUBERNETES FILES ==="
                    kubectl apply -f deploy.yml
                    kubectl apply -f svc.yml
                '''
            }
        }
    }
}
