#! /bin/bash

# Specify the server URL
server="https://192.168.22.128:8443"
service_account_name=jenkins

#
# Get the information we need from the cluster
#
# This is the service account secret that contains the sa token.
sa_secret=$(kubectl get serviceaccount ${service_account_name} -o jsonpath="{.secrets[0].name}")
# This is the service account token.
token=$(kubectl get secret ${sa_secret} -o jsonpath="{.data.token}" | base64 --decode)
# This is the Cluster CA, for establishing trust with the API Server.
ca=$(kubectl get secret ${sa_secret} -o jsonpath="{.data.ca\.crt}")

# Print out a kubeconfig file that contains the server, CA crt, and token.
echo "
apiVersion: v1
kind: Config
clusters:
- name: default-cluster
  cluster:
    certificate-authority-data: ${ca}
    server: ${server}
contexts:
- name: default-context
  context:
    cluster: default-cluster
    namespace: default
    user: default-user
current-context: default-context
users:
- name: default-user
  user:
    token: ${token}
"

