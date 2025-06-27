pipeline {
    agent { label 'server-1' }

    environment {
        SONAR_TOKEN = credentials('sonarqube-token') // This pulls the token from Jenkins credentials
    }

    stages {

        stage('📦 Clone Repository') {
            steps {
                echo 'Cloning GitHub repository...'
            }
        }

        stage('🔍 SonarQube Code Scan') {
            steps {
                echo 'Running SonarQube analysis...'
                sh '''
                    /opt/sonar-scanner/bin/sonar-scanner \
                    -Dsonar.projectKey=automation-with-docker \
                    -Dsonar.sources=. \
                    -Dsonar.host.url=http://localhost:9000 \
                    -Dsonar.login=$SONAR_TOKEN
                '''
            }
        }

        stage('🧼 Clean Up Old Containers') {
            steps {
                echo 'Removing old Docker containers (if any)...'
                sh 'sudo docker compose down || true'
                sh 'sudo docker system prune -f || true'
            }
        }

        stage('🔧 Build & 🚀 Deploy Application') {
            steps {
                echo 'Installing dependencies, building Docker images and deploying containers...'
                sh 'sudo docker compose up --build -d'
            }
        }

        stage('🌐 Application URL') {
            steps {
                echo '🚀 Application deployed at: http://13.126.197.203:8000'
            }
        }
    }

    post {
        failure {
            echo '❌ Deployment failed. Please check logs.'
        }
    }
}
