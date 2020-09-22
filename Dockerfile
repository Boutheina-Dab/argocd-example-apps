FROM jenkins/agent

USER root

RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common && \ 
    curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/v1.7.6/argocd-linux-amd64 && \
    chmod +x /usr/local/bin/argocd

USER 1001

