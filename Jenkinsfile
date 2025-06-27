pipeline {
    agent { label 'server-1' } // 👈 EC2 slave node ka label, jo tu Jenkins me diya hai

    environment {
        PROJECT_DIR = 'automation-with-docker'  // 👈 folder ka naam jisme tera code aayega
    }

    stages {
        stage('📦 Clone Repository') {
            steps {
                echo 'Cloning GitHub repository...'
                // SCM se clone ho raha hai, isliye agar Jenkins job me already set hai to ye optional hai
                // sh 'git clone https://github.com/lakshaysingh78/automation-with-docker.git'
            }
        }

        stage('🧼 Clean Up Old Containers') {
            steps {
                echo 'Removing old Docker containers (if any)...'
                sh '''
                docker compose down || true
                docker system prune -f || true
                '''
            }
        }

        stage('🔧 Build & 🚀 Deploy Application') {
            steps {
                echo 'Installing dependencies, building Docker images and deploying containers...'
                sh "cd ${PROJECT_DIR} && docker compose up --build -d"
            }
        }

        stage('🌐 Application URL') {
            steps {
                echo 'Deployment done!'
                echo 'Access your app at: http://13.234.76.179:8000'
            }
        }
    }

    post {
        success {
            echo '✅ Deployment successful!'
        }
        failure {
            echo '❌ Deployment failed. Please check logs.'
        }
    }
}
