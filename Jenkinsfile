pipeline {
    agent { label 'server-1' }

    stages {

        stage('📦 Clone Repository') {
            steps {
                echo 'Cloning GitHub repository..'
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
                echo '🚀 Application deployed at: http://13.203.206.105:8000'
            }
        }
    }

    post {
        failure {
            echo '❌ Deployment failed. Please check logs.'
        }
    }
}
