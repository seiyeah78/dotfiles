#specific install path
path=( "$HOME/.zfunctions" $fpath )

setopt hist_save_no_dups
# ヒストリに追加されるコマンド行が古いものと同じなら古いものを削除
setopt hist_ignore_all_dups
# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space
setopt hist_no_store
setopt share_history
setopt nonomatch
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_ignore_dups
setopt auto_cd
setopt multios
setopt prompt_subst

# User configuration
GIT_DIFF_HIGHLIGHT="/usr/local/share/git-core/contrib/diff-highlight"
MYSCRIPT_DIR="/project/macro/scripts"
CORE_PATH="$PATH:${GIT_DIFF_HIGHLIGHT}:${JAVA_HOME}/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:${MYSCRIPT_DIR}/bin:$HOME/.phpenv/bin"

export JAVA_VERSION=1.8
export JAVA_HOME=`/usr/libexec/java_home -v ${JAVA_VERSION}`
export PATH="${CORE_PATH}"
export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export NODE_PATH=$(npm root -g)

export EDITOR=vim
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LESS='-R'
export GTAGSLABEL=pygments
source $(brew --prefix)/etc/profile.d/z.sh

# load zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

#### setup zplug ####

# oh my zsh plugins
zplug zsh-users/zsh-completions
zplug plugins/common-aliases, from:oh-my-zsh, defer:2
zplug plugins/git,            from:oh-my-zsh
zplug plugins/svn,            from:oh-my-zsh
zplug lib/completion,         from:oh-my-zsh

# prompt theme
zplug mafredri/zsh-async,     from:github
zplug seiyeah78/pure, use:pure.zsh, from:github, as:theme

zplug zsh-users/zsh-syntax-highlighting, defer:2

# load hub comp
zplug github/hub, defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
      echo; zplug install
  fi
fi
# Then, source plugins and add commands to $PATH
zplug load

# use rbenv
eval "$(rbenv init -)"
# use phpenv
eval "$(phpenv init -)"
# use hub
eval "$(hub alias -s)"
# use pyenv
PYENV_ROOT=~/.pyenv
export PATH=$PATH:$PYENV_ROOT/bin
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
ZSH_HIGHLIGHT_STYLES[path_approx]=none
#PURE_GIT_DELAY_DIRTY_CHECK=3
#PURE_GIT_UNTRACKED_DIRTY=1
#PURE_GIT_DIRTY_SYMBOL="!"

function switch-java() {
    export JAVA_VERSION=${1}
    export JAVA_HOME=`/usr/libexec/java_home -v ${JAVA_VERSION}`
    export PATH="${CORE_PATH}"
    echo `java -version`
}

############## setting alias #################
alias vi='vim'
alias ls='ls -G'

alias vu='vagrant up'
alias vha='vagrant halt'
alias vr='vagrant reload'
alias vru='rake vagrant:up'
alias agl="ag --pager='less -R'"

alias cs="bundle exec rails c --sandbox"
alias c="bundle exec rails c"

#末尾の改行コードを除いてコピーする
alias -g C="| ruby -pe 'chomp("")' | pbcopy"

# ctagsのPATHを上書き
alias ctags="`brew --prefix`/bin/ctags"

######git alias ######
unalias gcm
alias gdc='git dc'
alias gcm='git cm'

precmd() {
  _z --add "$(pwd -P)"
}


###############キーバインド##############
bindkey -e

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey '^P' history-beginning-search-backward-end
bindkey '^N' history-beginning-search-forward-end
bindkey '^O' down-history
bindkey '^J' backward-word
bindkey '^K' forward-word
bindkey "\e[Z" reverse-menu-complete

#zle -N peco-select-history
#bindkey '^R' peco-select-history

#########################################

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
autoload -Uz colors
colors

autoload -Uz compinit
compinit -C

autoload -Uz promptinit && promptinit
#prompt pure

# include other zshrc files
[ -f ~/dotfiles/.zshrc_commands ] && source ~/dotfiles/.zshrc_commands

#test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
