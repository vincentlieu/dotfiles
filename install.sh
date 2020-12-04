#! /bin/bash

if [ "${PWD##*/}" != "dotfiles" ]; then
    echo "[ WARN ] Run this script from inside the dotfiles directory"
    exit
fi

echo "[ INFO ] Updating submodules before installation begins"
git submodule update --init --recursive

echo "[ INFO ] Starting installation"

source $(pwd)/install/brew.sh
source $(pwd)/install/fonts.sh
source $(pwd)/install/terminal.sh
