pipeline {
  agent any

  stages {
      stage('Hello'){
          steps {
            git branch: 'main', url: 'https://github.com/m1ntc4ndyy/devops-todo-app'
            sh 'ls -la'
          }
      }
  }
}
