pipeline {
     agent any
  tools {
    maven "MVN3"
  }
  
  stages {
    stage('pullscm') {
      steps {
        git branch: 'main', credentialsId: 'github', url: 'git@github.com:sathishbob/functional-testing.git'
      }
    }
    stage('execute test') {
      steps {
        sh "mvn clean test"  
      }
         post {
              success {
                   publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'TestReport', reportFiles: 'TestReport.html', reportName: 'FunctionalTestReport', reportTitles: '', useWrapperFileDirectly: true])
              }
         }
    }
    stages('get result') {
         environment {
             PASS = sh(script: 'cat TestReport.html | grep passParent | cut -d \':\' -f2 | cut -d \',\' -f1',returnStdout: true)
         }
         steps {
              echo "Total test case passed is: ${PASS}" 
         }
    }
  }
}
