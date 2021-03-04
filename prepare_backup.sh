#!/bin/bash
echo "Preparing backup"
echo "copying dotfiles"
cp ~/.zshrc ~/workspace/dotfiles/zsh/zshrc
cp ~/.bash_aliases ~/workspace/dotfiles/zsh/bash_aliases
cp ~/.Xresources ~/workspace/dotfiles/Xresources/Xresources
cp ~/.vimrc ~/workspace/dotfiles/vim/vimrc
cp -r ~/.config/nvim/ ~/workspace/dotfiles/
cp ~/.config/i3/* ~/workspace/dotfiles/i3/ -r
cp ~/.config/picom/picom.conf ~/workspace/dotfiles/picom/picom.conf
cp ~/.config/kitty/kitty.conf ~/workspace/dotfiles/kitty/kitty.conf
cp ~/.config/polybar/ ~/workspace/dotfiles/polybar -r

echo "copying zsh history"
cp ~/.zsh_history ~/workspace/backups/zsh/zsh_history

echo "private stuff"
echo "copying private bash_aliases"
cp ~/.bash_aliases_private ~/workspace/backups/zsh/bash_aliases_private
echo "commiting notes to git"
notes commit
echo "Copying taskwarrior tasks and keys"
cp -r ~/.task/* ~/workspace/backups/taskwarrior/task/
cp  ~/.taskrc ~/workspace/backups/taskwarrior/taskrc

echo "copying ssh"
cp ~/.ssh/config ~/workspace/backups/ssh/
cp ~/.ssh/authorized_keys ~/workspace/backups/ssh/
cp ~/.ssh/known_hosts ~/workspace/backups/ssh/

echo "copying kubernetes config"
cp ~/.kube/config ~/workspace/backups/kube/config
cp ~/.kube/kubectx ~/workspace/backups/kube/kubectx
cp ~/.kube/kubens ~/workspace/backups/kube/kubens -r

echo "Syncing taskwarrior with freecinc"
task sync

echo "Backup Preparation successful!"
