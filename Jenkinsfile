node{
 def mavenHome = tool name: "maven3.8.5"


//Checkout Stage
stage('CheckoutCode'){
  git branch: 'development', credentialsId: 'be624cd2-9c43-4b67-a251-6272a5386973', url: 'https://github.com/MithunTechnologiesDevOps/maven-web-application.git'
}

//Build Stage
stage('Build'){
   
sh "$mavenHome/bin/mvn clean package"
}
/*
//Generate SonarQube Report 
stage('SonarQubeReport'){
sh "$mavenHome/bin/mvn sonar:sonar"
}

//Upload Artifact into Artifcatory repo
stage('UploadArtifcatsIntoNexus'){
sh "$mavenHome/bin/mvn deploy"
}

//Deploy App into Tomcat Server
stage('DeployAppIntoTomcat'){
sshagent(['37d38c8c-1fbf-48a6-ae04-ee8dc0fd9b87']) {
   sh "scp -o StrictHostKeyChecking=no target/maven-web-application.war ec2-user@13.232.7.247:/opt/apache-tomcat-9.0.60/webapps"
}
}
*/

}//Node Closing 
