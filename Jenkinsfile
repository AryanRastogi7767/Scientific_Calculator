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
        // stage('Build Docker Image') {
        //     steps {
        //         script {
        //             // Build Docker image
        //             docker.build("${DOCKER_IMAGE_NAME}", '.')
        //         }
        //     }
        // }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker --version'  // Check if Docker works
                    sh 'ls -la'  // List files in the workspace
                    sh 'whoami'  // Check if Jenkins is the correct user
                    docker.build("scientific-calculator", '.')
                }
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
