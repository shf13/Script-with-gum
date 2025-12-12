#!/bin/bash
# Update, setup ssh key RU, Setting up UFW and adding ssh port, then installing Docker 

AVAILABLE_OPTIONS_services=("docker" "Adding SSH key" "UFW" )
SELECTED_OPTIONS_services="Adding SSH key"  # Default selection


# Let user choose multiple options
echo "$(gum style --foreground 85 "Select what you want to install:")"
CHOICES_services=$(gum choose "${AVAILABLE_OPTIONS_services[@]}" --no-limit --selected "$SELECTED_OPTIONS_services" --height 6 --header "Use SPACE to select, ENTER to confirm")

# Check if user made any selection
if [[ -z "$CHOICES_services" ]]; then
    gum confirm "No options selected. Exit setup?" && exit 0
fi

# Show selected options
echo
gum style --foreground 212 "Selected: $(echo $CHOICES_services | tr ',' ', ')"
echo

# Confirmation
gum confirm "Proceed with installation?" || exit 0


# Installation functions for_services
install_docker() {
    gum spin --spinner dot --title "Installing ranger..." -- sleep 1
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
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    echo "----adding the user to the docker group---------"
    sudo usermod -aG docker $USER

    sudo docker ps
    
    gum style --foreground 85 "✓ Docker installed successfully"
}

add_ssh_key() {
    gum spin --spinner line --title "Adding the ssh key..." -- sleep 1.5
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
    gum style --foreground 85 "✓ Obsidian installed successfully"
}


# Process each selected option
## split a comma-separated string into an array
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
    esac
    echo
done










