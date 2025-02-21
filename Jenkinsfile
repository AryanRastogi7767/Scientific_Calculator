pipeline {
    agent any
    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/AryanRastogi7767/Scientific_Calculator.git'
            }
        }
        stage('Run Unit Tests') {
            steps {
                sh 'python3 -m unittest discover -s . -p "test.py"'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t scientific-calculator .'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'docker-hub-password', variable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u your-docker-username --password-stdin'
                }
                sh 'docker tag scientific-calculator your-docker-username/scientific-calculator:latest'
                sh 'docker push your-docker-username/scientific-calculator:latest'
            }
        }
        stage('Deploy using Ansible') {
            steps {
                sh 'ansible-playbook -i inventory deploy.yml'
            }
        }
    }
}
