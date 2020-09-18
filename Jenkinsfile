podTemplate(
    name: 'argocd-pod',
    label: 'argocd-pod',
    containers: [
        containerTemplate(name: 'golang', image: 'golang:1.9.4-alpine3.7'),
        containerTemplate(name: 'docker', image:'trion/jenkins-docker-client'),
    ],
    volumes: [
        hostPathVolume(mountPath: '/var/run/docker.sock',
        hostPath: '/var/run/docker.sock')
    ],
    {   
        agent { dockerfile true }
        //node = the pod label
        node('argocd-pod'){
            //container = the container label
            stage('Build'){
                container('golang'){
                    // This is where we build our code.
                }
            }
            stage('Build Docker Image'){
                container(‘docker’){
                    // This is where we build the Docker image
                }
            }
        }
    })
