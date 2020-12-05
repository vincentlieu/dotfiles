#! /bin/bash

if [ "${PWD##*/}" != "dotfiles" ]; then
    echo "[ WARN ] Run this script from inside the dotfiles directory"
    exit
fi

echo "[ INFO ] Updating submodules before installation begins"
git submodule update --init --recursive

echo "[ INFO ] Starting installation"

source $(pwd)/scripts/brew.sh
source $(pwd)/scripts/fonts.sh
source $(pwd)/scripts/terminal.sh
source $(pwd)/scripts/links.sh

echo "[ INFO ] Configuring .nvm"
mkdir ~/.nvm
ln -s $(pwd)/default-packages ~/.nvm/default-packages

echo "[ INFO ] Applying fast-syntax-highlighting theme"
fast-theme $(pwd)/fsh-zsh.ini

echo "[ INFO ] Finished installation!"
