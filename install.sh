#!/bin/bash

DOTPATH=~/dotfiles

if type git > /dev/null 2>&1; then
  if [ -e $DOTPATH ]; then
    echo "already exists dotfiles. update..."
    git pull
    exit 0
  else
    git clone --recursive "git@github.com:seiyeah78/dotfiles.git" "$DOTPATH"
  fi
else
  echo "git is required"
  exit 1
fi

cd $DOTPATH

if [ $? -ne 0 ]; then
  "not found: $DOTPATH"
  exit 1
fi

for f in .??*
do
   if [ "$f" == ".git" ] || [ "$f" == ".DS_Store" ]; then
     continue
   fi

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
if type brew > /dev/null 2>&1; then
  echo "Homebrew is already installed!"
else
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [ -e Brewfile ]; then
  brew bundle
fi

exec $SHELL -l
