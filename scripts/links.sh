#! /bin/bash

if [ "${PWD##*/}" != ".dotfiles" ]; then
    echo "[ WARN ] Run this script from inside the dotfiles directory"
    exit
fi

echo "[ INFO ] Creating symlink"
cwd=$(pwd)
cd $cwd/config

FILES=("$(find . -name ".*" -maxdepth 1 -type f -exec basename {} \;)")

for f in ${FILES}; do
    echo "Creating symlink: $f --> $HOME"
    ln -fs $(pwd)/$f $HOME/$f
done

echo "[ INFO ] Finished generating symlinks"

cd $cwd
