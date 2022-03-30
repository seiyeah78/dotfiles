# zmodload zsh/zprof && zprof

# User configuration
GIT_DIFF_HIGHLIGHT="/usr/local/share/git-core/contrib/diff-highlight"
MYSCRIPT_DIR="/project/macro/scripts"
OPENSSL_PATH="/usr/local/opt/openssl/bin"
CURL_PATH="/usr/local/opt/curl/bin"
MYSQL_PATH="/usr/local/opt/mysql@5.6/bin"
MAC_VIM_PATH="/Applications/MacVim.app/Contents/bin"

export NVIM_TUI_ENABLE_TRUE_COLOR=1
export HOMEBREW_NO_AUTO_UPDATE=1
# export JAVA_VERSION=1.8
# export JAVA_HOME=`/usr/libexec/java_home -v ${JAVA_VERSION}`
export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export BAT_CONFIG_PATH="$HOME/dotfiles/bat/setting.conf"
export PIPENV_VENV_IN_PROJECT=1
export GOPATH=$HOME/go

export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LESS='-R'

export GTAGSLABEL=pygments

export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"
# Disable % mark at end
export PROMPT_EOL_MARK=''
export ASDF_USER_SHIMS

export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

CORE_PATH="/usr/local/bin:/usr/local/sbin:$MYSQL_PATH:$GIT_DIFF_HIGHLIGHT:$JAVA_HOME/bin:\
$OPENSSL_PATH:$CURL_PATH:/usr/local/opt/grep/libexec/gnubin:$MYSCRIPT_DIR/bin:\
$HOME/.anyenv/bin:$MAC_VIM_PATH:$HOME/go/bin:$HOME/.cargo/bin:${KREW_ROOT:-$HOME/.krew}/bin:\
:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.poetry/bin:$GOPATH/bin"

# DEFAULTでfzf.vimも反映する
# export FZF_DEFAULT_COMMAND='ag --hidden  --ignore .git -g ""'
# .ignoreファイルで無視リストを作成できる
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden --follow --no-messages --ignore-file ~/.ignore'
term_name=$(lsappinfo info -only name `lsappinfo front` | cut -d'=' -f2 | xargs)
if [ $term_name = "Alacritty" ]; then
  no_unicode="--no-unicode"
else
  no_unicode=""
fi
export FZF_DEFAULT_OPTS="
  --reverse
  --tiebreak=index
  --color=bg+:239,pointer:168,marker:168
  --bind=alt-k:preview-up,alt-j:preview-down
  ${no_unicode}
"
export FZF_PREVIEW_OPTS="--preview='(bat {-1} || rougify {-1} || ccat {-1} | cat {-1}) 2> /dev/null'"
export FZF_CTRL_R_OPTS="$FZF_DEFAULT_OPTS -i --sort --prompt 'HISTORY> '"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS $FZF_PREVIEW_OPTS --ansi --prompt 'FILES> '"
export FZF_TMUX=1
export FZF_TMUX_OPTS='-p70%,50% -xC -yC'

export THOR_MERGE=vimdiff
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd)
export GIST_USER=seiyeah78

if [ -e ~/.zshenv.local ]; then
  source ~/.zshenv.local
fi
source "$HOME/.cargo/env"
