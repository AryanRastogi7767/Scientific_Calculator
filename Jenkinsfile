
pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/your-repo/scientific-calculator.git'
            }
        }
        
        stage('Build & Test') {
            steps {
                sh 'python -m unittest discover tests'
            }
        }
        
        stage('Docker Build & Push') {
            steps {
                sh 'docker build -t your-dockerhub/scientific-calculator .'
                sh 'docker login -u your-username -p your-password'
                sh 'docker push your-dockerhub/scientific-calculator'
            }
        }

        stage('Deploy using Ansible') {
            steps {
                sh 'ansible-playbook deploy.yml'
            }
        }
    }
}
