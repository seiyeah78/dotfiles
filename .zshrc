# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

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
export JAVA_VERSION=1.8
export JAVA_HOME=`/usr/libexec/java_home -v ${JAVA_VERSION}`
export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export EDITOR=nvim
export BAT_CONFIG_PATH="$HOME/dotfiles/bat/setting.conf"

CORE_PATH="/usr/local/sbin:$MYSQL_PATH:$GIT_DIFF_HIGHLIGHT:$JAVA_HOME/bin:\
$OPENSSL_PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$MYSCRIPT_DIR/bin:\
$GOPATH/bin:$HOME/.anyenv/bin:$MAC_VIM_PATH:$PATH"
export PATH=$CORE_PATH

export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LESS='-R'
export GTAGSLABEL=pygments
source /usr/local/etc/profile.d/z.sh

export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

#### setup zplugin ####
# https://blog.katio.net/page/zplugin
source $HOME/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin ice wait=0 lucid; zplugin light zsh-users/zsh-autosuggestions
zplugin ice wait=0 lucid; zplugin light zsh-users/zsh-completions
# zplugin light zdharma/fast-syntax-highlighting
zplugin ice wait=0 lucid atload'ZSH_HIGHLIGHT_STYLES[path]=none\
  ZSH_HIGHLIGHT_STYLES[path_prefix]=none\
  ZSH_HIGHLIGHT_STYLES[path_approx]=none';
zplugin light zsh-users/zsh-syntax-highlighting
zplugin ice wait=0 lucid; zplugin light github/hub
zplugin ice wait=0 lucid; zplugin light b4b4r07/emoji-cli
#
# # oh-my-zsh plugins
# # https://github.com/ohmyzsh/ohmyzsh
zplugin snippet OMZ::plugins/git/git.plugin.zsh
zplugin cdclear -q
zplugin ice wait=0 lucid; zplugin snippet OMZ::lib/completion.zsh
zplugin ice wait=0 lucid; zplugin snippet OMZ::plugins/common-aliases/common-aliases.plugin.zsh

# prompt theme
zplugin ice depth=1 atload'source ~/.p10k.zsh'
zplugin light romkatv/powerlevel10k

# use env language manager
eval "$(anyenv lazyload)"

# use hub
eval "$(hub alias -s)"
# disable loading messages when change directories
export DIRENV_LOG_FORMAT=
eval "$(direnv hook zsh)"

############## setting alias #################
alias vi='vim'
alias vim='nvim'
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

# https://github.com/jonas/tig/issues/951
alias tig=\(tig\)

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

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# exec zcompile manually only first time.
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi
