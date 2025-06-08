#!/bin/bash

set -e

REPO_RAW_URL="https://gist.githubusercontent.com/zamkara/9d889924821048b0f746867be202a0ec/raw/59001ecd3a843e04c453d0a8d80b3ab808d6dc08/pixel"
INSTALL_PATH="/usr/local/bin/pixel"

echo "==> Installing Pixeld CLI tool..."

# Check for curl or wget
if command -v curl >/dev/null 2>&1; then
    echo "==> Downloading CLI from $REPO_RAW_URL..."
    curl -fsSL "$REPO_RAW_URL" -o /tmp/pixel
elif command -v wget >/dev/null 2>&1; then
    echo "==> Downloading CLI from $REPO_RAW_URL..."
    wget -q "$REPO_RAW_URL" -O /tmp/pixel
else
    echo "Error: curl or wget is required to install Pixeld."
    exit 1
fi

echo "==> Moving binary to $INSTALL_PATH and setting executable permission..."
sudo mv /tmp/pixel "$INSTALL_PATH"
sudo chmod +x "$INSTALL_PATH"

echo
read -p "Enter your PixelDrain API Key: " API_KEY
echo

echo "==> Configuring API key for your shell environment..."

SHELL_NAME=$(basename "$SHELL")

case "$SHELL_NAME" in
    bash)
        PROFILE="$HOME/.bashrc"
        echo "export PIXEL_API_KEY=$API_KEY" >> "$PROFILE"
        echo "✓ API key added to $PROFILE"
        ;;
    zsh)
        PROFILE="$HOME/.zshrc"
        echo "export PIXEL_API_KEY=$API_KEY" >> "$PROFILE"
        echo "✓ API key added to $PROFILE"
        ;;
    fish)
        fish --command "set -Ux PIXEL_API_KEY $API_KEY"
        echo "✓ API key set as universal variable for fish shell"
        ;;
    *)
        echo "⚠ Unrecognized shell: $SHELL_NAME"
        echo "Please set your API key manually:"
        echo "export PIXEL_API_KEY=$API_KEY"
        ;;
esac

echo
echo "✅ Installation complete!"

echo
echo "To start using Pixeld, try the following commands:"
echo "  pixel upload yourfile.txt"
echo "  pixel download <id> output.txt"
echo "  pixel info <id>"
echo "  pixel purge"

echo
echo "Shell may need to be reloaded. You can run: source ~/.bashrc, ~/.zshrc, etc."
echo "More info at: https://github.com/zamkara/Pixeld"
