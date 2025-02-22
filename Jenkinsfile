// pipeline {
//     agent any
//     environment {
//         DOCKER_IMAGE_NAME = 'scientific_calculator'
//         GITHUB_REPO_URL = 'https://github.com/AryanRastogi7767/Scientific_Calculator.git'
//     }

//     stages {
//         stage('Checkout') {
//             steps {
//                 script {
//                     // Checkout the code from the GitHub repository
//                     git branch: 'main', url: "${GITHUB_REPO_URL}"
//                 }
//             }
//         }
//         stage('Run Unit Tests') {
//             steps {
//                 sh 'python3 -m unittest discover -s . -p "test.py"'
//             }
//         }
//         stage('Build Docker Image') {
//             steps {
//                 script {
//                     sh 'docker --version'  // Check if Docker works
//                     sh 'ls -la'  // List files in the workspace
//                     sh 'whoami'  // Check if Jenkins is the correct user
//                     sh 'docker build -t ${DOCKER_IMAGE_NAME} .'
//                 }
//            }
//         }
//         stage('Push to Docker Hub') {
//             steps {
//                 script{
//                     docker.withRegistry('https://index.docker.io/v1/', 'DockerHubCred') {
//                     def image = docker.build("aryan7767/scientific-calculator:latest")
//                     image.push()
//                 }
//             }
//             }
//         }
//         stage('Deploy using Ansible') {
//             steps {
//                 sh 'ansible-playbook -i inventory deploy.yml'
//             }
//         }
//     }
// }

pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = 'scientific_calculator'
        GITHUB_REPO_URL = 'https://github.com/AryanRastogi7767/Scientific_Calculator.git'
        DOCKER_CREDENTIALS_ID = 'DockerHubCred'  // Ensure this is correct in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                script {
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
                    sh 'docker --version'  // Verify Docker is working
                    sh 'ls -la'  // Debugging: List files in the workspace
                    sh 'whoami'  // Debugging: Check user permissions
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
                    def imageTag = "aryan7767/scientific-calculator:latest"
                    sh "docker tag ${DOCKER_IMAGE_NAME} ${imageTag}"
                    sh "docker push ${imageTag}"
                }
            }
        }

        stage('Deploy using Ansible') {
            steps {
                sh 'pip3 install requests'
                sh 'ansible-playbook -i inventory deploy.yml'
            }
        }
    }
}
