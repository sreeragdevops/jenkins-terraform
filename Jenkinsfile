pipeline {
    agent any
    parameters {
        choice(name: 'TERRAFORM_ACTION', choices: ['apply', 'destroy', 'plan'], description: 'Select Terraform action to perform')
        string(name: 'USER_NAME', defaultValue: 'Sreerag', description: 'Specify who is running the code')
    }


    
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-jenkins-integration')
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
                        url: 'https://github.com/sreeragdevops/jenkins-terraform'
                    ]]
                ])
            }
        }

        stage('terraform init') {
            steps {
                script {
                    sh "terraform init"
                }
            }
        }
        stage('terraform apply') {
            steps {
                script {
                    sh "terraform apply --auto-approve"
                }
            }
        }
    }
}
