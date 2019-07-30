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
OPENSSL_PATH="/usr/local/opt/openssl/bin"
MYSQL_PATH="/usr/local/opt/mysql@5.6/bin"
MAC_VIM_PATH="/Applications/MacVim.app/Contents/bin"

export NVIM_TUI_ENABLE_TRUE_COLOR=1
export GOPATH=$HOME/.go
export JAVA_VERSION=1.8
export JAVA_HOME=`/usr/libexec/java_home -v ${JAVA_VERSION}`
export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export EDITOR=vim
export BAT_CONFIG_PATH="$HOME/dotfiles/bat/setting.conf"

CORE_PATH="/usr/local/sbin:$MYSQL_PATH:$GIT_DIFF_HIGHLIGHT:$JAVA_HOME/bin:\
$OPENSSL_PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$MYSCRIPT_DIR/bin:\
$HOME/$GOPATH/bin:$HOME/.anyenv/bin:$MAC_VIM_PATH:$PATH"
export PATH=$CORE_PATH

export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LESS='-R'
export GTAGSLABEL=pygments
source /usr/local/etc/profile.d/z.sh

# load zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

#### setup zplug ####

# oh my zsh plugins
zplug zsh-users/zsh-completions
zplug plugins/common-aliases, from:oh-my-zsh, defer:2
zplug plugins/git,            from:oh-my-zsh
zplug lib/completion,         from:oh-my-zsh

# prompt theme
zplug mafredri/zsh-async,     from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
zplug zsh-users/zsh-syntax-highlighting, defer:2
# load hub comp
zplug github/hub, defer:2
zplug "b4b4r07/emoji-cli"

# Install plugins if there are plugins that have not been installed
# if ! zplug check --verbose; then
#   printf "Install? [y/N]: "
#   if read -q; then
#       echo; zplug install
#   fi
# fi
# Then, source plugins and add commands to $PATH
zplug load

# use env language manager
eval "$(anyenv init -)"
eval "$(rbenv init --no-rehash -; pyenv init --no-rehash -; ndenv init --no-rehash -; pyenv virtualenv-init --no-rehash -)"
# use hub
eval "$(hub alias -s)"
eval "$(direnv hook zsh)"

ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
ZSH_HIGHLIGHT_STYLES[path_approx]=none
#PURE_GIT_DELAY_DIRTY_CHECK=3
#PURE_GIT_UNTRACKED_DIRTY=1
#PURE_GIT_DIRTY_SYMBOL="!"

function switch-java() {
    export JAVA_VERSION=${1}
    export JAVA_HOME=`/usr/libexec/java_home -v ${JAVA_VERSION}`
    export PATH=$CORE_PATH
    echo `java -version`
}

############## setting alias #################
alias vi='vim'
alias ls='ls -G'

alias fig='docker-compose'
alias agl="ag --pager='less -R'"

#末尾の改行コードを除いてコピーする
alias -g C="| ruby -pe 'chomp if STDIN.eof?' | pbcopy"

# ctagsのPATHを上書き
alias ctags="`brew --prefix`/bin/ctags"

######git alias ######
unalias gcm
unalias grv
unalias gp
alias gdc='git dc'
alias gcm='git cm'
alias groot='cd $(git rev-parse --show-toplevel)'

alias hosts='sudo vi /etc/hosts'
alias vimrc='$EDITOR ~/.vimrc'

precmd() {
  _z --add "$(pwd -P)"
}

###############Custom KeyBind##############
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
bindkey '\e[3~' delete-char
#########################################

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# include other zshrc files
[ -f ~/dotfiles/include_zshrc/zshrc_commands ] && source ~/dotfiles/include_zshrc/zshrc_commands

# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
