#! /bin/bash

if [ "${PWD##*/}" != ".dotfiles" ]; then
    echo "[ WARN ] Run this script from inside the dotfiles directory"
    exit
fi

echo "[ INFO ] Installing hacked nerd fonts"

cwd=$(pwd)
cd $cwd/fonts
DIR="$cwd/fonts"
FONT_DIR="/Library/Fonts"

for f in "$DIR"/*; do
    echo "Copying: $f --> $FONT_DIR"
    cp "$f" "$FONT_DIR"
done

cd $cwd
