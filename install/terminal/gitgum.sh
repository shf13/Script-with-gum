#!/bin/bash

sudo apt install -y curl git
################
gum style \
	--foreground 117 --border-foreground 250 --border normal \
	--align center --width 50 --margin "1 2" --padding "2 4" --bold \
	'Setting up git'

gum style --foreground 212 --border-foreground 212 --border double --align center --faint --width 50 --margin "1 2" --padding "2 4" \
"Setting up git user and email" "Making main as the defualt branch"
################

# Set git defaults
### To make "main" as the default branch main instead of "master"
git config --global init.defaultBranch main



# Set git user, email, and ssh key.
echo "Enter identification for git and autocomplete..."
SYSTEM_NAME=$(getent passwd "$USER" | cut -d ':' -f 5 | cut -d ',' -f 1)
export git_USER_NAME=$(gum input --placeholder "Enter full name" --value "$SYSTEM_NAME" --prompt "Name> ")
export git_USER_EMAIL=$(gum input --placeholder "Enter email address" --prompt "Email> ")


# Set identification from install inputs
# this makes sure that the varibale isn't just empty space ↴
if [[ -n "${git_USER_NAME//[[:space:]]/}" ]]; then
  git config --global user.name "$git_USER_NAME"
fi

if [[ -n "${git_USER_EMAIL//[[:space:]]/}" ]]; then
  git config --global user.email "$git_USER_EMAIL"
fi



## Creating an new SSH key
gum style \
	--foreground 212 \
	--align center --width 50 --margin "1 1" \
	'Creating an new SSH key with the entered email'


cd ~/.ssh/
ssh-keygen -t rsa -b 4096 -C "$git_USER_EMAIL"
cd -


# SSH key
echo "Setting up ssh key for github"

export git_ssh_key=$(gum input --placeholder "Enter the name of the ssh key without file extension for git" --prompt "SSH key name> ")


# Authenticating
eval "$(ssh-agent -s)"

ssh-add ~/.ssh/$git_ssh_key

# To test connection and authentication after adding the key to GitHub
ssh -T git@github.com

# Adding the alias to the shell
if [[ -n "${git_ssh_key//[[:space:]]/}" ]]; then
    echo "alias ssha4='ssh-add ~/.ssh/$git_ssh_key' " >> ~/.bashrc
    echo "alias ssha4='ssh-add ~/.ssh/$git_ssh_key' " >> ~/.config/fish/config.fish
fi

ssh-add -l

sleep 0.5



if [ $? -ne 0 ]
then
        echo "there was an error"
fi