set imdisable
set background=dark
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
" 起動時にフルスクリーンにする
" if has("gui_running")
"   set fuoptions=maxvert,maxhorz
"   au GUIEnter * set fullscreen
" endif

" The Silver Searcher
if executable('rg')
  set grepprg=rg\ --color=never
endif

