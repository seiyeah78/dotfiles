#!/bin/bash

DOTPATH=~/.dotfiles

# git が使えるなら git
if has "git"; then
    git clone --recursive "git@github.com:seiyeah78/dotfiles.git" "$DOTPATH"
else
    die "git is required"
fi

cd ~/.dotfiles
if [ $? -ne 0 ]; then
    die "not found: $DOTPATH"
fi

# 移動できたらリンクを実行する
for f in .??*
do
    [ "$f" = ".git" || "$f" = ".DS_Store" ] && continue

    ln -snfv "$DOTPATH/$f" "$HOME/$f"
done

# Command Line Developer Tools
xcode-select --install > /dev/null 2>&1
if [ 0 == $? ]; then
    sleep 1
    osascript <<EOD
tell application "System Events"
    tell process "Install Command Line Developer Tools"
        keystroke return
        click button "Agree" of window "License Agreement"
    end tell
end tell
EOD
else
  echo "Command Line Developer Tools are already installed!"
fi

# Homebrew
if [ `witch brew > /dev/null 2>&1` ]; then
  echo "Homebrew is already installed!"
else
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [ -e Brewfile ]; then
  brew bundle
fi
