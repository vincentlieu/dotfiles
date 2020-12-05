#! /bin/bash

# Install Homebrew
if ! [ -x "$(which brew)" ]; then
    echo "[ INFO ] Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "[ INFO ] Homebrew already installed. Updating..."
    brew update
    brew upgrade
fi

echo "[ INFO ] Turning off homebrew analytics"
brew analytics off
export HOMEBREW_NO_ANALYTICS=1

echo "[ INFO ] Installing the good stuff"
brew bundle --file $(pwd)/Brewfile --verbose

echo "[ INFO ] Cleaning up"
brew cleanup
