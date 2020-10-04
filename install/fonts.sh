#! /bin/bash

cwd=$(pwd)
cd $cwd/fonts
DIR="$cwd/fonts"
for f in "$DIR"/*; do
    cp "$f" "/Library/Fonts"
done
cd $cwd
