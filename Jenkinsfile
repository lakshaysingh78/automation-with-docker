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
