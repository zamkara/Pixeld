#!/bin/bash

set -e

REPO_RAW_URL="https://gist.githubusercontent.com/zamkara/9d889924821048b0f746867be202a0ec/raw/59001ecd3a843e04c453d0a8d80b3ab808d6dc08/pixel"
INSTALL_PATH="/usr/local/bin/pixel"

echo "Installing pixel CLI tool..."

# Check for curl or wget
if command -v curl >/dev/null 2>&1; then
    echo "Downloading pixel CLI from $REPO_RAW_URL..."
    curl -fsSL "$REPO_RAW_URL" -o /tmp/pixel
elif command -v wget >/dev/null 2>&1; then
    echo "Downloading pixel CLI from $REPO_RAW_URL..."
    wget -q "$REPO_RAW_URL" -O /tmp/pixel
else
    echo "Error: curl or wget is required to download pixel."
    exit 1
fi

echo "Moving to $INSTALL_PATH and setting executable permissions..."
sudo mv /tmp/pixel "$INSTALL_PATH"
sudo chmod +x "$INSTALL_PATH"

echo
read -p "Enter your PixelDrain API Key: " API_KEY
echo

echo "Setting API key for your shell..."

SHELL_NAME=$(basename "$SHELL")

case "$SHELL_NAME" in
    bash)
        PROFILE="$HOME/.bashrc"
        ;;
    zsh)
        PROFILE="$HOME/.zshrc"
        ;;
    fish)
        fish --command "set -Ux PIXEL_API_KEY $API_KEY"
        PROFILE=""
        ;;
    *)
        echo "Unrecognized shell: $SHELL_NAME"
        echo "Please set your API key manually with:"
        echo "export PIXEL_API_KEY=$API_KEY"
        PROFILE=""
        ;;
esac

if [ -n "$PROFILE" ]; then
    echo "export PIXEL_API_KEY=$API_KEY" >> "$PROFILE"
    echo "API key added to $PROFILE"
    echo "You may need to restart your terminal or run: source $PROFILE"
fi

echo
echo "Installation complete!"

echo "You can now use the pixel command. For example:"
echo "  pixel upload yourfile.txt"
echo "  pixel download <id> output.txt"
echo "  pixel info <id>"
echo "  pixel purge"

echo
echo "For more information and updates, visit:"
echo "https://github.com/zamkara/Pixeld"
