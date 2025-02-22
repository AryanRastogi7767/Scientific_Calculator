pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = 'scientific_calculator'
        GITHUB_REPO_URL = 'https://github.com/AryanRastogi7767/Scientific_Calculator.git'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Checkout the code from the GitHub repository
                    git branch: 'main', url: "${GITHUB_REPO_URL}"
                }
            }
        }
        stage('Run Unit Tests') {
            steps {
                sh 'python3 -m unittest discover -s . -p "test.py"'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker --version'  // Check if Docker works
                    sh 'ls -la'  // List files in the workspace
                    sh 'whoami'  // Check if Jenkins is the correct user
                    sh 'docker build -t ${DOCKER_IMAGE_NAME} .'
                }
            }
        }
        stage('Push Docker Image') {
    steps {
        script {
            sh 'docker login -u aryan7767 -p Docker@7767'
            sh 'docker tag scientific_calculator aryan7767/scientific-calculator:latest'
            sh 'docker push aryan7767/scientific-calculator:latest'
        }
    }
}

        stage('Push to Docker Hub') {
            steps {
                script{
                    docker.withRegistry('', 'DockerHubCred') {
                    sh 'docker tag scientific_calculator aryan7767/scientific-calculator:latest'
                    sh 'docker push aryan7767/scientific-calculator:latest'
                    }
                 }
            }
        }
        stage('Deploy using Ansible') {
            steps {
                sh 'ansible-playbook -i inventory deploy.yml'
            }
        }
    }
}
