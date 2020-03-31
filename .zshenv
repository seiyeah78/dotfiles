# zmodload zsh/zprof && zprof

# User configuration
GIT_DIFF_HIGHLIGHT="/usr/local/share/git-core/contrib/diff-highlight"
MYSCRIPT_DIR="/project/macro/scripts"
OPENSSL_PATH="/usr/local/opt/openssl/bin"
MYSQL_PATH="/usr/local/opt/mysql@5.6/bin"
MAC_VIM_PATH="/Applications/MacVim.app/Contents/bin"

export NVIM_TUI_ENABLE_TRUE_COLOR=1
# export JAVA_VERSION=1.8
# export JAVA_HOME=`/usr/libexec/java_home -v ${JAVA_VERSION}`
export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export BAT_CONFIG_PATH="$HOME/dotfiles/bat/setting.conf"

export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LESS='-R'

export GTAGSLABEL=pygments

export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

CORE_PATH="/usr/local/sbin:$MYSQL_PATH:$GIT_DIFF_HIGHLIGHT:$JAVA_HOME/bin:\
$OPENSSL_PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$MYSCRIPT_DIR/bin:\
$HOME/.anyenv/bin:$MAC_VIM_PATH"

# DEFAULTでfzf.vimも反映する
# export FZF_DEFAULT_COMMAND='ag --hidden  --ignore .git -g ""'
# .ignoreファイルで無視リストを作成できる
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden --follow --no-messages --ignore-file ~/.ignore'

export FZF_DEFAULT_OPTS="
  --reverse
  --tiebreak=index
  --color bg+:239
  --color pointer:168,marker:168
  --no-unicode
"
export FZF_CTRL_R_OPTS="-i --sort --prompt 'HISTORY> '"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS="--ansi --prompt 'FILES> ' --preview '(bat {-1} || rougify {-1} || ccat {-1} | cat {-1}) 2> /dev/null'"

export AWS_DEFAULT_REGION=ap-northeast-1
export AWS_DEFAULT_OUTPUT=json
export AWS_DEFAULT_PROFILE=default
export THOR_MERGE=vimdiff
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd)
export GIST_USER=seiyeah78

if [ -e ~/.zshenv.local ]; then
  source ~/.zshenv.local
fi
