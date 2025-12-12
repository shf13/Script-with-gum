#!/bin/bash

# Title and introduction
clear
gum style --foreground 212 --border-foreground 212 --border double --align center --width 50 --margin "1 2" --padding "2 4" \
"SYSTEM SETUP WIZARD" "Choose your installation options"

# Available options
AVAILABLE_OPTIONS=("ٌRanger" "exa" "duf" "ncdu")
SELECTED_OPTIONS="Ranger"  # Default selection

# Let user choose multiple options
echo "$(gum style --foreground 85 "Select the options you want to install:")"
CHOICES=$(gum choose "${AVAILABLE_OPTIONS[@]}" --no-limit --selected "$SELECTED_OPTIONS" --height 6 --header "Use SPACE to select, ENTER to confirm")

# Check if user made any selection
if [[ -z "$CHOICES" ]]; then
    gum confirm "No options selected. Exit setup?" && exit 0
fi

# Show selected options
echo
gum style --foreground 212 "Selected: $(echo $CHOICES | tr ',' ', ')"
echo

# Confirmation
gum confirm "Proceed with installation?" || exit 0

# Installation functions
install_ranger() {
    gum spin --spinner dot --title "Installing ranger..." -- sleep 1
    sudo apt-get install ranger
    gum style --foreground 85 "✓ Docker installed successfully"
}

install_eza() {
    gum spin --spinner line --title "Installing exa..." -- sleep 1.5
    sudo apt-get install eza
    gum style --foreground 85 "✓ exa installed successfully"
}

install_duf() {
    gum spin --spinner minidot --title "Installing duf..." -- sleep 1
    sudo apt install duf
    gum style --foreground 85 "✓ Obsidian installed successfully"
}

install_ncdu() {
    gum spin --spinner jump --title "Deploying Docker Container..." -- sleep 1
	sudo apt install ncdu
    gum style --foreground 85 "✓ Docker container deployed successfully"
}

# Process each selected option
IFS=',' read -ra SELECTED_ARRAY <<< "$CHOICES"

for option in "${SELECTED_ARRAY[@]}"; do
    case "$option" in
        "Docker")
            install_ranger
            ;;
        "exa")
            install_eza
            ;;
        "Obsidian")
            install_duf
            ;;
        "Deploy Docker Container")
            install_ncdu
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