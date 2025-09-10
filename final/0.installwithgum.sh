#!/bin/bash

RED_COLOR () {
    echo -e "\033[0;31m $1"
}

RED_COLOR "██████  ██░ ██   █████▒     ██████  ▄████▄   ██▀███   ██▓ ██▓███  ▄▄▄█████▓
▒██    ▒ ▓██░ ██▒▓██   ▒    ▒██    ▒ ▒██▀ ▀█  ▓██ ▒ ██▒▓██▒▓██░  ██▒▓  ██▒ ▓▒
░ ▓██▄   ▒██▀▀██░▒████ ░    ░ ▓██▄   ▒▓█    ▄ ▓██ ░▄█ ▒▒██▒▓██░ ██▓▒▒ ▓██░ ▒░
  ▒   ██▒░▓█ ░██ ░▓█▒  ░      ▒   ██▒▒▓▓▄ ▄██▒▒██▀▀█▄  ░██░▒██▄█▓▒ ▒░ ▓██▓ ░ 
▒██████▒▒░▓█▒░██▓░▒█░       ▒██████▒▒▒ ▓███▀ ░░██▓ ▒██▒░██░▒██▒ ░  ░  ▒██▒ ░ 
▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒ ▒ ░       ▒ ▒▓▒ ▒ ░░ ░▒ ▒  ░░ ▒▓ ░▒▓░░▓  ▒▓▒░ ░  ░  ▒ ░░   
░ ░▒  ░ ░ ▒ ░▒░ ░ ░         ░ ░▒  ░ ░  ░  ▒     ░▒ ░ ▒░ ▒ ░░▒ ░         ░    
░  ░  ░   ░  ░░ ░ ░ ░       ░  ░  ░  ░          ░░   ░  ▒ ░░░         ░      
      ░   ░  ░  ░                 ░  ░ ░         ░      ░                    
                                     ░                                       "



sudo apt update 
sudo apt install curl wget -y

echo "$(gum style --foreground 85 "Do you want to customize git? ")"
git_choices=("Yes" "No" )
CHOICES_git=$(gum choose "${git_choices[@]}" --no-limit --height 6 --header "Use SPACE to select, ENTER to confirm" | tr '\n' ',' | sed 's/,$//' )

IFS=',' read -ra SELECTED_ARRAY_gitt <<< "$CHOICES_git"

for option in "${SELECTED_ARRAY_gitt[@]}"; do
    case "$option" in
        "Yas")
            source ./gitgum.sh
            ;;
        "No")
            echo "okay"
            ;;
    esac
    echo
done





source ./1.guminstall.sh
source ./2.New_CLI_gum.sh
source ./3.bashrcaliases.sh
source ./4.services_gum.sh
source ./5.TUIs.sh
source ./6.theinstall.sh

sudo upgrade -y




