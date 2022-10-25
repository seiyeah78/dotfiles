# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
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
unsetopt promptcr

export EDITOR=nvim
export PATH=$CORE_PATH

#### setup zinit ####
# https://blog.katio.net/page/zplugin
source "${ZINIT_HOME}/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit ice wait=0 lucid; zinit light zsh-users/zsh-completions
zinit ice wait=0 lucid; zinit light b4b4r07/emoji-cli
zinit ice wait=0 lucid; zinit light skywind3000/z.lua
zinit ice wait=0 lucid; zinit light hlissner/zsh-autopair
zinit ice wait=0 lucid as"program" pick="bin/git-fuzzy"; zinit light bigH/git-fuzzy
zinit ice wait=0 lucid as"program" cp"chrome-tab-activate -> fca" pick="fca"; zinit light Rasukarusan/fzf-chrome-active-tab
zinit ice wait=0 lucid as"program" pick="chromeHistory.sh"; zinit light Rasukarusan/fzf-chrome-history
zinit ice wait=0 lucid atload"export ASDF_USER_SHIMS=${ASDF_DATA_DIR:-$HOME/.asdf}/shims"; zinit light asdf-vm/asdf
# zinit ice wait=0 lucid; zinit light wfxr/forgit

zinit wait=0 lucid light-mode \
  atload="_zsh_autosuggest_start; \
  # workaround slowdown history-beginning-search-{forward,backward}-end
  unset ZSH_AUTOSUGGEST_USE_ASYNC" \
    for zsh-users/zsh-autosuggestions

zinit wait=0 lucid notify light-mode \
  atinit="ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
  atload="FAST_HIGHLIGHT_STYLES[path]=none\
  FAST_HIGHLIGHT_STYLES[path_prefix]=none\
  FAST_HIGHLIGHT_STYLES[path_approx]=none\
  FAST_HIGHLIGHT[chroma-ruby]=" for \
  zdharma/fast-syntax-highlighting

# oh-my-zsh plugins : https://github.com/ohmyzsh/ohmyzsh
zinit ice wait=0 lucid; zinit snippet OMZ::lib/completion.zsh
zinit ice wait=0 lucid; zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit ice wait=0 lucid; zinit snippet OMZ::plugins/common-aliases/common-aliases.plugin.zsh

# prompt theme
zinit ice depth=1 atload'source ~/.p10k.zsh'
zinit light romkatv/powerlevel10k

# use hub
eval "$(hub alias -s)"

# disable loading messages when change directories
export DIRENV_LOG_FORMAT=
eval "$(direnv hook zsh)"

############## setting alias #################
# global alias
alias -g C="| /usr/bin/ruby -pe 'chomp if STDIN.eof?' | pbcopy"
alias -g D="| delta --navigate"

alias vi='vim'
alias vim='nvim'
alias ls='ls -G'

alias dc='docker-compose'

# すべてのファイルを検索する
alias ag='ag --hidden --skip-vcs-ignores'
alias rg='rg --hidden --no-ignore'
alias agl="ag --pager='less -R'"
alias k9s="LC_CTYPE=en_US.UTF-8 k9s"
alias ctags="`brew --prefix`/bin/ctags"

alias tf='terraform'

###### git alias ######
unalias gcm
unalias grv
unalias gp
alias gdc='git dc'
alias gcm='git cm'
alias groot='cd $(git rev-parse --show-toplevel)'
alias gpf='f(){ print -z " git push --force-with-lease ${1:-origin} $(git symbolic-ref --short HEAD)" }; f'
alias gpO='gpf origin'
alias gpU='gpf upstream'

alias k='kubectl'
alias kc='kubectx'
alias kg='kubectl get'

alias hosts='sudo vi /etc/hosts'
alias vimrc='$EDITOR ~/.vimrc'

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

# include other zshrc files
[ -f ~/dotfiles/include_zshrc/zshrc_commands ] && source ~/dotfiles/include_zshrc/zshrc_commands
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

eval $(thefuck --alias)
# if (which zprof > /dev/null 2>&1) ;then
#   zprof
# fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
