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
        PASS = sh (
             script: sh 'cat TestReport.html | grep passParent | cut -d \':\' -f2 | cut -d \',\' -f1',
             returnStdout: true
             ).trim()
        echo "Total test case passed is: ${PASS}"  
             
      }
         post {
              success {
                   publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'TestReport', reportFiles: 'TestReport.html', reportName: 'FunctionalTestReport', reportTitles: '', useWrapperFileDirectly: true])
              }
         }
    }
  }
}
