# zmodload zsh/zprof && zprof

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
export FZF_CTRL_T_OPTS="--ansi --prompt 'FILES> ' --preview '(bat {-1} || rougify {-1} || ccat {-1} | cat {-1}) 2> /dev/null | head -200'"

export AWS_DEFAULT_REGION=ap-northeast-1
export AWS_DEFAULT_OUTPUT=json
export AWS_DEFAULT_PROFILE=default
export THOR_MERGE=vimdiff
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd)

if [ -e ~/.zshenv.local ]; then
  source ~/.zshenv.local
fi
