#! /bin/bash

if [ "${PWD##*/}" != "dotfiles" ]; then
    echo "[ WARN ] Run this script from inside the dotfiles directory"
    exit
fi

echo "[ INFO ] Creating symlink"
rm ~/.zshrc
ln -s $(pwd)/.zshrc ~/.zshrc
ln -s $(pwd)/.zshrc_aliases ~/.zshrc_aliases
ln -s $(pwd)/.spaceship_config ~/.spaceship_config
ln -s $(pwd)/.gitconfig ~/.gitconfig
ln -s $(pwd)/.gitconfig_global ~/.gitconfig_global
ln -s $(pwd)/.vimrc ~/.vimrc
