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
set guicursor=a:blinkon0
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

