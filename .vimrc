scriptencoding utf-8
set encoding=utf-8
set fenc=utf-8
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set autoindent
set smartindent
set noerrorbells
set fileformat=unix
set vb t_vb=
set t_Co=256
set noshowmode
set laststatus=2
set backspace=indent,eol,start
set splitbelow
set splitright
set number
set list
set listchars=tab:¦_
set guifont=Ricty\ Regular\ for\ Powerline:h5
set guifontwide=Ricty\ Regular\ for\ Powerline:h5
"normalモードへの時間を短縮する
set timeout timeoutlen=1000 ttimeoutlen=50
set noswapfile
set nocompatible
set switchbuf+=useopen

filetype off " be iMproved

if has('vim_starting')
  set rtp+=~/.vim/plugged/vim-plug
  if !isdirectory(expand('~/.vim/plugged/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/.vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
  end
endif
if !has('gui_running')
  set ttyfast
  set lazyredraw
endif
" Setting Vim-Plug
" on : loading when execute commands
" do : execute commands after install plugins
call plug#begin('~/.vim/plugged')
  Plug 'junegunn/vim-plug',
        \ {'dir': '~/.vim/plugged/vim-plug/autoload'}

  Plug 'Shougo/unite.vim' | Plug 'Shougo/neoyank.vim'
  Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby'] }
  Plug 'osyo-manga/vim-monster', { 'for': 'ruby' }
  Plug 'basyura/unite-rails'
  Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle','NERDTreeFind'] }
  Plug 'itchyny/lightline.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/fzf.vim'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'shougo/vimproc.vim', { 'do': 'make' }
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-endwise'
  Plug 'tomtom/tcomment_vim'
  Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags' | Plug 'vim-scripts/gtags.vim'
  Plug 'majutsushi/tagbar', { 'on': ['TagbarToggle'] }
  Plug 'Shougo/neocomplete.vim'
  " Plug 'kana/vim-smartinput'
  Plug 'jiangmiao/auto-pairs'
  Plug 'junegunn/goyo.vim', { 'on': ['Goyo'] }
  Plug 'tpope/vim-surround'
  Plug 'simeji/winresizer'
  Plug 'easymotion/vim-easymotion'
  Plug 'Yggdroot/indentLine'
  " Plug 'mhinz/vim-startify'
  Plug 'tsukkee/unite-tag'
  Plug 'junegunn/vim-easy-align'
  Plug 'haya14busa/incsearch.vim'
  Plug 'haya14busa/incsearch-easymotion.vim'
  Plug 'haya14busa/incsearch-fuzzy.vim'
  Plug 'tpope/vim-repeat'
  " Plug 't9md/vim-textmanip'

  " colorschemes plugins
  Plug 'jpo/vim-railscasts-theme'
  Plug 'w0ng/vim-hybrid'
  Plug 'ujihisa/unite-colorscheme'
  Plug 'flazz/vim-colorschemes'
  Plug 'chriskempson/vim-tomorrow-theme'
  Plug 'junegunn/limelight.vim'
call plug#end()

"vimのcolorschemeの背景色と同じにするためにnone
autocmd ColorScheme * highlight Normal ctermbg=none
" let g:hybrid_reduced_contrast = 1
colorscheme hybrid

filetype plugin indent on    " required!
syntax on

" ~~~~~~~~~~~~~~~~~共通mapping~~~~~~~~~~~~~~
" historyの管理
noremap <C-Y><C-Y> :<C-U>Unite history/yank<CR>
let g:neoyank#limit = 100
let g:neoyank#file = $HOME.'/.vim/yankring.txt'

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar', 'unite']

" ~~~~~~~~~~~~~~ctag setting~~~~~~~~~~~~~~
let g:tagbar_width = 30
" tagsジャンプの時に複数ある時は一覧表示
nmap <C-]> g<C-]>
nmap <C-W><C-]> <C-W>g<C-]>
"nmap <C-]>s :exe("stjump ".expand('<cword>'))<CR>
"nmap <C-]>v :exe("vertical stjump ".expand('<cword>'))<CR>

nmap <silent><leader>T :TagbarToggle<CR>

set tags=./tags,.Gemfile.lock.tags
let g:easytags_by_filetype = '~/.vim/tag/'
let g:easytags_dynamic_files = 1
let b:easytags_auto_highlight = 1
let g:easytags_async = 1
" 言語別easytag実行オプション
" let g:easytags_languages = {
" \   'ruby': {
" \     'cmd': 'ripper-tags',
" \       'args': [],
" \       'fileoutput_opt': '-f',
" \       'stdout_opt': '-f-',
" \       'recurse_flag': '-R'
" \   }
" \}
" ===================gtags.vim setting==================
" Suggested map:
nmap <F2> :copen<CR>
nmap <F4> :cclose<CR>
nmap <F5> :Gtags<SPACE>
" nmap <F6> :Gtags -f %<CR>
" nmap <F7> :GtagsCursor<CR>
" nmap <F8> :Gozilla<CR>
" nmap <C-n> :cn<CR>
" nmap <C-p> :cp<CR>
nmap <leader><C-]> :<C-U>execute 'Gtags -r '.expand('<cword>')<CR>
" Switching windows
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h
" ウィンドウ操作系
noremap <silent><C-w>s :<C-u>split<CR>
noremap <silent><C-w>v :<C-u>vsplit<CR>

