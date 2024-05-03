#! /bin/bash

# Gets the asdf-vm node plugin source.
# https://github.com/asdf-vm/asdf-plugins
function get_nodejs_repository() {
    if ! command -v asdf &> /dev/null; then
        echo "Cannot run 'asdf plugin add nodejs'"
        exit
    fi

    # Short-form alternative: `asdf plugin add nodejs`
    # Recommended to use the long-form. 
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    return
}

# Gets the asdf-vm python plugin source.
# https://github.com/asdf-vm/asdf-plugins
function get_python_repository() {
    if ! command -v asdf &> /dev/null; then
        echo "Cannot run 'asdf plugin add python'"
        exit
    fi

    # Short-form alternative: `asdf plugin add python`
    # Recommended to use the long-form. 
    asdf plugin add python https://github.com/asdf-community/asdf-python.git
    return
}

# Get plugins.
function get_asdf_plugins() {
    if ! command -v asdf &> /dev/null; then
        echo "Cannot run 'asdf plugin add'"
        exit
    fi
    
    asdf_plugins=("nodejs" "python")
    for plugin in "${asdf_plugins[@]}"; do
        case $plugin in
        "nodejs" | "node")
            get_nodejs_repository;;
        "python")
            get_python_repository;;
        *)
           echo "Unknown asdf plugin specified. PLUGIN: $plugin"
           ;;
        esac
    done

    return
}
