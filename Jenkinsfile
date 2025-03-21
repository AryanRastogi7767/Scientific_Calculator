
pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = 'scientific_calculator'
        DOCKER_TAG = 'aryan7767/scientific-calculator:latest'
        GITHUB_REPO_URL = 'https://github.com/AryanRastogi7767/Scientific_Calculator.git'
        DOCKER_CREDENTIALS_ID = 'DockerHubCred'  // Ensure correct Jenkins credential ID
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    git branch: 'main', url: "${GITHUB_REPO_URL}"
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    python3 -m venv venv
                    source venv/bin/activate
                    python3 -m pip install --upgrade pip
                    python3 -m pip install -r requirements.txt
                '''
            }
        }


        stage('Run Unit Tests') {
            steps {
                sh '''
                    python3 -m venv venv
                    source venv/bin/activate
                    python3 -m pip install --upgrade pip
                    python3 -m pip install -r requirements.txt
                    pytest test.py --tb=short --disable-warnings
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker --version'  // Verify Docker installation
                    sh "docker build -t ${DOCKER_IMAGE_NAME} ."
                }
           }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: env.DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                    '''
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    sh "docker tag ${DOCKER_IMAGE_NAME} ${DOCKER_TAG}"
                    sh "docker push ${DOCKER_TAG}"
                }
            }
        }

        stage('Clean Up Docker Images') {
            steps {
                sh "docker rmi ${DOCKER_TAG} || true"  // Remove old images to free space
                sh "docker rmi ${DOCKER_IMAGE_NAME} || true"
            }
        }

        stage('Deploy using Ansible') {
            steps {
                sh 'ansible-playbook -i inventory deploy.yml'
            }
        }
    }
}