" ============winresizer setting============
let g:winresizer_start_key = '<C-w>e'
let g:winresizer_horiz_resize = 2
let g:winresizer_vert_resize = 3

" Move visual block (eclipseみたいなアレ)
vnoremap <silent>J :m'>+1<CR>gv=gv
vnoremap <silent>K :m-2<CR>gv=gv
nnoremap  <silent>J :m+<CR>==
nnoremap  <silent>K :m-2<CR>==

" insertモード移行時にインデント調整
function! IndentWithI()
    if len(getline('.')) == 0
        return "cc"
    else
        return "i"
    endif
endfunction
nnoremap <expr> i IndentWithI()

" Open current line on GitHub
nnoremap <Leader>go :.Gbrowse<CR>

noremap <Leader>ga :Gwrite<CR>
" noremap <Leader>gc :Gcommit<CR>
" noremap <Leader>gsh :Gpush<CR>
" noremap <Leader>gr :Gremove<CR>
" noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gf :GFiles<CR>
noremap <Leader>gF :GFiles?<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
nmap <Leader>gj <Plug>GitGutterNextHunk
nmap <Leader>gk <Plug>GitGutterPrevHunk

"=================NERDTree setting===========================
nnoremap <silent><Leader><S-n><S-n> :NERDTreeToggle<CR>
nnoremap <silent><Leader><S-n>f :NERDTreeFind<CR>

" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" ==============vim-multiple-cursors=======
" neocompleteのキーバインドとバッティングするため回避
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

let NERDTreeShowHidden=1
let g:NERDTreeWinSize=25
"autocmd vimenter * NERDTree

" 選択範囲の色をVisualモードと同じにする
hi Visual ctermbg=239
hi multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
hi link multiple_cursors_visual Visual

" " ==============vim smartinput setting==========
" call smartinput#map_to_trigger('i', '#', '#', '#')
" call smartinput#define_rule({
"     \   'at': '\%#',
"     \   'char': '#',
"     \   'input': '#{}<Left>',
"     \   'filetype': ['ruby'],
"     \   'syntax': ['Constant', 'Special'],
"     \ })
" call smartinput#map_to_trigger('i', '<Bar>', '<Bar>', '<Bar>')
" call smartinput#define_rule({
"     \   'at' : '\({\|\<do\>\)\s*\%#',
"     \   'char' : '<Bar>',
"     \   'input' : '<Bar><Bar><Left>',
"     \   'filetype' : ['ruby'],
"     \    })


"=============vim-easy-align setting============
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ================vim easymotion setting========
" 最小限の設定にするため一旦解除
" map, nmapで、ノーマルモードのみウィンドウを超えて検索
" https://github.com/haya14busa/vim-easymotion/blob/master/doc/easymotion.txt
let g:EasyMotion_do_mapping = 0
" 日本語もjump対象
let g:EasyMotion_use_migemo = 1
" jump用のキーを設定する
let g:EasyMotion_keys='azwsxedcrfvtgbyhnujmikol'
" prefix(trigger)
map <Leader><Leader> <Plug>(easymotion-prefix)

" s{char}{char} to move to {char}{char}
map  s <Plug>(easymotion-s2)
nmap s <Plug>(easymotion-overwin-f2)

" <Leader>f{char} to move to {char}
map f <Plug>(easymotion-bd-f)
" nmap <Leader>f <Plug>(easymotion-overwin-f)

" Move to line
map L <Plug>(easymotion-bd-jk)
nmap L <Plug>(easymotion-overwin-line)

" Move to word
map <Leader>w <Plug>(easymotion-w)
" nmap <Leader>w <Plug>(easymotion-overwin-w)

" 検索系の拡張
" You can use other keymappings like <C-l> instead of <CR> if you want to
" use these mappings as default search and somtimes want to move cursor with
" EasyMotion.
function! s:incsearch_config(...) abort
  return incsearch#util#deepextend(deepcopy({
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {
  \     "\<CR>": '<Over>(easymotion)'
  \   },
  \   'is_expr': 0
  \ }), get(a:, 1, {}))
endfunction
" configは以下
" https://github.com/haya14busa/incsearch.vim/blob/161c5b66542e767962ca5f6998a22e984f8d8a60/autoload/incsearch/config.vim
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'prompt':'Search words overwin:'}))
noremap <silent><expr> g? incsearch#go(<SID>incsearch_config({'prompt':'Search words overwin:','command':'?'}))
" noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))

" Gif config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to
" EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" map f <Plug>(easymotion-f)
" map F <Plug>(easymotion-F)
" map t <Plug>(easymotion-tl) # lはline(１行)の意味
" map T <Plug>(easymotion-Tl)

" 他の.vimrcの読み込み
let s:vim_dotfiles = split(globpath('~/dotfiles/', '.vimrc_*'),'\n')
for filename in s:vim_dotfiles
  if filereadable(expand(filename))
    execute 'source' filename
  endif
endfor

hi ExtraWhitespace ctermbg=red
autocmd BufWritePre * StripWhitespace

" ?つきメソッド、@@インスタンスを単語とみなす
autocmd FileType ruby set isk+=@-@

autocmd BufNewFile,BufRead *.jbuilder set filetype=ruby
autocmd BufNewFile,BufRead Guardfile  set filetype=ruby
autocmd BufNewFile,BufRead .pryrc     set filetype=ruby

