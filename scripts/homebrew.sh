#! /bin/bash

HOMEBREW_BUNDLE_FILE_GLOBAL=$HOME/.dotfiles/homebrew/Brewfile

# Install Homebrew.
function install_homebrew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [[ $(uname -m) == 'arm64' ]]; then
        echo "eval $(/opt/homebrew/bin/brew shellenv)" >> "$HOME/.zprofile"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi;

    return
}

# Fetch the newest version of Homebrew and all formulae.
function update_homebrew() {
    if ! command -v brew update &> /dev/null; then
        echo "Cannot run 'brew update'"
        exit
    fi

    brew update
    return
}

# Upgrade outdated casks and outdated, unpinned formulae.
function upgrade_packages() {
    if ! command -v brew upgrade &> /dev/null; then
        echo "Cannot run 'brew upgrade'"
        exit
    fi

    brew upgrade
    return
}

# Install Homebrew packages.
function install_packages() {
    if ! command -v brew bundle &> /dev/null; then
        echo "Cannot run 'brew bundle'"
        exit
    fi

    if [ -f "$HOMEBREW_BUNDLE_FILE_GLOBAL" ]; then
        brew bundle --global --verbose
    else
        echo "Unable to find Brewfile. Skipping package installation."
        echo "PATH: $HOMEBREW_BUNDLE_FILE_GLOBAL"
    fi
    return
}

function main() {
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        install_homebrew
    else
        update_homebrew
    fi

    install_packages
    upgrade_packages
    brew analytics off
    brew cleanup
}

main