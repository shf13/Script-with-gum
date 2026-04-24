#!/bin/bash
# Update, setup ssh key RU, Setting up UFW and adding ssh port, then installing Docker 

AVAILABLE_OPTIONS_services=("Docker" "Adding SSH key" "UFW" "Ollama" "Recursive Nerd Font" "Homebrew" )
SELECTED_OPTIONS_services="Adding SSH key"  # Default selection


# Let user choose multiple options
echo "$(gum style --foreground 85 "Select what you want to install:")"
export CHOICES_services=$(gum choose "${AVAILABLE_OPTIONS_services[@]}" --no-limit --selected "$SELECTED_OPTIONS_services" --height 6 --header "Use SPACE to select, ENTER to confirm" | tr '\n' ',' | sed 's/,$//' )



# Installation functions for_services
install_docker() {
    gum spin --spinner dot --title "Installing Docker..." -- sleep 0.2
    sleep 0.5
    sudo apt-get update

    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc


    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update 

    echo "----installing docker and docker compose....------"
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

    echo "----adding the user to the docker group---------"
    sudo usermod -aG docker $USER

    sudo docker ps
    
    gum style --foreground 85 "✓ Docker installed successfully"
}

add_ssh_key() {
    gum spin --spinner line --title "Adding the ssh key..." -- sleep 0.2
    echo "---------------"
    echo "Adding the ru ssh key."
    echo "---------------"

    if [ -d ~/home/$USER/.ssh ]; then 
        echo "the directory ~/.ssh exist"
    else
        mkdir -p /home/$USER/.ssh
    fi

    # echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDTras3SvxFMaP7cMj2SpMx3/o0JcwuAvvFeb3Hd+Bs7yqvXQyIhqwg3RXmDdfSelMRzBNmcYg2bzyG7uMfO/48QuKQqpnx5iuNU6XbbL434XwpeN6nQd2vG6rrBEHEiOECXW/ENzk3yrqROFXyDn/O4Hz1k3jH9L0JGfKDwdfQlOykkN3yl4EQind7UF1QNkgiArvLeF9bAb6zkYyQpoB2WM1fhhWDVwpYs8yyg8/nNGUNAXLx2+CbsLqPGP70W9lhKgoFi8tjOCetMYnxfy71Q3dRynOTfQqEhuVeq/Qurxw4FTPmj6xOg+p8yzewNzaNq6+PcdkPB06EaRGwtlSdeY38/hOl0qL0AAVFi6Cn2MHy3gfTV/LpqOx2HFo66iUV8WXxLBMV9hZKYfJjkhw7Or0ShmpwygumOBF5LNEe9BaBH/Z0cBDkktBH9GewRz7hbLe0mBWrEXky6T0Zakt3bIg/bxTBssJodZR7u0zmGIVUCruDBXoJsT6wzw9VLbAV6kW4jKV0s85gN03vw46rrnOoFWR6TH5mTt8ozz1j40UGUgJ2qi9A3IkPGAcuQJBgdNm4LjlLBtw2SzYnHuo19qUglITd8Drkdun8zvj8KOOVnI/H355+hfFMuN5Pbwr8O/nc/cKMPu7X31nsS02AIAlsq80I9zqOscNBV1ljVw== bakrs@MSI" >> .ssh/authorized_keys
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDTras3SvxFMaP7cMj2SpMx3/o0JcwuAvvFeb3Hd+Bs7yqvXQyIhqwg3RXmDdfSelMRzBNmcYg2bzyG7uMfO/48QuKQqpnx5iuNU6XbbL434XwpeN6nQd2vG6rrBEHEiOECXW/ENzk3yrqROFXyDn/O4Hz1k3jH9L0JGfKDwdfQlOykkN3yl4EQind7UF1QNkgiArvLeF9bAb6zkYyQpoB2WM1fhhWDVwpYs8yyg8/nNGUNAXLx2+CbsLqPGP70W9lhKgoFi8tjOCetMYnxfy71Q3dRynOTfQqEhuVeq/Qurxw4FTPmj6xOg+p8yzewNzaNq6+PcdkPB06EaRGwtlSdeY38/hOl0qL0AAVFi6Cn2MHy3gfTV/LpqOx2HFo66iUV8WXxLBMV9hZKYfJjkhw7Or0ShmpwygumOBF5LNEe9BaBH/Z0cBDkktBH9GewRz7hbLe0mBWrEXky6T0Zakt3bIg/bxTBssJodZR7u0zmGIVUCruDBXoJsT6wzw9VLbAV6kW4jKV0s85gN03vw46rrnOoFWR6TH5mTt8ozz1j40UGUgJ2qi9A3IkPGAcuQJBgdNm4LjlLBtw2SzYnHuo19qUglITd8Drkdun8zvj8KOOVnI/H355+hfFMuN5Pbwr8O/nc/cKMPu7X31nsS02AIAlsq80I9zqOscNBV1ljVw== bakrs@MSI" >> /home/$USER/.ssh/authorized_keys


    gum style --foreground 85 "✓ SSH key was added successfully"
}

