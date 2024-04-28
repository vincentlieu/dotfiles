#! /bin/bash

default_packages_dir="/default-packages"

# Add asdf.sh to $HOME/.asdfrc.
# https://asdf-vm.com/guide/getting-started.html#_3-install-asdf
function set_asdf_source() {
    if ! command -v asdf &> /dev/null; then
        echo "asdf doesn't seem to be installed. Cannot set source in zshrc."
        exit
    fi

    asdf_source="$(brew --prefix asdf)/libexec/asdf.sh"
    if grep -q "$asdf_source" "${ZDOTDIR:-~}/.zshrc"; then
        echo "asdf source already exists."
    else 
        echo -e "\n. $asdf_source" >> "${ZDOTDIR:-~}"/.zshrc
    fi
    
    return
}

# Symlinks .asdfrc to $HOME/.asdfrc.
function set_asdfrc() {
    if ! command -v asdf &> /dev/null; then
        echo "Will not symlink .asdfrc since asdf does not exist."
        exit
    fi

    asdfrc_file_name=".asdfrc"
    asdfrc_file_path="$(pwd)/$asdfrc_file_name"    
    # Check that the .asdfrc file exists.
    if ! test -f "$asdfrc_file_path"; then
        echo "Could not find .asdfrc file to symlink."
        echo "PATH: $asdfrc_file_path"
    else
        echo "Removing any references to .asdfrc"
        rm "$HOME/$asdfrc_file_name"
        
        echo "Symlinking .asdfrc"
        ln -s "$asdfrc_file_path" "$HOME"
    fi

    return
}

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

# Symlinks the default-npm-packages file in ../default-packages.
function symlink_default_nodejs_packages() {
    asdf_default_npm_file_name=".default-npm-packages"
    asdf_default_npm_file_path="$(pwd)$default_packages_dir/$asdf_default_npm_file_name"

    # Check that the default-npm-packages file exists.
    if ! test -f "$asdf_default_npm_file_path"; then
        echo "Could not find default-npm-packages file to symlink."
        echo "PATH: $asdf_default_npm_file_path"
    else
        if [[ -e "$HOME/$asdf_default_npm_file_name" || -L "$HOME/$asdf_default_npm_file_name" ]]; then
            echo "asdf default-npm-packages already symlinked."
            return
        fi

        echo "Symlinking asdf default-npm-packages"
        ln -s "$asdf_default_npm_file_path" "$HOME"
    fi
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

# Symlinks the default-python-packages file in ../default-packages.
function symlink_default_python_packages() {
    asdf_default_python_file_name=".default-python-packages"
    asdf_default_python_file_path="$(pwd)$default_packages_dir/$asdf_default_python_file_name"

    # Check that the default-python-packages file exists.
    if ! test -f "$asdf_default_python_file_path"; then
        echo "Could not find default-python-packages file to symlink."
        echo "PATH: $asdf_default_python_file_path"
    else
        if [[ -e "$HOME/$asdf_default_python_file_name" || -L "$HOME/$asdf_default_python_file_name" ]]; then
            echo "asdf default-python-packages already symlinked."
            return
        fi
        echo "Symlinking asdf default-python-packages"
        ln -s "$asdf_default_python_file_path" "$HOME"
    fi
    return
}

# Sets up everything required for the python plugin.
function setup_python_plugin() {
    symlink_default_python_packages
    get_python_repository
    return
}

# Sets up everything required for the nodejs plugin.
function setup_nodejs_plugin() {
    symlink_default_nodejs_packages
    get_nodejs_repository
    return
}

# Sets up all plugins.
function setup_asdf_plugins() {
    if ! command -v asdf &> /dev/null; then
        echo "Cannot run 'asdf plugin add'"
        exit
    fi
    
    asdf_plugins=("nodejs" "python")
    for plugin in "${asdf_plugins[@]}"; do
        case $plugin in
        "nodejs" | "node")
            setup_nodejs_plugin;;
        "python")
            setup_python_plugin;;
        *)
           echo "Unknown asdf plugin specified. PLUGIN: $plugin"
           ;;
        esac
    done


    return
}

# Sets up asdf configuration.
function setup_asdf_config() {
    set_asdf_source
    set_asdfrc
    return
}

function main() {
    if ! command -v asdf &> /dev/null; then
        echo "asdf is not installed."
        exit
    fi

    setup_asdf_config
    setup_asdf_plugins
    return
}

main
