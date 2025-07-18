pipeline {
    agent any

stages {
    stage("Repo checkout") {
        steps {
            git branch: 'main', url: "https://github.com/Zueslot/projects.git"
            sh "ls -la"
        }
    }
    }
}