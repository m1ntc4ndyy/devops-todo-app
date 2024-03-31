#!/usr/bin/env groovy

import groovy.transform.Field

@Field
String SSH_ID_REF = 'ssh-credentials-id'

pipeline {
    agent any
    tools {dockerTool 'docker'}

    stages {
        // stage('Build and Test') {
        //     steps {
        //         sh 'docker build -t todo-app .'
        //         sh 'docker images'
        //     }
        // }
        // stage('Push to DockerHub ') {
        //     steps {
        //         withBuildConfiguration {
        //             sh 'docker login -u "$USER" -p "$PASSWD"'
        //             sh 'docker tag todo-app "$USER"/todo-app'
        //             sh 'docker push "$USER"/todo-app'
        //         }
        //     }
        // }

        stage('Pull docker to EC2') {
            steps {
                withBuildConfiguration {
                    sshagent(credentials: [SSH_ID_REF]) {
                        sh ''' 
                            docker containter ls
                            docker ps
                        '''
                    }
                }
            }
        }
    }
}


void withBuildConfiguration(Closure body) {
    withCredentials([usernamePassword(credentialsId: 'v-docker-hub', usernameVariable: 'USER', passwordVariable: 'PASSWD')]) {
        body()
    }
}