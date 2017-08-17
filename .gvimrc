map ¥ <leader>
set imdisable
set background=dark
colorscheme hybrid
set rtp+=/usr/local/bin/fzf
" メニューバーを非表示にする
set guioptions-=m
" 左右のスクロールバーを非表示にする
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
" 水平スクロールバーを非表示にする
set guioptions-=b
" カーソルの点滅を抑止
set guicursor=a:block-Cursor-blinkon0
" 縦幅　デフォルトは24
set lines=40
" 横幅　デフォルトは80
set columns=120
" set guifontwide=Ricty\ Regular\ for\ Powerline:h13
" set guifont=Ricty\ Regular\ for\ Powerline:h13
set guifont=Droid\ Sans\ Mono:h14
set guifontwide=Droid\ Sans\ Mono:h14
" 起動時にフルスクリーンにする
" if has("gui_running")
"   set fuoptions=maxvert,maxhorz
"   au GUIEnter * set fullscreen
" endif
" ctrlp.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|tox|ico|git|hg|svn))$'
let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"
let g:ctrlp_use_caching = 1

" The Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files  --no-ignore --hidden --follow --no-messages --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

if has("gui_running")
  noremap <leader>b :CtrlPBuffer<CR>
  noremap <silent><expr><C-p> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":CtrlP\<CR>"
endif

" noremap <silent><C-p> :CtrlP
let g:ctrlp_map = '<leader>e'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_dont_split = 'NERD'
