

@Library("product-pipelines-shared-library") _

pipeline {
    agent {
        label "helm-node"
    }
    
    parameters {
        string(name: 'IMAGE_TAG', defaultValue: 'latest', description: 'The tag of the Docker image to deploy')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Unit Test') {
            steps {
                script {
                    sh 'python3 -m pip install pytest'
                    try {
                        sh 'pytest test_webpage.py'
                    } catch (Exception e) {
                        currentBuild.result = 'FAILURE'
                        error('Unit test failed!')
                    }
                }
            }
        }
        stage ("Build Docker") {
            steps {
                docker_builder_kaniko docker_image_name: "simple-webpage",
                                    repo_prefix: "atlantis-test",
                                    tag_latest: true
            }
        }
        
        stage('Deploy to Kubernetes') {
            when {
                expression { env.BRANCH_NAME == 'master' }
            }
            steps {
                script {
                    sh 'kubectl config use-context test-cluster'
                    sh 'kubectl set image deployment/simple-webpage simple-webpage=atlantis-test-docker-dev-local/simple-webpage/simple-webpage:${params.IMAGE_TAG}'
                }
            }
        }
    }
}
