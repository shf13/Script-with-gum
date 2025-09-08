#!/bin/bash

gum style --foreground 212 --border-foreground 212 --border double --align center --width 50 --margin "1 2" --padding "2 4" \
"SYSTEM SETUP WIZARD" "Choose your installation options"


AVAILABLE_OPTIONS_CLI=("ranger" "eza" "duf" "ncdu")
SELECTED_OPTIONS_CLI="ranger"  # Default selection


# Let user choose multiple options
echo "$(gum style --foreground 85 "Select the CLIs you want to install:")"
export CHOICES_CLI=$(gum choose "${AVAILABLE_OPTIONS_CLI[@]}" --no-limit --selected "$SELECTED_OPTIONS_CLI" --height 6 --header "Use SPACE to select, ENTER to confirm" | tr '\n' ',' | sed 's/,$//' )

