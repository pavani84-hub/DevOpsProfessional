pipeline{
    agent none
    environment {
        DOCKERHUB_CREDENTIALS=credentials('b3b25228-666d-4167-b34a-2183c205a2b2')
    }
    
   
        stage('git'){
            agent{ 
                label 'kmaster'
            }

            steps{

                git'https://github.com/pavani84-hub/DevOpsProfessional.git'
            }
        }
        stage('docker') {
            agent { 
                label 'kmaster'
            }

            steps {

                sh 'sudo docker build /home/ubuntu/jenkins/workspace/DevOpsPro -t devopspro/image'
                sh 'sudo echo $DOCKERHUB_CREDENTIALS_PSW | sudo docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'sudo docker push devopspro/image'

            }
        }
        stage('Kubernetes') {
            agent { 
                label 'kmaster'
            }

            steps {

                sh 'kubectl create -f deploy.yml'
                sh 'kubectl create -f svc.yml'
            }
        }        
        
    }
}
