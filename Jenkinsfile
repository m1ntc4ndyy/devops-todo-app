#!/usr/bin/env groovy

import groovy.transform.Field

@Field
String SSH_ID_REF = 'ssh-credentials-id'

pipeline {
    agent any
    tools {dockerTool 'docker'}

    stages {
        stage('Docker build') {
            steps {
                sh 'docker build -t m1ntc4ndy/todo-app .'
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'v-docker-hub', usernameVariable: 'USER', passwordVariable: 'PASSWD')]) {
                    sh 'docker login -u "$USER" -p "$PASSWD"'
                    sh 'docker push "$USER"/todo-app'
                }
            }
        }

        stage('Pull docker to EC2') {
            steps {
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