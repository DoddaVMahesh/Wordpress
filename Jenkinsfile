pipeline {
    agent any
    environment {
      AWS_ACCESS_KEY = credentials('aws-access-key') // Jenkins stored credentials
      AWS_SECRET_KEY = credentials('aws-secret-key')
    }

    options {
        ansiColor('xterm')
        buildDiscarder(logRotator(numToKeepStr: '5'))
        }
        stages {
            stage(checkout) {
                steps {
                    script {
                        checkout scm
                    }
                }
            }

            stage(tfinit) {
                steps {
                    script {
                        bat 'terraform.exe init'
                    }
            }

            }
            stage(tfplan) {
                steps {
                    script {
                         bat 'terraform.exe plan'
                    }
                }
            }
          stage(tfapply) {
            steps {
              script {
                bat 'terraform.exe apply --auto-approve'
              }
            }
          }   
            
        }
}
