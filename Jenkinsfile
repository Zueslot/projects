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
                sh "${mvn}/bin/mvn clean verify sonar:sonar -Dsonar.projectKey=zeus -Dsonar.projectName='zeus'"
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
    }
}
