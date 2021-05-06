#! /bin/bash

if [ "${PWD##*/}" != ".dotfiles" ]; then
    echo "[ WARN ] Run this script from inside the dotfiles directory"
    exit
fi

echo "[ INFO ] Creating symlink"
cwd=$(pwd)
cd $cwd/config

DOTFILES=("$(find . -name ".*" -maxdepth 1 -type f -exec basename {} \;)")

for file in ${DOTFILES}; do
    echo "Creating symlink: $file --> $HOME"
    ln -fs $(pwd)/$file $HOME/$file
done

cd $cwd
cd $cwd/omz/plugins
OMZ_PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
PLUGINS=("$(ls)")

for plugin in ${PLUGINS}; do
    echo "Creating symlink: $plugin --> $OMZ_PLUGINS_DIR"
    ln -fs $(pwd)/$plugin $OMZ_PLUGINS_DIR
done

echo "[ INFO ] Finished generating symlinks"
