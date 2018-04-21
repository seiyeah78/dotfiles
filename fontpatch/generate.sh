#!/bin/sh
# For Mac

arg=$1
font_name=${arg:-'RictyDiminishedDiscord-Regular'}

if [ ! -d ./nerd-fonts ]; then
  git clone --depth 1 https://github.com/ryanoasis/nerd-fonts
fi

if [ type fontforge > /dev/null 2>&1 ]; then
  brew install fontforge
fi

# see : https://github.com/ryanoasis/nerd-fonts/issues/225
pyenv install
python -c "import configparser"
if [ $? != 0 ]; then
  pip install configparser
  mkdir -p ~/Library/Python/2.7/lib/python/site-packages
  echo 'import site; site.addsitedir("/usr/local/lib/python2.7/site-packages")' >> ~/Library/Python/2.7/lib/python/site-packages/homebrew.pth
fi

fontforge -script ./nerd-fonts/font-patcher ~/Library/Fonts/$font_name.ttf -c -l

open .

open -a "Font Book"

echo "End font patcher"
