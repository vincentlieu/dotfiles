#!/bin/bash

set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"

echo "🔗 Symlinking dotfiles..."

# Symlink home/* to ~/
stow -v -t "$HOME" -d "$DOTFILES_DIR" home

# Symlink config/* to ~/.config/
mkdir -p "$HOME/.config"
stow -v -t "$HOME/.config" -d "$DOTFILES_DIR" config

echo "✅ Dotfiles symlinked successfully!"
