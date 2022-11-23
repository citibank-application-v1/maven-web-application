node {
    def mavenHome = tool name: 'maven3.8.6'
    
    //checkout code from git
    stage('CheckOutCode'){
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
}//node end
