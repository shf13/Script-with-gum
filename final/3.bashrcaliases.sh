#!/bin/bash

# gum style --foreground 212 --border-foreground 212 --border double --align center --width 50 --margin "1 2" --padding "2 4" \
# "SYSTEM SETUP WIZARD" "Choose your installation options"


AVAILABLE_OPTIONS_Aliases=("BASH" "Fish")
SELECTED_OPTIONS_Aliases="BASH"  # Default selection


# Let user choose multiple options
echo "$(gum style --foreground 85 "Do you want to add the peronalized aliases to your bashrc file?")"
export CHOICES_Aliases=$(gum choose "${AVAILABLE_OPTIONS_Aliases[@]}" --no-limit --selected "$SELECTED_OPTIONS_Aliases" --height 6 --header "Use SPACE to select, ENTER to confirm" | tr '\n' ',' | sed 's/,$//' )

