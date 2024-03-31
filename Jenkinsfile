#!/usr/bin/env groovy

import groovy.transform.Field

@Field
String DOCKER_USER_REF = '<DOCKERHUB_ID_PLACEHOLDER>'
@Field
String SSH_ID_REF = '<SSH_ID_PLACEHOLDER>'

pipeline {
    agent any

    tools {
        dockerTool 'docker'
    }

    stages {
        stage("build") {
            steps {
              sh 'docker build -t m1ntc4ndy/todo-app'
            }
        }
        stage("Docker login and push docker image") {
            steps {
                withCredentials([usernamePassword(credentialsId:'v-docker-hub',usernameVariable: 'USER', passwordVariable: 'PASSWD' )]) {
                    sh 'docker login -u "$USER" -p "$PASSWD"'
                    sh 'docker push m1ntc4ndy/todo-app'
                }
            }   
        }
        stage("deploy to EC2") {
            steps {
                withBuildConfiguration {
                    sshagent(credentials: [SSH_ID_REF]) {
                        sh '''
                            docker run -d --rm --name todo-app -p 8000:8000 m1ntc4ndy/todo-app
                            docker ps
                        '''
                    }
                }
            }
        }
    }
}

void withBuildConfiguration(Closure body) {
    withCredentials([usernamePassword(credentialsId: DOCKER_USER_REF, usernameVariable: 'repository_username', passwordVariable: 'repository_password')]) {
        body()
    }
}