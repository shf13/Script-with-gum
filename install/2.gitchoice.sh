#!/bin/bash

echo "$(gum style --foreground 85 "Do you want to customize git? ")"
git_choices=("Yes" "No" )
CHOICES_git=$(gum choose "${git_choices[@]}" --no-limit --height 6 --header "Use SPACE to select, ENTER to confirm" | tr '\n' ',' | sed 's/,$//' )

IFS=',' read -ra SELECTED_ARRAY_gitt <<< "$CHOICES_git"

for option in "${SELECTED_ARRAY_gitt[@]}"; do
    case "$option" in
        "Yes")
            source ./terminal/gitgum.sh
            ;;
        "No")
            echo "okay"
            ;;
    esac
    echo
done