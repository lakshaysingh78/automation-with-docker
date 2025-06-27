pipeline {
    agent { label 'server-1' }

    environment {
        SONAR_TOKEN = credentials('sonarqube-token') // Jenkins credentials
    }

    stages {

        stage('📦 Clone Repository') {
            steps {
                echo '📥 Cloning GitHub repository...'
                // SCM se clone already ho jaata hai
            }
        }export SONAR_SCANNER_OPTS="-Xmx512m"

        stage('🔍 SonarQube Code Scan') {
            steps {
                script {
                    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                        echo '🔍 Running lightweight SonarQube analysis...'
                        sh '''
                            export SONAR_SCANNER_OPTS="-Xmx512m" 
                            /opt/sonar-scanner/bin/sonar-scanner \
                            -Dsonar.projectKey=automation-with-docker \
                            -Dsonar.sources=. \
                            -Dsonar.exclusions=**/tests/**,**/migrations/** \
                            -Dsonar.host.url=https://c43e-2409-40d2-10b9-9e79-9f30-d6bb-f797-20f7.ngrok-free.app \
                            -Dsonar.login=$SONAR_TOKEN \
                            -Dsonar.qualitygate.wait=false
                        '''
                    }
                }
            }
        }

        stage('🧼 Clean Up Old Containers') {
            steps {
                echo '🧹 Removing old Docker containers (if any)...'
                sh 'sudo docker compose down || true'
                sh 'sudo docker system prune -f || true'
            }
        }

        stage('🔧 Build & 🚀 Deploy Application') {
            steps {
                echo '🔧 Installing dependencies & 🚀 Deploying app...'
                sh 'sudo docker compose up --build -d'
            }
        }

        stage('🌐 Application URL') {
            steps {
                echo '✅ App deployed at: http://13.126.197.203:8000'
            }
        }
    }

    post {
        failure {
            echo '❌ Deployment failed. Please check Jenkins logs for details.'
        }
    }
}
