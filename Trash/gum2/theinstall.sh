#!/bin/bash

## Install FUNCTIONS
# Aliasses
add_aliases() {
    gum spin --spinner dot --title "Adding the aliases..." -- sleep 1
    cat ./dotfile/bash_aliases >> ~/.bashrc
    source ~/.bashrc
    gum style --foreground 85 "✓ Done successfully"
}

# Installation functions for CLI
install_ranger() {
    gum spin --spinner dot --title "Installing ranger..." -- sleep 1
    sudo apt-get install ranger -y
    gum style --foreground 85 "✓ Docker installed successfully"
}

install_eza() {
    gum spin --spinner line --title "Installing exa..." -- sleep 1.5
    sudo apt-get install eza -y
    gum style --foreground 85 "✓ exa installed successfully"
}

install_duf() {
    gum spin --spinner minidot --title "Installing duf..." -- sleep 1
    sudo apt install duf -y
    gum style --foreground 85 "✓ Obsidian installed successfully"
}

install_ncdu() {
    gum spin --spinner jump --title "Deploying Docker Container..." -- sleep 1
	sudo apt install ncdu -y
    gum style --foreground 85 "✓ Docker container deployed successfully"
}


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


install_lazydocker() {
    gum spin --spinner dot --title "Installing lazydocker..." -- sleep 1
    bash ./TUIs/lazydocker.sh
    gum style --foreground 85 "✓ lazydocker installed successfully"
}

install_lazygit() {
    gum spin --spinner line --title "Installing lazygit..." -- sleep 1.5
    bash ./TUIs/lazygit.sh
    gum style --foreground 85 "✓ lazygit installed successfully"
}

install_lazyvim() {
    gum spin --spinner line --title "Installing lazyvim..." -- sleep 1.5
    bash ./TUIs/neovim/install-neovim.sh
    gum style --foreground 85 "✓ lazyvim installed successfully"
}




# Process each selected option

for bash in "${CHOICES_Aliases}"; do
    case "$bash" in
        "Yas")
            add_aliases
            ;;
        "No")
            exit 0
            ;;
    esac
    echo
done

##############



# Process each selected option

for cli in "${CHOICES_CLI}"; do
    case "$cli" in
        "ranger")
            install_ranger
            ;;
        "eza")
            install_eza
            ;;
        "duf")
            install_duf
            ;;
        "ncdu")
            install_ncdu
            ;;
    esac
    echo
done

###########



# Process each selected option

for service in "${CHOICES_services}"; do
    case "$service" in
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




##################


# Process each selected option

for TUI in "${CHOICES_TUIs}"; do
    case "$TUI" in
        "lazydocker")
            install_lazydocker
            ;;
        "lazygit")
            install_lazygit
            ;;
        "lazyvim")
            install_lazyvim
            ;;
    esac
    echo
done

# Completion message
gum style --foreground 212 --border-foreground 212 --border double --align center --width 50 --margin "1 2" --padding "2 4" \
"INSTALLATION COMPLETE" "Selected operations finished successfully!"


# Final prompt
echo
gum style --foreground 85 "Press any key to continue..."
gum input --placeholder "Press Enter to exit"






