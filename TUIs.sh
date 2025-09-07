#!/bin/bash

AVAILABLE_OPTIONS_TUIs=("lazydocker" "lazygit" )
SELECTED_OPTIONS_TUIs="ranger"  # Default selection


# Let user choose multiple options
echo "$(gum style --foreground 85 "Select the TUIs you want to install:")"
CHOICES_TUIs=$(gum choose "${AVAILABLE_OPTIONS_TUIs[@]}" --no-limit --selected "$SELECTED_OPTIONS_TUIs" --height 6 --header "Use SPACE to select, ENTER to confirm")

# Check if user made any selection
if [[ -z "$CHOICES_TUIs" ]]; then
    gum confirm "No options selected. Exit setup?" && exit 0
fi

# Show selected options
echo
gum style --foreground 212 "Selected: $(echo $CHOICES_TUIs | tr ',' ', ')"
echo

# Confirmation
gum confirm "Proceed with installation?" || exit 0


# Installation functions for TUIs
install_lazydocker() {
    gum spin --spinner dot --title "Installing lazydocker..." -- sleep 1
    source ./lazydocker.sh
    gum style --foreground 85 "✓ lazydocker installed successfully"
}

install_lazygit() {
    gum spin --spinner line --title "Installing lazygit..." -- sleep 1.5
    source ./lazygit.sh
    gum style --foreground 85 "✓ lazygit installed successfully"
}


# Process each selected option
## split a comma-separated string into an array
IFS=',' read -ra SELECTED_ARRAY_TUIs <<< "$CHOICES_TUIs"

for option in "${SELECTED_ARRAY_TUIs[@]}"; do
    case "$option" in
        "lazydocker")
            install_lazydocker
            ;;
        "lazygit")
            install_lazygit
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

