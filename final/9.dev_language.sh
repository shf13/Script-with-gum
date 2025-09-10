#!/bin/bash

AVAILABLE_OPTIONS_language=("python" "pythonUV" )
SELECTED_OPTIONS_CLI="python"  # Default selection


# Let user choose multiple options
echo "$(gum style --foreground 85 "Select the CLIs you want to install:")"
export CHOICES_lan=$(gum choose "${AVAILABLE_OPTIONS_language[@]}" --no-limit --selected "$SELECTED_OPTIONS_CLI" --height 6 --header "Use SPACE to select, ENTER to confirm" | tr '\n' ',' | sed 's/,$//' )

## We need to take the choices in the variable and create an array, then the arraay is pass through 
IFS=',' read -ra SELECTED_ARRAY_lan <<< "$CHOICES_lan"



python_install () {
    sudo apt install python3 -y
}

python_uv_install () {
    curl -LsSf https://astral.sh/uv/install.sh | sh
}


for option in "${SELECTED_ARRAY_lan[@]}"; do
    case "$option" in
        "python")
            python_install
            ;;
        "pythonUV")
            python_uv_install
            ;;
    esac
    echo
done