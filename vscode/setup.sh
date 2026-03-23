#!/bin/bash
# Install VS Code extensions and link settings

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"

# Install extensions
echo "Installing VS Code extensions..."
while IFS= read -r ext; do
    code --install-extension "$ext" --force
done < "$SCRIPT_DIR/extensions.txt"

# Link settings
echo "Linking VS Code settings..."
if [ -f "$VSCODE_USER_DIR/settings.json" ]; then
    mv "$VSCODE_USER_DIR/settings.json" "$VSCODE_USER_DIR/settings.json.bak"
    echo "Backed up existing settings to settings.json.bak"
fi
ln -sf "$SCRIPT_DIR/settings.json" "$VSCODE_USER_DIR/settings.json"

echo "VS Code setup complete."
