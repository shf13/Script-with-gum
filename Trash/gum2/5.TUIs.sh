#!/bin/bash

AVAILABLE_OPTIONS_TUIs=("lazydocker" "lazygit" "lazyvim" )
SELECTED_OPTIONS_TUIs="ranger"  # Default selection


# Let user choose multiple options
echo "$(gum style --foreground 85 "Select the TUIs you want to install:")"
export CHOICES_TUIs=$(gum choose "${AVAILABLE_OPTIONS_TUIs[@]}" --no-limit --selected "$SELECTED_OPTIONS_TUIs" --height 6 --header "Use SPACE to select, ENTER to confirm")


