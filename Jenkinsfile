@Library("product-pipelines-shared-library") _

pipeline {
    agent {
        label "helm-node"
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
    }
}
