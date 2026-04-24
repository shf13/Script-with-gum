#!/bin/bash

AVAILABLE_OPTIONS_TUIs=("lazydocker" "lazygit" "lazyvim" )
SELECTED_OPTIONS_TUIs="ranger"  # Default selection


# Let user choose multiple options
echo "$(gum style --foreground 85 "Select the TUIs you want to install:")"
export CHOICES_TUIs=$(gum choose "${AVAILABLE_OPTIONS_TUIs[@]}" --no-limit --selected "$SELECTED_OPTIONS_TUIs" --height 6 --header "Use SPACE to select, ENTER to confirm" | tr '\n' ',' | sed 's/,$//' )


install_lazydocker() {
    gum spin --spinner dot --title "Installing lazydocker..." -- sleep 0.2
    bash ./TUIs/lazydocker.sh
    gum style --foreground 85 "✓ lazydocker installed successfully"
}

install_lazygit() {
    gum spin --spinner line --title "Installing lazygit..." -- sleep 0.2
    bash ./TUIs/lazygit.sh
    gum style --foreground 85 "✓ lazygit installed successfully"
}

install_lazyvim() {
    gum spin --spinner line --title "Installing lazyvim..." -- sleep 0.2
    bash ./TUIs/neovim/install-neovim.sh
    gum style --foreground 85 "✓ lazyvim installed successfully"
}






IFS=',' read -ra SELECTED_ARRAY_TUIs <<< "$CHOICES_TUIs"

for option in "${SELECTED_ARRAY_TUIs[@]}"; do
    case "$option" in
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
