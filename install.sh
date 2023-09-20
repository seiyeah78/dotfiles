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
  echo "  -i, --install-formula: install formula"
  echo
  exit 1
}

for OPT in "$@"; do
  case $OPT in
    -h | --help)
      usage
      exit 1
      ;;
    -i | --install-formula)
      INSTALL_BREW=1
      shift 1
      ;;
    --update-commandline-tools)
      CMDLINE_TOOLS=1
      shift 1
      ;;
    -*)
      echo "illegal option -- '$(echo $1 | sed 's/^-*//')'" 1>&2
      exit 1
      ;;
    *)
      if [[ ! -z "$1" ]] && [[ ! "$1" =~ ^-+ ]]; then
        param+=("$1")
        shift 1
      fi
      ;;
  esac
done

function is_exists() {
  type "$1" > /dev/null 2>&1
  return $?
}

sudo -v # ask for sudo upfront

if [ "$(uname)" == 'Darwin' ]; then
  # Command Line Developer Tools
  xcode-select --print-path > /dev/null 2>&1
  if [ 0 != $? ] || [ ! -z "$CMDLINE_TOOLS" ]; then
    eecho "Install Command Line Tools..."
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    PROD=$(softwareupdate -l | grep "\*.*Command Line" | tail -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | cut -d' ' -f2-)
    eecho "Latest version:  $PROD"
    softwareupdate -i "$PROD"
  else
    eecho "Command Line Developer Tools are already installed!"
  fi
fi

if is_exists "git"; then
  if [ -e $DOTPATH ]; then
    eecho "already exists dotfiles."
  else
    git clone --recursive "https://github.com/seiyeah78/dotfiles.git" "$DOTPATH"
    INSTALL_BREW=1
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

for f in .??*; do
  if [ "$f" == ".git" ] || [ "$f" == ".DS_Store" ]; then
    continue
  fi

  if [ -e "$HOME/$f" ] && [ ! -L "$HOME/$f" ]; then
    :
    # mkdir -p ~/.backup
    # mv "$HOME/$f" ~/.backup
  fi
  ln -snfv "$DOTPATH/$f" "$HOME"
done

# Homebrew
if is_exists "brew"; then
  eecho "Homebrew is already installed!"
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ -e Brewfile ]; then
  if [ ! -z "$INSTALL_BREW" ]; then
    brew bundle
  else
    eecho "Skip install brew formula."
  fi
fi

# asdf plugins
if is_exists "asdf"; then
  langs=("python ruby nodejs awscli kubectl terraform")

  for l in $langs; do
    asdf plugin-add $l
    asdf install $l latest
  done
  exec $SHELL -l
fi

if is_exists "kubectl"; then
  krew_path=${KREW_ROOT:-$HOME/.krew}
  if [ -e $krew_path ]; then
    (
      set -x; cd "$(mktemp -d)" &&
      OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
      ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
      KREW="krew-${OS}_${ARCH}" &&
      curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
      tar zxvf "${KREW}.tar.gz" &&
      ./"${KREW}" install krew
    )
    exec $SHELL -l
    kubectl krew
    if [ $? = 0 ]; then
      plugins=("ctx ns view-secret resource-capacity rbac-tool")
      for p in plugins ; do
        kubectl krew install $p
      done
    fi
  fi
fi
