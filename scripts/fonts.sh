#! /bin/bash

if [ "${PWD##*/}" != ".dotfiles" ]; then
    echo "[ WARN ] Run this script from inside the dotfiles directory"
    exit
fi

cwd=$(pwd)
cd $cwd/fonts
DIR="$cwd/fonts"
for f in "$DIR"/*; do
    cp "$f" "/Library/Fonts"
done
cd $cwd
