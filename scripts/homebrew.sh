#! /bin/bash

set -euo pipefail

HOMEBREW_BUNDLE_FILE_GLOBAL=$HOME/.dotfiles/homebrew/Brewfile

# Install Homebrew.
function install_homebrew() {
    echo "📦 Installing Homebrew..."
    
    if ! command -v curl &> /dev/null; then
        echo "❌ Error: curl is required but not installed"
        exit 1
    fi
    
    if ! /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
        echo "❌ Error: Failed to install Homebrew"
        exit 1
    fi

    if [[ $(uname -m) == 'arm64' ]]; then
        echo "🍎 Configuring Homebrew for Apple Silicon..."
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    
    echo "✅ Homebrew installed successfully"
}

# Fetch the newest version of Homebrew and all formulae.
function update_homebrew() {
    if ! command -v brew &> /dev/null; then
        echo "❌ Error: brew command not found"
        exit 1
    fi

    echo "🔄 Updating Homebrew..."
    if ! brew update; then
        echo "❌ Error: Failed to update Homebrew"
        exit 1
    fi
    echo "✅ Homebrew updated successfully"
}

# Upgrade outdated casks and outdated, unpinned formulae.
function upgrade_packages() {
    if ! command -v brew &> /dev/null; then
        echo "❌ Error: brew command not found"
        exit 1
    fi

    echo "⬆️  Upgrading packages..."
    if ! brew upgrade; then
        echo "❌ Error: Failed to upgrade packages"
        exit 1
    fi
    echo "✅ Packages upgraded successfully"
}

# Install Homebrew packages.
function install_packages() {
    if ! command -v brew &> /dev/null; then
        echo "❌ Error: brew command not found"
        exit 1
    fi

    if [ ! -f "$HOMEBREW_BUNDLE_FILE_GLOBAL" ]; then
        echo "❌ Error: Unable to find Brewfile at: $HOMEBREW_BUNDLE_FILE_GLOBAL"
        exit 1
    fi

    echo "📦 Installing packages from Brewfile..."
    if ! brew bundle --global --verbose; then
        echo "❌ Error: Failed to install packages from Brewfile"
        exit 1
    fi
    echo "✅ Packages installed successfully"
}

function main() {
    echo "🍺 Starting Homebrew setup..."
    
    if ! command -v brew &> /dev/null; then
        install_homebrew
    else
        echo "ℹ️  Homebrew already installed"
        update_homebrew
    fi

    install_packages
    upgrade_packages
    
    echo "🔧 Configuring Homebrew..."
    brew analytics off
    brew cleanup
    
    echo "🎉 Homebrew setup completed successfully!"
}

main "$@"