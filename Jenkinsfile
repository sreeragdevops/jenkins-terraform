pipeline {
    agent any
    parameters {
        string(name: 'DOCKER_IMAGE_NAME', defaultValue: 'cat-image', description: 'Name of the Docker image')
    }
    
     stages {
        stage('Code checkout from Git') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/main']],
                    extensions: [],
                    userRemoteConfigs: [[
                        credentialsId: 'jenkins-git-integration',
                        url: 'https://github.com/sreeragdevops/jenkins-terraform.git'
                    ]]
                ])
            }
        }


        stage('Build Docker Image') {
            steps {
                script {
                    sh " docker build -t ${params.DOCKER_IMAGE_NAME}:latest -f Dockerfile ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    // Assuming 'jenkin-dockerhub' is the ID of your Docker Hub credentials
                    withCredentials([usernamePassword(credentialsId: 'Docker-hub-first-credentials', passwordVariable: 'pwd', usernameVariable: 'user')]) {
                        // Log in to Docker Hub using provided credentials
                        sh "echo '${pwd}' | docker login -u ${user} --password-stdin"
                        
                        // Tag and push the built Docker image to Docker Hub
                        sh "docker tag ${params.DOCKER_IMAGE_NAME}:latest ${user}/${params.DOCKER_IMAGE_NAME}:latest"
                        sh "docker push ${user}/${params.DOCKER_IMAGE_NAME}:latest"
                    }
                }
            }
          stage('EKS Connection Test') {
            steps {
                script {
                    // Ensure the withKubeConfig step is correctly set
                    withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'k8-cluster', namespace: '', restrictKubeConfigAccess: false, serverUrl: ''){
                        sh 'kubectl get nodes'
                        sh 'kubectl apply -f deployment.yaml'
                        sh 'kubectl apply -f service.yaml'
                        sh 'kubectl get svc cat-app-svc -o wide'
                    }
                }
            }
        }
    }
}
        }
    }
}
