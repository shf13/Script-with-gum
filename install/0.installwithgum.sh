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
source ./2.gitchoice.sh
source ./3.New_CLI_gum.sh
source ./4.bashrcaliases.sh
source ./5.TUIs.sh
source ./6.services_gum.sh
source ./7.dev_language.sh
source ./8.theinstall.sh
source ./9.log.sh

sleep 0.5
source $HOME/.local/bin/env

sleep 0.5
sudo apt upgrade -y



# Final prompt
echo
gum style --foreground 85 "Press any key to continue..."
gum input --placeholder "Press Enter to exit"

