AVAILABLE_OPTIONS_CLI=("ranger" "eza" "duf" "ncdu")
SELECTED_OPTIONS_CLI="ranger"  # Default selection


# Let user choose multiple options
echo "$(gum style --foreground 85 "Select the CLIs you want to install:")"
# CHOICES_CLI=$(gum choose "${AVAILABLE_OPTIONS_CLI[@]}" --no-limit --height 6 --header "Use SPACE to select, ENTER to confirm" | tr '\n' ',' )
CHOICES_CLI=$(gum choose "${AVAILABLE_OPTIONS_CLI[@]}" --no-limit --height 6 --header "Use SPACE to select, ENTER to confirm"  )

echo $CHOICES_CLI


echo
gum style --foreground 212 "Selected: $(echo $CHOICES_CLI | tr ',' ', ')"
echo

echo $CHOICES_CLI


for ss in ${CHOICES_CLI}; do
    case "$ss" in
        "ranger")
            echo "ranger"
            ;;
        "eza")
            echo "ezsdfsdfsdfsdsa"
            ;;
        "duf")
            echo "asdsdfssa"
            ;;
        "ncdu")
            echo "asasdasddsa"
            ;;
    esac
done