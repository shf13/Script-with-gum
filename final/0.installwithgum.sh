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



source ./1.guminstall.sh
source ./8.gitchoice.sh
source ./2.New_CLI_gum.sh
source ./3.bashrcaliases.sh
source ./4.services_gum.sh
source ./5.TUIs.sh
source ./6.theinstall.sh
source ./9.dev_language.sh
source ./7.log.sh

sudo apt upgrade -y
source $HOME/.local/bin/env


# Final prompt
echo
gum style --foreground 85 "Press any key to continue..."
gum input --placeholder "Press Enter to exit"

