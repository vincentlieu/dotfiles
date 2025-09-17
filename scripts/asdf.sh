#! /bin/bash

set -euo pipefail

# Gets the asdf-vm node plugin source.
# https://github.com/asdf-vm/asdf-plugins
function get_nodejs_repository() {
    if ! command -v asdf &> /dev/null; then
        echo "❌ Error: asdf is not installed or not in PATH"
        exit 1
    fi

    # Check if plugin already exists
    if asdf plugin list | grep -q "^nodejs$"; then
        echo "ℹ️  nodejs plugin already installed"
        return 0
    fi

    echo "📦 Installing nodejs plugin..."
    # Short-form alternative: `asdf plugin add nodejs`
    # Recommended to use the long-form. 
    if ! asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git; then
        echo "❌ Error: Failed to install nodejs plugin"
        exit 1
    fi
    echo "✅ nodejs plugin installed successfully"
}

# Gets the asdf-vm python plugin source.
# https://github.com/asdf-vm/asdf-plugins
function get_python_repository() {
    if ! command -v asdf &> /dev/null; then
        echo "❌ Error: asdf is not installed or not in PATH"
        exit 1
    fi

    # Check if plugin already exists
    if asdf plugin list | grep -q "^python$"; then
        echo "ℹ️  python plugin already installed"
        return 0
    fi

    echo "📦 Installing python plugin..."
    # Short-form alternative: `asdf plugin add python`
    # Recommended to use the long-form. 
    if ! asdf plugin add python https://github.com/asdf-community/asdf-python.git; then
        echo "❌ Error: Failed to install python plugin"
        exit 1
    fi
    echo "✅ python plugin installed successfully"
}

# Get plugins.
function get_asdf_plugins() {
    if ! command -v asdf &> /dev/null; then
        echo "❌ Error: asdf is not installed or not in PATH"
        exit 1
    fi
    
    echo "🚀 Setting up asdf plugins..."
    
    local asdf_plugins=("nodejs" "python")
    local failed_plugins=()
    
    for plugin in "${asdf_plugins[@]}"; do
        case $plugin in
        "nodejs" | "node")
            if ! get_nodejs_repository; then
                failed_plugins+=("nodejs")
            fi
            ;;
        "python")
            if ! get_python_repository; then
                failed_plugins+=("python")
            fi
            ;;
        *)
           echo "⚠️  Unknown asdf plugin specified: $plugin"
           ;;
        esac
    done

    if [ ${#failed_plugins[@]} -gt 0 ]; then
        echo "❌ Failed to install plugins: ${failed_plugins[*]}"
        exit 1
    fi
    
    echo "🎉 All asdf plugins installed successfully!"
}

# Main execution
main() {
    echo "🔧 Starting asdf setup..."
    get_asdf_plugins
}

main "$@"