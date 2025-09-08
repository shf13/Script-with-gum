#!/bin/bash

gum style --foreground 212 --border-foreground 212 --border double --align center --width 50 --margin "1 2" --padding "2 4" \
"SYSTEM SETUP WIZARD" "Choose your installation options"


AVAILABLE_OPTIONS_CLI=("ranger" "eza" "duf" "ncdu")
SELECTED_OPTIONS_CLI="ranger"  # Default selection


# Let user choose multiple options
echo "$(gum style --foreground 85 "Select the CLIs you want to install:")"
CHOICES_CLI=$(gum choose "${AVAILABLE_OPTIONS_CLI[@]}" --no-limit --selected "$SELECTED_OPTIONS_CLI" --height 6 --header "Use SPACE to select, ENTER to confirm" | tr '\n' ',' | sed 's/,$//' )

# Check if user made any selection
if [[ -z "$CHOICES_CLI" ]]; then
    gum confirm "No options selected. Exit setup?" && exit 0
fi

# Show selected options
echo
gum style --foreground 212 "Selected: $(echo $CHOICES_CLI | tr ',' ', ')"
echo

# Confirmation
gum confirm "Proceed with installation?" || exit 0


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


# Process each selected option
## split a comma-separated string into an array
IFS=',' read -ra SELECTED_ARRAY_CLI <<< "$CHOICES_CLI"

for option in "${SELECTED_ARRAY_CLI[@]}"; do
    case "$option" in
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