setting_up_UFW() {
    gum spin --spinner minidot --title "Installing UFW and setting it up..." -- sleep 1
    echo "---------------"
    echo "checking if ufw is installed or not:"
    echo "..........................."
    which ufw > /dev/null
    if [ $? -gt 0 ]; then
            echo "ufw doesn't exist on the machine"
        echo "I will install ufw"
        sudo apt install ufw -y
    else
        echo "ufw is installed already"
    fi

    echo "Disabling UFW"
    sudo ufw disable

    sleep 0.5

    echo " "
    echo "..........................."
    echo "setting up the firewall with ufw and enabling SSH through ufw"
    echo "You will need to enable ufw manaualling by running sudo ufw enable"

    echo "..........................."


    echo " "
    echo "sudo ufw default allow outgoing"
    sudo ufw default allow outgoing


    echo " "
    echo "sudo ufw default deny incoming"
    sudo ufw default deny incoming

    echo " "
    echo "sudo ufw allow ssh"
    sudo ufw allow ssh

    echo " "
    echo "sudo ufw show added"
    sudo ufw show added

    sleep 0.5
    gum style --foreground 85 "✓ UFW is installed and setup to allow only 22 port but not enable successfully"
}

install_recursive_nerd_font() {
    gum spin --spinner line --title "Installing Recursive Nerd font..." -- sleep 0.2
    wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Recursive.zip \  
    && cd ~/.local/share/fonts \  
    && unzip Recursive.zip \  
    && rm Recursive.zip \  
    && fc-cache -fv
}

install_ollama() {
    gum spin --spinner line --title "Installing Ollama using the curl script from the website << curl -fsSL https://ollama.com/install.sh | sh >>..." -- sleep 0.2
    curl -fsSL https://ollama.com/install.sh | sh
}

install_homebrew() {
    gum spin --spinner line --title "Installing Homebrew using the curl script from the offical website..." -- sleep 0.2
    gum style --foreground 117 --border-foreground 250 --border double --align center --width 50 --margin "1 2" --padding "2 4" 'Installing Homebrew focus which will require manual input during and after the installation'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    gum style --foreground 117  --align center --width 50 --margin "1 2" --padding "2 4" 'Sleep for 5s after installing Homebrew'
    gum spin --spinner dot --title "sleeping...." -- sleep 5
}












IFS=',' read -ra SELECTED_ARRAY_service <<< "$CHOICES_services"

for option in "${SELECTED_ARRAY_service[@]}"; do
    case "$option" in
        "Docker")
            install_docker
            ;;
        "Adding SSH key")
            add_ssh_key
            ;;
        "UFW")
            setting_up_UFW
            ;;
        "Recursive Nerd Font")
            install_recursive_nerd_font
            ;;
        "Ollama")
            install_ollama
            ;;
    esac
    echo
done




