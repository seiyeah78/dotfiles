#!/bin/sh
# For Mac

arg=$1
font_name=${arg:-'RictyDiminishedDiscord-Regular'}
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts

cd nerd-fonts

if [ type fontforge > /dev/null 2>&1 ]; then
  brew install fontforge
fi

fontforge -script ./font-patcher ~/Library/Fonts/$font_name.ttf -c -l

open .

open -a "Font Book"

echo "End font patcher"
