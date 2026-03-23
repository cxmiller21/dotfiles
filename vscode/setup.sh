#!/bin/bash
# Install VS Code extensions and link settings

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"

if ! command -v code &>/dev/null; then
    echo "Error: 'code' CLI not found. Install VS Code and enable the shell command first."
    exit 1
fi

if [ ! -r "$SCRIPT_DIR/extensions.txt" ]; then
    echo "Error: extensions.txt not found or unreadable at $SCRIPT_DIR/extensions.txt"
    exit 1
fi

# Install extensions
echo "Installing VS Code extensions..."
while IFS= read -r ext; do
    code --install-extension "$ext" --force
done < "$SCRIPT_DIR/extensions.txt"

# Link settings
echo "Linking VS Code settings..."
mkdir -p "$VSCODE_USER_DIR"
if [ -f "$VSCODE_USER_DIR/settings.json" ]; then
    BACKUP="$VSCODE_USER_DIR/settings.json.bak.$(date +%Y%m%d%H%M%S)"
    mv "$VSCODE_USER_DIR/settings.json" "$BACKUP"
    echo "Backed up existing settings to $BACKUP"
fi
ln -sf "$SCRIPT_DIR/settings.json" "$VSCODE_USER_DIR/settings.json"

echo "VS Code setup complete."
