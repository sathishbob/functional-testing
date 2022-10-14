def readProb;
def FAILED_STAGE
pipeline {
agent { label 'master'}
tools {
  git 'Default'
  maven 'mavan-demo'
}
stages {
    stage('Preperation'){
    steps {
        script {
        readProb = readProperties  file:'config.properties'
        FAILED_STAGE=env.STAGE_NAME
        Preperation= "${readProb['Preperation']}"
                if ("$Preperation" == "yes") {
            sh "git config --global user.email zippyops@gmail.com"
        sh "git config --global user.name zippyops"
        sh 'git config --global credential.helper cache'
        sh 'git config --global credential.helper cache'
        sh 'rm -rf devsecopscodebase'
                }
                else {
                 echo "Skipped"
                }
                }
                }
    }
   stage('Git Pull'){
        steps { dir("${readProb['Project_name']}"){
                 git branch: "${readProb['branch']}", credentialsId: "${readProb['credentials']}", url: "${readProb['git.url']}"
              }
                }
         }
     stage('SonarQube analysis') {
          steps {
            script {
         scannerHome = tool 'sonarqube';
             FAILED_STAGE=env.STAGE_NAME
                  SonarQube= "${readProb['SonarQube_Analysis']}"
                if ("$SonarQube" == "yes") {
          withSonarQubeEnv('sonarqube') {
          sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=${readProb['sonar_projectKey']} -Dsonar.projectName=${readProb['sonar_projectName']} -Dsonar.projectVersion=${readProb['sonar_projectVersion']} -Dsonar.projectBaseDir=${readProb['sonar_projectBaseDir']} -Dsonar.sources=${readProb['sonar_sources']} -Dsonar.java.binaries=${readProb['sonar_binaries']}"
           }
            }
                else {
                  echo "Skipped"
                  }
                 }
                }
     }
    stage("Sonarqube Quality Gate") {
           steps {
             script {
            FAILED_STAGE=env.STAGE_NAME
                        Quality= "${readProb['SonarQube_Quality']}"
                    if ("$Quality" == "yes") {
            timeout(time: 1, unit: 'HOURS') {
                waitForQualityGate abortPipeline: true
              }
            }
                        else {
                        echo "skipped"
                        }
                   }
         }
       }

    
        stage("test") {
           steps {
       script {
            FAILED_STAGE=env.STAGE_NAME
        build= "${readProb['Build']}"
                if ("$build" == "yes") {
               sh """
               cd devsecopscodebase/
               mvn clean test
                   """
            }
                 else {
                   echo "Skipped"
                    }
                   }
                 }
        }
  
    }
  post {
      success {
          
            publishHTML target: [
            allowMissing: false,
            alwaysLinkToLastBuild: true,
            keepAll: true,
            reportDir: 'devsecopscodebase/TestReport',
            reportFiles: 'TestReport.html',
            reportName: 'Dev_Testng_Report'
              ]


            }
        }
}
