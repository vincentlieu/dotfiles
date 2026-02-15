#!/bin/bash

set -euo pipefail

TOOL_VERSIONS_FILE="${HOME}/.dotfiles/mise/.tool-versions"

# Function to get latest stable Node.js LTS version
get_nodejs_version() {
    echo "Checking latest Node.js LTS version..."
    local version
    version=$(curl -s https://nodejs.org/dist/index.json | jq -r '[.[] | select(.lts != false)] | .[0].version' | sed 's/^v//')
    echo "Latest Node.js LTS: $version"
    echo "$version"
}

# Function to get latest stable Python version
get_python_version() {
    echo "Checking latest Python stable version..."
    local version
    version=$(curl -s https://api.github.com/repos/python/cpython/releases/latest | jq -r '.tag_name' | sed 's/^v//')
    echo "Latest Python stable: $version"
    echo "$version"
}

# Function to update .tool-versions file
update_tool_versions() {
    local nodejs_version=$1
    local python_version=$2
    
    echo "Updating .tool-versions file..."
    cat > "$TOOL_VERSIONS_FILE" << EOF
nodejs $nodejs_version
python $python_version
EOF
    echo "✅ Updated $TOOL_VERSIONS_FILE"
}

# Function to install versions via mise
install_versions() {
    echo "Installing updated versions via mise..."

    if command -v mise &> /dev/null; then
        echo "Installing Node.js..."
        mise install nodejs

        echo "Installing Python..."
        mise install python

        echo "Setting global versions..."
        mise use -g nodejs "$(grep nodejs "$TOOL_VERSIONS_FILE" | cut -d' ' -f2)"
        mise use -g python "$(grep python "$TOOL_VERSIONS_FILE" | cut -d' ' -f2)"

        echo "✅ Versions installed and set globally"
    else
        echo "⚠️  mise not found. Please install versions manually."
    fi
}

# Main function
main() {
    echo "🔍 Checking for latest stable versions..."
    
    # Check if required tools are available
    if ! command -v curl &> /dev/null; then
        echo "❌ curl is required but not installed."
        exit 1
    fi
    
    if ! command -v jq &> /dev/null; then
        echo "❌ jq is required but not installed. Install via: brew install jq"
        exit 1
    fi
    
    # Get latest versions
    nodejs_version=$(get_nodejs_version)
    python_version=$(get_python_version)
    
    # Update .tool-versions
    update_tool_versions "$nodejs_version" "$python_version"
    
    # Ask if user wants to install
    echo
    read -p "Do you want to install these versions via mise? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_versions
    else
        echo "ℹ️  To install manually, run: cd ~/.dotfiles && mise install"
    fi
    
    echo "🎉 Done!"
}

# Run main function
main "$@"