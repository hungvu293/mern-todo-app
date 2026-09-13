pipeline {
    agent any

    environment {
        DEPLOY_HOST = 'YOUR_VPS_IP'
        DEPLOY_PATH = '/opt/mern-todo-app'
    }

    stages {
        stage('Deploy') {
            steps {
                withCredentials([
                    sshUserPrivateKey(
                        credentialsId: 'vps-ssh-key',
                        keyFileVariable: 'SSH_KEY',
                        usernameVariable: 'SSH_USER'
                    )
                ]) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no \
                            -i "$SSH_KEY" \
                            "$SSH_USER@$DEPLOY_HOST" \
                            "cd '$DEPLOY_PATH' && git pull origin main && docker compose up -d --build"
                    '''
                }
            }
        }
    }
}
