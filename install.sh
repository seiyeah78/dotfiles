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

if [ "$(uname)" == 'Darwin' ]; then
# Command Line Developer Tools
  xcode-select --print-path > dev/null 2>&1
  if [ 0 == $? ]; then
    eecho "Install Command Line Tools..."
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
    PROD=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | cut -d' ' -f2-)
    softwareupdate -i "$PROD";
  else
    eecho "Command Line Developer Tools are already installed!"
  fi
fi

if type git > /dev/null 2>&1; then
  if [ -e $DOTPATH ]; then
    eecho "already exists dotfiles."
  else
    git clone --recursive "https://github.com/seiyeah78/dotfiles.git" "$DOTPATH"
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

exec $SHELL -l
