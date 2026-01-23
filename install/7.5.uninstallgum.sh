#!/bin/bash

AVAILABLE_CHOICES=("Yes" "No" )
SELECTED_CHOICES="Yes"  # Default selection


# Let user choose multiple options
echo "$(gum style --foreground 85 "Do you want to delete gum after finishing the install?")"
export CHOICES_GUM_REMOVAL=$(gum choose "${AVAILABLE_CHOICES[@]}" --no-limit --selected "$SELECTED_CHOICES" --height 6 --header "Use SPACE to select, ENTER to confirm" | tr '\n' ',' | sed 's/,$//' )


