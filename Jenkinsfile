node{

  try{
    
def mavenHome = tool name: 'maven3.8.5'

echo "The Job Name is: ${env.JOB_NAME}"
echo "The Build Number is: ${env.BUILD_NUMBER}"
echo "The node Name is: ${env.NODE_NAME}" 
  
  
properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '5', daysToKeepStr: '', numToKeepStr: '5')), [$class: 'JobLocalConfiguration', changeReasonComment: ''], pipelineTriggers([pollSCM('* * * * *')])])


//Checkout Code state
stage('CheckoutCode'){
sendSlcaknNotifications('STARTED')
git branch: 'development', credentialsId: '763f3572-3ee3-4058-b397-69bf9fc0b934', url: 'https://github.com/citibank-appse/maven-web-application.git'
}

//Build
stage('Build'){
  
sh "${mavenHome}/bin/mvn clean package"
}

  
//EXCUTE SonarQube Report
stage ('ExcuteSonarQubeReport'){
sh "${mavenHome}/bin/mvn sonar:sonar"
}

//Upload Artifacts Into Nexus
stage ('UploadArtifactsIntoNexus'){
sh "${mavenHome}/bin/mvn deploy"
}

//Deploy App Into Tomcat Server
stage ('DeployApp'){
sshagent(['ba7d17b2-486a-4ea0-b586-64b9d16160b4']) {
    // some block
sh "scp -o StrictHostKeyChecking=no target/maven-web-application.war ec2-user@172.31.4.212:/opt/apache-tomcat-9.0.68/webapps/"
}
}


}//try closing
catch(e){
currentBuild.result = "FAILURE"
}
finally{
sendSlcaknNotifications(currentBuild.result)
}
  
}//node closing

//Function for slack notifications

def sendSlcaknNotifications(String buildStatus = 'STARTED') {
  // build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESS'

  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
  def summary = "${subject} (${env.BUILD_URL})"

  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (buildStatus == 'SUCCESS') {
    color = 'GREEN'
    colorCode = '#00FF00'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
  }

  // Send notifications
  slackSend (color: colorCode, message: summary)
}
