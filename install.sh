#! /bin/bash

echo "Installing dotfiles..."

echo "Updating submodules..."
git submodule update --init --recursive

# source $(pwd)/install/brew.sh
source $(pwd)/install/fonts.sh
source $(pwd)/install/oh-my-zsh.sh
