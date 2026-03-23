#!/bin/bash

# gcloud auth login

rm ~/.zshrc

stow .

echo "## Follow the instructions at https://github.com/tonsky/FiraCode/wiki/VS-Code-Instructions to enable Fira Code in VS Code" \
    | gum format

# shellcheck disable=SC2016
echo '## Execute `source ~/.zshrc`.' | gum format
