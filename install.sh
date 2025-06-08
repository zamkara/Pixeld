#!/bin/bash
set -e

REPO_RAW_URL="https://gist.githubusercontent.com/zamkara/9d889924821048b0f746867be202a0ec/raw/59001ecd3a843e04c453d0a8d80b3ab808d6dc08/pixel"
INSTALL_PATH="/usr/local/bin/pixel"

if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$REPO_RAW_URL" -o /tmp/pixel
elif command -v wget >/dev/null 2>&1; then
    wget -q "$REPO_RAW_URL" -O /tmp/pixel
else
    echo "curl or wget required"
    exit 1
fi

sudo mv /tmp/pixel "$INSTALL_PATH"
sudo chmod +x "$INSTALL_PATH"

read -p "Enter your PixelDrain API Key: " API_KEY

SHELL_NAME=$(basename "$SHELL")
case "$SHELL_NAME" in
    bash)
        echo "export PIXEL_API_KEY=$API_KEY" >> "$HOME/.bashrc"
        ;;
    zsh)
        echo "export PIXEL_API_KEY=$API_KEY" >> "$HOME/.zshrc"
        ;;
    fish)
        fish --command "set -Ux PIXEL_API_KEY $API_KEY"
        ;;
    *)
        echo "export PIXEL_API_KEY=$API_KEY" >> "$HOME/.profile"
        ;;
esac

echo
echo "pixeld installed. Usage:"
echo "  pixel upload yourfile.txt"
echo "  pixel download <id> output.txt"
echo "  pixel info <id>"
echo "  pixel purge"
