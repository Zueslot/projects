pipeline {
    agent any
    
    environment {
        DOCKER_CREDENTIALS = credentials('docker')
    }
    
    tools {
        maven 'mvn'
    }
    
    stages {
        stage("Repo Checkout") {
            steps {
                git branch: 'main', url: 'https://github.com/Zueslot/gbedu.git'
            }
        }
        
        stage("Maven Build") {
            steps {
                echo "running maven build"
                sh "mvn clean"
                sh "mvn package"
            }
        }
        
        stage("Sonarqube Analysis") {
            steps {
                echo "running Sonarqube analysis"
                sh "mvn sonar:sonar -Dsonar.qualitygate.wait=true"
            }
        }
        
        stage('Docker image build with tomcat') {
            steps {
                echo "this is a docker build of a tomcat image with our artifact"
                sh "docker build -t zeus ."
            }
        }
        
        stage("Image tagging") {
            steps {
                echo "image tagging"
                sh "docker tag zeus:latest zeusmanor/zeus:1.0.0"
            }
        }
        
        stage("Artifactory Management") {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker', 
                                                     usernameVariable: 'DOCKER_USER', 
                                                     passwordVariable: 'DOCKER_PASS')]) {
                        sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
                        sh "docker push zeusmanor/zeus:1.0.0"
                    }
                }
            }
        }
        
        stage("Kubernetes Deployment") {
            steps {
                // echo "Deploying to Kubernetes"
                // sh "kubectl apply -f deployment.yaml"
                // sh "kubectl apply -f service.yaml"
            }
        }
    }
}
