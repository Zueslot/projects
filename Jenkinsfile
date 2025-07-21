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
            }
        }
        stage('Docker build') {
            steps {
                echo ' Building docker image with artifact...'
                sh 'docker build -t zeusapp -f Dockerfile .'
            }
        }
    }
}
