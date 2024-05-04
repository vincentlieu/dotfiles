#! /bin/bash

FULL_FILE_PATH=$(find "$HOME/.dotfiles" -type f -name '.*' ! -name '.gitignore' ! -name '.DS_Store')

# Symlink all dot files to the $HOME directory. i.e. .zshrc, .asdfrc etc
function symlink_dotfiles() {
    for filepath in ${FULL_FILE_PATH}; do
        ln -fs "$filepath" "$HOME/$(basename "$filepath")"
    done
}

symlink_dotfiles