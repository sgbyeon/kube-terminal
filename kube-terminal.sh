#!/bin/bash

err_report() {
    echo "Error on line $1"
    exit 1
}

trap 'err_report $LINENO' ERR

KUBE_BIN="/usr/bin"
KUBECTL_VERSION="v1.21.0"
KUBECTL_DOWNLOAD_URL="https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
KUBECTX_GIT="https://github.com/ahmetb/kubectx.git"
KUBEPS1_GIT="https://github.com/jonmosco/kube-ps1.git"

mkdir download; cd download

# kubectl install
curl -LO $KUBECTL_DOWNLOAD_URL
cp kubectl $KUBE_BIN

# kubectx install
git clone $KUBECTX_GIT
cp kubectx/kubectx $KUBE_BIN
cp kubectx/kubens $KUBE_BIN

# kube-ps1 install
git clone $KUBEPS1_GIT
cp kube-ps1/kube-ps1.sh $KUBE_BIN

# permission modify
chmod 700 $KUBE_BIN/{kubectx,kubens,kubectl,kube-ps1.sh}

# bash_completion and PS1 setting
cat >> ~/.bashrc <<EOF

# for kubernetes
alias k='kubectl'
source <(k completion bash)
complete -F __start_kubectl k

alias kall='kubectl get all --all-namespaces'
alias kx='kubectx'
alias kns='kubens'

source /usr/bin/kube-ps1.sh
PS1='[\\u@\\h \\W \$(kube_ps1)]# '
EOF
