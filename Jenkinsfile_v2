pipeline {
    agent {
        dockerfile true 
    }
     
    
    stages {       
        stage('Prepare') {
            steps {
                checkout([$class: 'GitSCM',
                branches: [[name: "origin/master"]],
                doGenerateSubmoduleConfigurations: false,
                submoduleCfg: [],
                userRemoteConfigs: [[
                    url: 'https://github.com/Boutheina-Dab/argocd-example-apps.git']]
                ])
            }
        }
        stage('Test') {
            steps {
                sh 'docker version'
                //sh 'argocd version'
            }
        }
        
        stage ('Deploy_K8S') {
             steps {
                     withCredentials([string(credentialsId: "argocd-deply-role", variable: 'ARGOCD_AUTH_TOKEN')]) {
                        sh '''
                        ARGOCD_SERVER="argocd-prod.example.com"
                        APP_NAME="guestbook"
                        CONTAINER="guestbook-ui"
                        
                        # login to minikube kubernetes cluster
                          
                        # Customize image 
                        ARGOCD_SERVER=$ARGOCD_SERVER argocd --grpc-web app set $APP_NAME --kustomize-image $IMAGE_DIGEST
                        
                        # Deploy to ArgoCD
                        ARGOCD_SERVER=$ARGOCD_SERVER argocd --grpc-web app sync $APP_NAME --force
                        ARGOCD_SERVER=$ARGOCD_SERVER argocd --grpc-web app wait $APP_NAME --timeout 600
                        '''
               }
            }
        }
    }
}
