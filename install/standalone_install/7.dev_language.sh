#!/bin/bash

AVAILABLE_OPTIONS_language=("python" "UV.python" )
SELECTED_OPTIONS_CLI="python"  # Default selection


# Let user choose multiple options
echo "$(gum style --foreground 85 "Select the languages you want to install:")"
export CHOICES_lan=$(gum choose "${AVAILABLE_OPTIONS_language[@]}" --no-limit --selected "$SELECTED_OPTIONS_CLI" --height 6 --header "Use SPACE to select, ENTER to confirm" | tr '\n' ',' | sed 's/,$//' )

## We need to take the choices in the variable and create an array, then the arraay is pass through 
# IFS=',' read -ra SELECTED_ARRAY_lan <<< "$CHOICES_lan"

python_install () {
    gum spin --spinner dot --title "Installing Python..." -- sleep 1
    sudo apt install python3 -y
    gum style --foreground 85 "✓ Python installed successfully"
}

python_uv_install () {
    gum spin --spinner dot --title "Installing uv..." -- sleep 1
    curl -LsSf https://astral.sh/uv/install.sh | sh
    gum style --foreground 85 "✓ uv installed successfully"
}


IFS=',' read -ra SELECTED_ARRAY_lan <<< "$CHOICES_lan"

for option in "${SELECTED_ARRAY_lan[@]}"; do
    case "$option" in
        "python")
            python_install
            ;;
        "UV.python")
            python_uv_install
            ;;
    esac
    echo
done

