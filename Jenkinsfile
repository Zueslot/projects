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
        stage("Quality Gate"){
          timeout(time: 1, unit: 'HOURS') {
              def qg = waitForQualityGate()
              if (qg.status != 'OK') {
                  error "Pipeline aborted due to quality gate failure: ${qg.status}"
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
                sh 'docker tag zeusapp zeusmanor/zeusapp:1.0.2'
            }
        }
        stage('Docker Login') {
            steps {
                echo 'Loggin in to Docker'
                withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'Docker_password', usernameVariable: 'Docker_user')]) {
                    sh '''
                        echo "$Docker_password" | docker login -u "$Docker_user" --password-stdin
                    '''
                }
            }
        }
                stage('docker push') {
            steps {
                echo 'pushing image to docker'
                sh '''
                  docker push zeusmanor/zeusapp:1.0.2
                  '''
            }
                }
    // stage('Kubernetes Deployment') {
    //     steps {
    //         echo 'Deploying to Kubernetes'
    //         sh 'kubectl apply -f deployment.yaml'
    //         sh 'kubectl apply -f service.yaml'
    //     }
    // }
    }
}

    // post {
    //     success {
    //         emailext(
    //             subject: "✅ SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
    //             body: """
    //                 <p>✔️ The build <b>${env.JOB_NAME}</b> #${env.BUILD_NUMBER} completed successfully.</p>
    //                 <p>View details: <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
    //             """,
    //             to: 'koolharmbhrosz1@gmail.com'
    //         )
    //     }

    //     failure {
    //         emailext(
    //             subject: "❌ FAILURE: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
    //             body: """
    //                 <p>❗ The build <b>${env.JOB_NAME}</b> #${env.BUILD_NUMBER} has <b>FAILED</b>.</p>
    //                 <p>View details: <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
    //             """,
    //             to: 'ambroseeziugo@gmail.com'
    //         )
    //     }

    //     unstable {
    //         emailext(
    //             subject: "⚠️ UNSTABLE: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
    //             body: """
    //                 <p>⚠️ The build <b>${env.JOB_NAME}</b> #${env.BUILD_NUMBER} is <b>UNSTABLE</b>.</p>
    //                 <p>View details: <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
    //             """,
    //             to: 'koolharmbhrosz1@gmail.com'
    //         )
    //     }
    // }

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
