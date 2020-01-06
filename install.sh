#!/bin/bash

DOTPATH=~/dotfiles

eecho() {
  echo $1
  echo
}

usage() {
  echo "Usage: $PROGNAME [OPTIONS] FILE"
  echo "  This script is ~."
  echo
  echo "Options:"
  echo "  -h, --help"
  echo "  -b, --skip-brew: skip install formula"
  echo
  exit 1
}

for OPT in "$@"
do
  case $OPT in
    -h | --help)
      usage
      exit 1
      ;;
    -b | --skip-brew)
      SKIP_BREW=1
      shift 1
      ;;
    # -- | -)
    #   shift 1
    #   param+=( "$@" )
    #   break
    #   ;;
    -*)
      echo "illegal option -- '$(echo $1 | sed 's/^-*//')'" 1>&2
      exit 1
      ;;
    *)
      if [[ ! -z "$1" ]] && [[ ! "$1" =~ ^-+ ]]; then
        param+=( "$1" )
        shift 1
      fi
      ;;
  esac
done

if type git > /dev/null 2>&1; then
  if [ -e $DOTPATH ]; then
    eecho "already exists dotfiles."
  else
    git clone --recursive "git@github.com:seiyeah78/dotfiles.git" "$DOTPATH"
  fi
else
  eecho "git is required"
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

  if [ -e "$HOME/$f" ] && [ ! -L "$HOME/$f" ]; then
    :
    # mkdir -p ~/.backup
    # mv "$HOME/$f" ~/.backup
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
  eecho "Command Line Developer Tools are already installed!"
fi

# Homebrew
if type brew > /dev/null 2>&1; then
  eecho "Homebrew is already installed!"
else
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [ -e Brewfile ]; then
  if [ -z "$SKIP_BREW" ]; then
    brew bundle
  else
    eecho "Skip install brew formula."
  fi
fi

# install anyenv
if type git > /dev/null 2>&1; then
  plugin_dir=$(anyenv root)/plugins
  mkdir -p $plugin_dir

  plugin_repos=("amashigeseiji/anyenv-lazyload" "znz/anyenv-update" "znz/anyenv-git")
  for p in $plugin_repos
  do
    echo git clone https://github.com/$p.git $plugin_dir/${p##*/}
  done
fi

exec $SHELL -l
