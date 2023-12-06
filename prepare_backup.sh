#!/usr/bin/env bash
echo "Preparing backup"

echo "copying zsh history"
cp ~/.zsh_history ~/workspace/backups/zsh/zsh_history

echo "copying hosts file"
cp /etc/hosts ~/workspace/backups/hosts

echo "copying ssh"
cp ~/.ssh/config ~/workspace/backups/ssh/
cp ~/.ssh/authorized_keys ~/workspace/backups/ssh/
cp ~/.ssh/known_hosts ~/workspace/backups/ssh/

echo "copying kubernetes config"
cp ~/.kube/config ~/workspace/backups/kube/config
cp ~/.kube/kubectx ~/workspace/backups/kube/kubectx
cp ~/.kube/kubens ~/workspace/backups/kube/kubens -r
cp ~/.kube/kubens ~/workspace/backups/kube/kubens -r
cp ~/.kube/configs/ ~/workspace/backups/kube/ -r

echo "Backup Preparation successful!"
