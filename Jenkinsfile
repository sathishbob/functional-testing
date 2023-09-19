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
         echo 'test'
        //sh "mvn clean test"  
      }
         post {
              success {
                   publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'TestReport', reportFiles: 'TestReport.html', reportName: 'FunctionalTestReport', reportTitles: '', useWrapperFileDirectly: true])
              }
         }
    }
    stage('get result') {
         environment {
           PASS = sh(script: 'cat TestReport/TestReport.html | grep passParent | cut -d \':\' -f2 | cut -d \',\' -f1',returnStdout: true)
           FAIL = sh(script: 'cat TestReport/TestReport.html | grep failParent | cut -d \':\' -f2 | cut -d \',\' -f1',returnStdout: true)
        }
         steps {
            echo "Total test case passed is: ${PASS}" 
            echo "Total test case failled is: ${FAIL}" 
            emailext body: "Please check console output at $BUILD_URL for more information\n Passed Test case count is: ${PASS} \n Failled Test case count is: ${FAIL} \n", to: "sathishbob@gmail.com", subject: 'JenkinsTraining - $PROJECT_NAME is changed- Build number is $BUILD_NUMBER - Build status is $BUILD_STATUS'
         }
    }
  }
}
