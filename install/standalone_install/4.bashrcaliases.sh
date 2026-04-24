#!/bin/bash

# gum style --foreground 212 --border-foreground 212 --border double --align center --width 50 --margin "1 2" --padding "2 4" \
# "SYSTEM SETUP WIZARD" "Choose your installation options"


AVAILABLE_OPTIONS_Aliases=("BASH" "Fish" "Vim")
SELECTED_OPTIONS_Aliases="BASH"  # Default selection


# Let user choose multiple options
echo "$(gum style --foreground 85 "Do you want to add the peronalized aliases to your shell/vim?")"
export CHOICES_Aliases=$(gum choose "${AVAILABLE_OPTIONS_Aliases[@]}" --no-limit --selected "$SELECTED_OPTIONS_Aliases" --height 6 --header "Use SPACE to select, ENTER to confirm" | tr '\n' ',' | sed 's/,$//' )

# Installation functions for Aliases
add_bash_aliases() {
    gum spin --spinner dot --title "Adding the aliases..." -- sleep 1
    cat ./dotfiles/bash_aliases >> ~/.bashrc
    cd ~
    sleep 0.5
    source ~/.bashrc
    cd -
    gum style --foreground 85 "✓ Done successfully"
}

add_fish_aliases() {
    gum spin --spinner dot --title "Adding the aliases..." -- sleep 1
    cat ./dotfiles/fish_aliases >> ~/.config/fish/config.fish
    source ~/.config/fish/config.fish
    gum style --foreground 85 "✓ Done successfully"
}

add_vim_config() {
    gum spin --spinner dot --title "Adding the vim shortcuts..." -- sleep 1
    if [ -f ~/.vimrc ]; then
        cat ./vimconfig >> ~/.vimrc
    else
        touch ~/.vimrc
        cat ./dotfiles/vimconfig >> ~/.vimrc
    fi  
    gum style --foreground 85 "✓ Done successfully"
}



IFS=',' read -ra SELECTED_ARRAY_Aliases <<< "$CHOICES_Aliases"

for option in "${SELECTED_ARRAY_Aliases[@]}"; do
    case "$option" in
        "BASH")
            add_bash_aliases
            ;;
        "Fish")
            add_fish_aliases
            ;;
        "Vim")
            add_vim_config
            ;;
    esac
    echo
done

