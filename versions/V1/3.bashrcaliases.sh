#!/bin/bash

# gum style --foreground 212 --border-foreground 212 --border double --align center --width 50 --margin "1 2" --padding "2 4" \
# "SYSTEM SETUP WIZARD" "Choose your installation options"


AVAILABLE_OPTIONS_Aliases=("Yes" "No")
SELECTED_OPTIONS_Aliases="Yes"  # Default selection


# Let user choose multiple options
echo "$(gum style --foreground 85 "Do you want to add the peronalized aliases to your bashrc file?")"
CHOICES_Aliases=$(gum choose "${AVAILABLE_OPTIONS_Aliases[@]}" --no-limit --selected "$SELECTED_OPTIONS_Aliases" --height 6 --header "Use SPACE to select, ENTER to confirm")

# Check if user made any selection
if [[ -z "$CHOICES_Aliases" ]]; then
    gum confirm "No options selected. Exit setup?" && exit 0
fi

# Show selected options
echo
gum style --foreground 212 "Selected: $(echo $CHOICES_Aliases | tr ',' ', ')"
echo

# Confirmation
gum confirm "Proceed with installation?" || exit 0


# Installation functions for
add_aliases() {
    gum spin --spinner dot --title "Adding the aliases..." -- sleep 1
    cat ./dotfile/bash_aliases >> ~/.bashrc
    gum style --foreground 85 "✓ Done successfully"
}

# Process each selected option
## split a comma-separated string into an array
IFS=',' read -ra SELECTED_ARRAY_Aliases <<< "$CHOICES_Aliases"

for option in "${SELECTED_ARRAY_Aliases[@]}"; do
    case "$option" in
        "Yas")
            add_aliases
            ;;
        "No")
            exit 0
            ;;
    esac
    echo
done

