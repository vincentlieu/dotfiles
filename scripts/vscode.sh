#! /bin/bash

if [ "${PWD##*/}" != ".dotfiles" ]; then
    echo "[ WARN ] Run this script from inside the dotfiles directory"
    exit
fi

echo "[ INFO ] Installing/Updating vsc extensions"

VSC_EXTENSIONS=(
    "$(cat $(pwd)/misc/vsc-extensions.txt)"
)

for extension in ${VSC_EXTENSIONS}; do
    echo "Installing vsc extension: $extension"
    code --install-extension $extension --force
done

echo "[ INFO ] Finished installing vsc extensions"
