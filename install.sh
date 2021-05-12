#! /bin/bash

if [ "${PWD##*/}" != ".dotfiles" ]; then
    echo "[ WARN ] Run this script from inside the dotfiles directory"
    exit
fi

echo "[ INFO ] Updating submodules before installation begins"
git submodule update --init --recursive

echo "[ INFO ] Starting installation"

if ! [ "$ZSH" ]; then
    echo "[ INFO ] OMZ not found. Installing omz..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    exit
fi

echo "[ INFO ] Configuring iterm2 settings"
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$(pwd)/iterm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

source $(pwd)/scripts/brew.sh
source $(pwd)/scripts/fonts.sh
source $(pwd)/scripts/links.sh
source $(pwd)/scripts/vscode.sh

echo "[ INFO ] Configuring .nvm"

BREW_NVM_BIN="$(brew --prefix nvm)"
NVM_DIR="${HOME}/.nvm/"

if [ -x "$BREW_NVM_BIN" ] && ! [ -d "$NVM_DIR" ]; then
    echo "[ INFO ] Creating .nvm dir --> $NVM_DIR"
    mkdir ${HOME}/.nvm
fi

if [ -d "$NVM_DIR" ]; then
    echo "Creating symlink: default-packages --> $NVM_DIR"
    ln -fs $(pwd)/misc/default-packages $NVM_DIR
    exit
fi

echo "[ INFO ] Finished installation!"
