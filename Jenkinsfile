pipeline {
    agent any

    stages {
        stage('Repo Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Zueslot/projects.git'
                sh 'ls -la'
            }
        }
        stage('Maven Package') {
            steps {
                echo ' Packaging artifact using maven...'
                sh 'mvn clean package'
                withSonarQubeEnv('SonarQubeServerName') {
                    // Use this above & below line if both Jenkins and Sonar are in the same server Set this in manage jenkins-settings, search "SonarQube servers" use sonarqube global token
                    sh 'mvn sonar:sonar -Dsonar.qualitygate.wait=true'
                }
            }
        }
        stage('Docker build') {
            steps {
                echo ' Building docker image with artifact...'
                sh 'docker build -t zeusapp -f Dockerfile.txt .'
            }
        }
        stage('Tagging Docker image') {
            steps {
                echo ' Tagging Docker image...'
                sh 'docker tag zeusapp zeusmanor/zeusapp:1.0.0'
            }
        }
        stage('Docker Login') {
            steps {
                echo 'Loggin in to Docker'
                withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'Docker_Password', usernameVariable: 'Docker_User')]) {
                    sh '''
                        echo "$Docker_Password" | docker login -u "$Docker_User" --password-stdin
                    '''
                }
            }
        }
                stage('docker push') {
            steps {
                echo 'pushing image to docker'
                sh '''
                  docker push zeusmanor/zeusapp:1.0.0
                  '''
            }
                }
        stage('Kubernetes Deployment') {
            steps {
                echo 'Deploying to Kubernetes'
                sh 'kubectl apply -f deployment.yaml'
                sh 'kubectl apply -f service.yaml'
            }
        }
    }
}

// pipeline {
//     agent any

//     environment {
//         DOCKER_CREDENTIALS = credentials('docker')
//     }

//     tools {
//         maven 'mvn'
//     }

//     stages {
//         stage("Repo Checkout") {
//             steps {
//                 git branch: 'main', url: 'https://github.com/Zueslot/gbedu.git'
//             }
//         }

//         stage("Maven Build") {
//             steps {
//                 echo "running maven build"
//                 sh "mvn clean"
//                 sh "mvn package"
//             }
//         }

//         stage("Sonarqube Analysis") {
//             steps {
//                 echo "running Sonarqube analysis"
//                 sh "mvn sonar:sonar -Dsonar.qualitygate.wait=true"
//             }
//         }

//         stage('Docker image build with tomcat') {
//             steps {
//                 echo "this is a docker build of a tomcat image with our artifact"
//                 sh "docker build -t zeus ."
//             }
//         }

//         stage("Image tagging") {
//             steps {
//                 echo "image tagging"
//                 sh "docker tag zeus:latest zeusmanor/zeus:1.0.0"
//             }
//         }

//         stage("Artifactory Management") {
//             steps {
//                 script {
//                     withCredentials([usernamePassword(credentialsId: 'docker',
//                                                      usernameVariable: 'DOCKER_USER',
//                                                      passwordVariable: 'DOCKER_PASS')]) {
//                         sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
//                         sh "docker push zeusmanor/zeus:1.0.0"
//                     }
//                 }
//             }
//         }

//         stage("Kubernetes Deployment") {
//             steps {
//                 echo "Deploying to Kubernetes"
//                 sh "kubectl apply -f deployment.yaml"
//                 sh "kubectl apply -f service.yaml"
//             }
//         }
//     }
// }
