#!/bin/bash

gum style --foreground 212 --border-foreground 212 --border double --align center --width 50 --margin "1 2" --padding "2 4" \
"SYSTEM SETUP WIZARD" "Choose your installation options"


AVAILABLE_OPTIONS_CLI=("ranger" "eza" "duf" "ncdu")
SELECTED_OPTIONS_CLI="ranger"  # Default selection


# Let user choose multiple options
echo "$(gum style --foreground 85 "Select the CLIs you want to install:")"
export CHOICES_CLI=$(gum choose "${AVAILABLE_OPTIONS_CLI[@]}" --no-limit --selected "$SELECTED_OPTIONS_CLI" --height 6 --header "Use SPACE to select, ENTER to confirm" | tr '\n' ',' | sed 's/,$//' )


# Installation functions for CLI
install_ranger() {
    gum spin --spinner dot --title "Installing ranger..." -- sleep 0.2
    sudo apt-get install ranger -y
    gum style --foreground 85 "✓ ranger installed successfully"
}

install_eza() {
    gum spin --spinner line --title "Installing eza..." -- sleep 0.2
    sudo apt-get install eza -y
    gum style --foreground 85 "✓ eza installed successfully"
}

install_duf() {
    gum spin --spinner minidot --title "Installing duf..." -- sleep 0.2
    sudo apt install duf -y
    gum style --foreground 85 "✓ duf installed successfully"
}

install_ncdu() {
    gum spin --spinner jump --title "Installing ncdu Container..." -- sleep 0.2
	sudo apt install ncdu -y
    gum style --foreground 85 "✓ ncdu installed successfully"
}

# --------------------------------

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


