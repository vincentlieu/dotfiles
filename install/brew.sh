#! /bin/bash

# Install Homebrew
if ! [ -x "$(which brew)" ]; then
    echo "[ INFO ] Homebrew not found. Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    echo "[ INFO ] Homebrew already installed. Updating..."
    brew update
    brew upgrade
fi

echo "[ INFO ] Turning off homebrew analytics"
brew analytics off
export HOMEBREW_NO_ANALYTICS=1

echo "[ INFO ] Installing the good stuff"
brew bundle --file $(pwd)/Brewfile

echo "[ INFO ] Cleaning up"
brew cleanup
