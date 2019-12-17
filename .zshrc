# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

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

export EDITOR=nvim
export PATH=$CORE_PATH

#### setup zplugin ####
# https://blog.katio.net/page/zplugin
source $HOME/.zplugin/bin/zplugin.zsh
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin ice wait=0 lucid; zplugin light zsh-users/zsh-autosuggestions
zplugin ice wait=0 lucid; zplugin light zsh-users/zsh-completions
zplugin ice wait=0 lucid atload'FAST_HIGHLIGHT_STYLES[path]=none\
  FAST_HIGHLIGHT_STYLES[path_prefix]=none\
  FAST_HIGHLIGHT_STYLES[path_approx]=none';
zplugin light zdharma/fast-syntax-highlighting
zplugin ice wait=0 lucid; zplugin light github/hub
zplugin ice wait=0 lucid; zplugin light b4b4r07/emoji-cli
zplugin ice wait=0 lucid; zplugin light skywind3000/z.lua
zplugin ice wait=0 lucid src'init.sh'; zplugin light b4b4r07/enhancd

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
# global alias
alias -g C="| ruby -pe 'chomp if STDIN.eof?' | pbcopy"

alias vi='vim'
alias vim='nvim'
alias ls='ls -G'

alias fig='docker-compose'
alias agl="ag --pager='less -R'"

alias ctags="`brew --prefix`/bin/ctags"

###### git alias ######
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

############### Custom KeyBind ##############
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
#   zprof | less
# fi
