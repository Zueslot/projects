pipeline {
    agent any

    stages {
        stage('Repo checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Zueslot/projects.git'
                sh 'ls -la'
            }
        }
        stage('Maven build and Clean') {
            steps {
                echo 'building maven'
                sh 'mvn clean'
                sh ' mvn package'
            }
        }
        stage('Docker build') {
            steps {
                echo 'Running docker build'
            // sh "docker build -t zeusapp -f Dockerfile.txt . "
            }
        }
        // stage(' Image tagging') {
        //     steps {
        //     // echo "tagging images now..."
        //     // sh "docker tag zeusapp zeusmanor/zeusapp:latest"
        //     }
        // }
        stage('docker login') {
            steps {
                echo 'Docker login...'
                withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'Docker_Password', usernameVariable: 'Docker_User')]) {
                    sh '''
                        echo "$Docker_Password" | docker login -u "$Docker_User" --password-stdin
                    '''
                }
            }
        }
        stage('docker push') {
            steps {
                echo "pushing image to docker"
                sh "docker push $zeusapp:latest
            }
        }
    }
}

