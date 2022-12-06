node('nodes'){
    try{ 
        
        def mavenHome = tool name: 'maven3.8.6'

        echo "The Job name is: ${env.JOB_NAME}" 
        echo "The Build numebr is: ${env.BUILD_NUMBER}"
        echo "The node name is: ${env.NODE_NAME}"

        properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '5', daysToKeepStr: '', numToKeepStr: '5')), [$class: 'JobLocalConfiguration', changeReasonComment: ''], pipelineTriggers([pollSCM('* * * * *')])])

        //checkout code from git
        stage('CheckOutCode'){
            sendSlackNotifications("STARTED")
            git branch: 'development', credentialsId: '49632c67-e760-4f4d-b0c6-2a2304f12e01', url: 'https://github.com/citibank-application-v1/maven-web-application.git'
        }

        //Build
        stage('Build'){
            sh "${mavenHome}/bin/mvn clean package"
        }
        
        //Generate sonarqube report
        stage('SonarQubeReport'){
            sh "${mavenHome}/bin/mvn sonar:sonar"
        }

        //Store to Remote Repo
        stage('StoreArtifactToRemoteRepo'){
            sh "${mavenHome}/bin/mvn deploy"
        }

        //Deploy to app
        stage('Deploy'){
           sshagent(['2111ded7-4f97-47e2-9f93-277646565e29']) {
            sh "scp -o StrictHostKeyChecking=no target/maven-web-application.war ec2-user@172.31.45.159:/opt/apache-tomcat-9.0.68/webapps"
            }
        }
    }
   
    catch(e){
    currentBuild.result = "FAILURE"
    }
    finally{
    sendSlackNotifications(currentBuild.result)
    }

}//node end




            def sendSlackNotifications(String buildStatus = 'STARTED') {
              // build status of null means successful
              buildStatus =  buildStatus ?: 'SUCCESS'

              // Default values
              def colorName = 'RED'
              def colorCode = '#FF0000'
              def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
              def summary = "${subject} (${env.BUILD_URL})"

              // Override default values based on build status
              if (buildStatus == 'STARTED') {
                colorName = 'YELLOW'
                colorCode = '#FFFF00'
              } else if (buildStatus == 'SUCCESS') {
                colorName = 'GREEN'
                colorCode = '#00FF00'
              } else {
                colorName = 'RED'
                colorCode = '#FF0000'
              }

              // Send notifications
              slackSend (color: colorCode, message: summary)
            }
