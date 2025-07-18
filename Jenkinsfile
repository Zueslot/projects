pipeline {
    agent any

tools {
    maven 'mvn'
}

stages {
    stage ("Repo checkout")
        steps {
            git branch: 'main', url: "https://github.com/Zueslot/projects.git"
        }
    }
}