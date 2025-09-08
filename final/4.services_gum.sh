#!/bin/bash
# Update, setup ssh key RU, Setting up UFW and adding ssh port, then installing Docker 

AVAILABLE_OPTIONS_services=("Docker" "Adding SSH key" "UFW" )
SELECTED_OPTIONS_services="Adding SSH key"  # Default selection


# Let user choose multiple options
echo "$(gum style --foreground 85 "Select what you want to install:")"
export CHOICES_services=$(gum choose "${AVAILABLE_OPTIONS_services[@]}" --no-limit --selected "$SELECTED_OPTIONS_services" --height 6 --header "Use SPACE to select, ENTER to confirm" | tr '\n' ',' | sed 's/,$//' )

