pipeline {
  agent {
    docker {
      image 'janeesh4/custom-jenkins-agent'
      args '--user root -v /var/run/docker.sock:/var/run/docker.sock'
    }
  }

  stages {
    // stage('Checkout') {
    //   steps {
    //     sh 'echo passed'
    //     git branch: 'main', url: 'https://github.com/Janeesh23/jenkins_argocd.git'
    //   }
    // }

    stage('Build and Test') {
      steps {
        sh 'mvn clean package'
      }
    }

    stage('Static Code Analysis') {
      environment {
        SONAR_URL = "http://13.232.100.65:9000"
      }
      steps {
        withCredentials([string(credentialsId: 'sonarqube', variable: 'SONAR_AUTH_TOKEN')]) {
          sh '''
            mvn sonar:sonar \
              -Dsonar.login=$SONAR_AUTH_TOKEN \
              -Dsonar.host.url=$SONAR_URL \
              -Dsonar.projectKey=shipping \
              -Dsonar.projectName="Shipping Service"
          '''
        }
      }
    }

    stage('Build and Push Docker Image') {
      steps {
        script {
          def dockerImage = "janeesh4/shipping-service:${BUILD_NUMBER}"
          sh "docker build -t ${dockerImage} ."
          withDockerRegistry(credentialsId: 'docker-cred', url: 'https://index.docker.io/v1/') {
            sh "docker push ${dockerImage}"
          }
        }
      }
    }

    stage('Update Deployment File') {
      environment {
        GIT_REPO_NAME = "jenkins_argocd"
        GIT_USER_NAME = "Janeesh23"
      }
      steps {
        withCredentials([string(credentialsId: 'github', variable: 'GITHUB_TOKEN')]) {
          sh '''
            git config user.email "jenkinsbot@example.com"
            git config user.name "jenkins_bot"

            # Replace image version in Helm values.yaml
            sed -i "s/^  version: .*/  version: ${BUILD_NUMBER}/" helm/values.yaml

            git add helm/values.yaml
            git commit -m "Update image version to ${BUILD_NUMBER}" || echo "No changes to commit"
            git push https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:main
          '''
        }
      }
    }
  } 
} 
