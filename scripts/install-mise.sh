#!/usr/bin/env bash

# Vagrant default username
VAGRANT_USER="vagrant"
VAGRANT_HOME="/home/$VAGRANT_USER"
run_as_vagrant() {
    sudo -H -u "$VAGRANT_USER" bash -l -c "$1"
}

# Mise install
run_as_vagrant 'curl https://mise.run | sh'
for shell in bash zsh; do
    echo "eval \"\$($VAGRANT_HOME/.local/bin/mise activate $shell)\"" >> "$VAGRANT_HOME/.${shell}rc"
done

# k8s tools install
run_as_vagrant 'eval "$('"$VAGRANT_HOME"'/.local/bin/mise activate bash)"'
run_as_vagrant 'mise use kubectl'
run_as_vagrant 'mise use kubecolor'
run_as_vagrant 'mise use minikube'
run_as_vagrant 'mise use k9s'

# aliases
echo 'alias kubectl=kubecolor' >> "$VAGRANT_HOME/.bashrc"
echo 'alias k=kubectl' >> "$VAGRANT_HOME/.bashrc"