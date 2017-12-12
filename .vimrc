" vim: set foldmethod=marker foldlevel=0:
language en_us
if exists('$PYENV_ROOT')
  let g:python3_host_prog = $PYENV_ROOT . '/shims/python3'
endif
set re=1
scriptencoding utf-8
set nofixeol
set encoding=utf-8
set fileencodings=utf-8
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
set scrolloff=4
"１行辺りsyntax解析する文字数
set synmaxcol=600
set guifont=Ricty\ Regular\ for\ Powerline:h5
set guifontwide=Ricty\ Regular\ for\ Powerline:h5
"normalモードへの時間を短縮する
set timeout timeoutlen=1000 ttimeoutlen=50
set noswapfile
set nobackup
set nocompatible
set switchbuf+=useopen
" 初期表示時は通常通り開いている状態にする
" set nofoldenable
set foldmethod=indent
set foldlevel=2
" don't open scratch window when start complete
set completeopt-=preview
" .un(undoファイル)の保存場所
set undodir=$HOME/.vim/undodir
set undofile
set hidden
set wildmenu
" like bash complete with tab
set wildmode=longest,full
set wrapscan

if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

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
endif

" Setting Vim-Plug
" on : loading when execute commands
" do : execute commands after install plugins
call plug#begin('~/.vim/plugged')
  Plug 'junegunn/vim-plug',
        \ {'dir': '~/.vim/plugged/vim-plug/autoload'}

  Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby'] }
  Plug 'tpope/vim-rbenv'
  Plug 'modille/groovy.vim', { 'for': 'groovy' }
  Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
  Plug 'stephpy/vim-yaml', { 'for': 'yaml' }
  Plug 'jwalton512/vim-blade', { 'for': 'blade' }
  Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle','NERDTreeFind'] }
  Plug 'itchyny/lightline.vim'
  Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/fzf.vim'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'shougo/vimproc.vim', { 'do': 'make' }
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-endwise'
  Plug 'tomtom/tcomment_vim'
  Plug 'soramugi/auto-ctags.vim'
  Plug 'majutsushi/tagbar', { 'on': ['TagbarToggle'] }
  Plug 'jiangmiao/auto-pairs'
  Plug 'junegunn/goyo.vim' | Plug 'amix/vim-zenroom2', { 'on': ['Goyo'] }
  Plug 'tpope/vim-surround'
  Plug 'simeji/winresizer'
  Plug 't9md/vim-quickhl'
  Plug 'easymotion/vim-easymotion'
  Plug 'Yggdroot/indentLine'
  Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
  Plug 'junegunn/vim-after-object'
  Plug 'haya14busa/incsearch.vim' | Plug 'haya14busa/incsearch-easymotion.vim' | Plug 'haya14busa/incsearch-fuzzy.vim'
  " Plug 'haya14busa/is.vim' | Plug 'osyo-manga/vim-anzu' | Plug 'haya14busa/vim-asterisk'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-repeat' | Plug 'svermeulen/vim-easyclip'
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'kana/vim-textobj-user' | Plug 'terryma/vim-expand-region' | Plug 'kana/vim-textobj-line' | Plug 'kana/vim-textobj-entire'
  Plug 'elzr/vim-json', { 'for': 'json' }
  Plug 'SirVer/ultisnips'
  Plug 'Valloric/ListToggle'
  Plug 'thinca/vim-qfreplace'
  Plug 'davidhalter/jedi-vim' | Plug 'zchee/deoplete-jedi', { 'for': 'python', 'do': 'pip install jedi' }
  Plug 'lambdalisue/vim-pyenv', { 'for': ['python', 'python3'] }
  if has("nvim")
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  Plug 'wellle/tmux-complete.vim'
  Plug 'honza/vim-snippets'

  " Plug 't9md/vim-textmanip'
  " colorschemes plugins
  Plug 'jpo/vim-railscasts-theme'
  Plug 'w0ng/vim-hybrid'
  Plug 'chriskempson/vim-tomorrow-theme'
  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/seoul256.vim'
  Plug 'lifepillar/vim-solarized8'
  Plug 'kristijanhusak/vim-hybrid-material'
  Plug 'KeitaNakamura/neodark.vim'
  Plug 'rakr/vim-one'
  Plug 'joshdick/onedark.vim'

  " lint engine
  Plug 'w0rp/ale'

call plug#end()
set noshowmode

set background=dark
colorscheme hybrid

if exists("g:colors_name") && g:colors_name == "hybrid"
  hi NonText    ctermfg=243 guifg=#707880
  hi VertSplit  ctermfg=243 guifg=#707880
  hi SignColumn ctermfg=243 guifg=#707880
  hi Search     guibg=yellowgreen
end

" ~~~~~~~~~~~~~~~~~ common setting ~~~~~~~~~~~~~~
let g:vim_json_syntax_conceal = 0
let g:pymode_indent = 0
let g:tmuxcomplete#trigger = ''

if !exists('loaded_matchit')
  " matchitを有効化
  runtime macros/matchit.vim
endif

command! Pbcopy :let @*=@"  "最後にyank or 削除した内容をクリップボードに入れる
command! Pbcopy0 :let @*=@0 "最後にyankした内容をクリップボードに入れる

" Use <C-Space>. 使うときは<C-@>にマッピングする
map <C-Space>  <C-@>
cmap <C-Space>  <C-@>

" コマンドラインウィンドウとQuickfixでは実行できるようにする
function! s:returnkey()
  if expand('%h') == '[Command Line]' || &filetype == 'qf'
    execute "normal! \<CR>"
  else
    execute 'normal! '.append(expand('.'), '')."\<CR>"
  endif
endfunction
nnoremap <silent><CR> :call <sid>returnkey()<CR>

" ---- setting ale.vim ----
" check only file save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_fixers = {
      \   'python': [ 'autopep8' ],
      \   'ruby': [ 'rubocop' ],
      \}
let g:ale_linters = {
      \   'python': [ 'flake8' ],
      \}

" ---- Yank and send to clipbord --------
nnoremap YY yy:<C-U>Pbcopy0<CR>:echomsg "Copy to Clipbord!"<CR>
vnoremap YY y:<C-U>Pbcopy0<CR>:echomsg "Copy to Clipbord!"<CR>

" ---- vim-jedi ----
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>jg"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "<leader>k"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>re"

" ---- Press space twice to save --------
noremap <space><space> :<C-U>w<CR>

" ----- Tabs ----
nnoremap ]t :tabn<CR>
nnoremap [t :tabp<CR>

" ----- Buffers ----
nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>

" ----------------------------------------------------------------------------
" Quickfix
" ----------------------------------------------------------------------------
nnoremap ]q :cnext<CR>zz
nnoremap [q :cprev<CR>zz
nnoremap ]l :lnext<CR>zz
nnoremap [l :lprev<CR>zz

let g:lt_quickfix_list_toggle_map = '<F2>'

function! Strip(input_string)
  return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

" Zoom
function! s:zoom()
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
                  \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction
nnoremap <silent> <leader>z :call <sid>zoom()<CR>

" ----------------------------------------------------------------------------
" <Leader>?/! | Google it / Feeling lucky
" ----------------------------------------------------------------------------
function! s:goog(pat, lucky)
  let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
  let q = substitute(q, '[[:punct:] ]',
       \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
  call system(printf('open "https://www.google.com/search?%sq=%s"',
                   \ a:lucky ? 'btnI&' : '', q))
endfunction

nnoremap <leader>? :call <SID>goog(expand("<cword>"), 0)<cr>
nnoremap <leader>! :call <SID>goog(expand("<cWord>"), 1)<cr>
vnoremap <leader>? y:<C-U>Pbcopy0<CR> \| :call <SID>goog(expand(@"), 0)<cr>
vnoremap <leader>! y:<C-U>Pbcopy0<CR> \| :call <SID>goog(expand(@"), 1)<cr>

nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)
nmap <Space>j <Plug>(quickhl-cword-toggle)

"------------ vim-easyclip------------"
imap <c-v> <plug>EasyClipInsertModePaste
cmap <c-v> <plug>EasyClipCommandModePaste
let g:EasyClipShareYanks = 1
let g:EasyClipAutoFormat=1

" va=  visual after =
" ca=  change after =
" da=  delete after =
" ya=  yank after =
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ', '[', '<', '(', ',')
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}

let g:indentLine_faster = 1
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*', 'git*']

" ~~~~~~~~~~~~~~ctag setting~~~~~~~~~~~~~~
let g:tagbar_width = 30
" tagsジャンプの時に複数ある時は一覧表示
nmap <C-]> g<C-]>
nmap <C-W><C-]> <C-W>g<C-]>
"nmap <C-]>s :exe("stjump ".expand('<cword>'))<CR>
"nmap <C-]>v :exe("vertical stjump ".expand('<cword>'))<CR>

nmap <silent><leader>T :TagbarToggle<CR>

set tags+=.git/tags;
let g:auto_ctags_directory_list = ['.git', '.svn']
let g:auto_ctags = 1

" ============ tagbar setting =============
" see --list-kinds=Ruby
let g:tagbar_type_ruby = {
    \ 'kinds'      : ['m:modules',
                    \ 'c:classes',
                    \ 'C:constants',
                    \ 'F:singleton methods',
                    \ 'f:methods',
                    \ 'a:aliases'],
    \ 'kind2scope' : { 'c' : 'class',
                     \ 'm' : 'class' },
    \ 'ctagsbin'   : 'ctags',
    \ 'ctagsargs'  : ['-f', '-']
    \ }

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
nmap <leader><C-]> :<C-U>execute 'Gtags -r '.expand('<cWORD>')<CR>

" Switching windows
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h
noremap <silent><C-w>s :<C-u>split<CR>
noremap <silent><C-w>v :<C-u>vsplit<CR>

" ft-ruby-syntax
" see: http://vim-jp.org/vimdoc-ja/syntax.html
let ruby_operators = 1
let ruby_space_errors = 1
" let ruby_no_expensive = 1
" let ruby_spellcheck_strings = 1

" ============winresizer setting============
let g:winresizer_start_key = '<C-w>e'
let g:winresizer_vert_resize = 3
let g:winresizer_horiz_resize = 2

" Move visual block (eclipseみたいなアレ)
vnoremap <silent>J :m'>+1<CR>gv=gv
vnoremap <silent>K :m-2<CR>gv=gv
nnoremap <silent>J :m+<CR>==
nnoremap <silent>K :m-2<CR>==

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

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
hi Visual ctermbg=238 guibg=#405058
hi multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
hi link multiple_cursors_visual Visual

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
let g:EasyMotion_keys='azwsxedcrfvtgbyhnujmikol;wertyuop'

" 最初のマッチにEnterかスペースでジャンプする
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1

" prefix(trigger)
map <Leader><Leader> <Plug>(easymotion-prefix)

" s{char}{char} to move to {char}{char}
map  s <Plug>(easymotion-s2)
" nmap s <Plug>(easymotion-overwin-f2)
nmap S <Plug>(easymotion-overwin-f2)

map  <leader>f <Plug>(easymotion-bd-f)

" Move to line
map  L <Plug>(easymotion-bd-jk)
nmap L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
" nmap <Leader>w <Plug>(easymotion-overwin-w)

" Move to target within line
" lはline(１行)の意味
map  f <Plug>(easymotion-fl)
map  F <Plug>(easymotion-Fl)
map  t <Plug>(easymotion-tl)
map  T <Plug>(easymotion-Tl)

set incsearch
set hlsearch
" :h g:incsearch#auto_nohlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)zz
map N  <Plug>(incsearch-nohl-N)zz
map *  <Plug>(incsearch-nohl-*)zz
map #  <Plug>(incsearch-nohl-#)zz
map g* <Plug>(incsearch-nohl-g*)zz
map g# <Plug>(incsearch-nohl-g#)zz

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
noremap <silent><expr> / incsearch#go(<SID>incsearch_config({'prompt':'Search: '}))
noremap <silent><expr> ? incsearch#go(<SID>incsearch_config({'prompt':'Search: ','command':'?'}))

function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
        \   'converters': [incsearch#config#fuzzyword#converter()],
        \   'modules': [incsearch#config#easymotion#module()],
        \   'keymap': {"\<CR>": '<Over>(easymotion)'},
        \   'is_expr': 0,
        \   'is_stay': 1
        \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion({'prompt':'Fuzzy: '}))

" ===========is.vim=============
" map n <Plug>(is-nohl)zz<Plug>(anzu-n-with-echo)
" map N <Plug>(is-nohl)zz<Plug>(anzu-N-with-echo)
" map * <Plug>(asterisk-z*)<Plug>(is-nohl-1)zz<Plug>(anzu-update-search-status-with-echo)
" map g* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)zz<Plug>(anzu-update-search-status-with-echo)
" map #  <Plug>(asterisk-z#)<Plug>(is-nohl-1)zz<Plug>(anzu-update-search-status-with-echo)
" map g# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)zz<Plug>(anzu-update-search-status-with-echo)

" 他の.vimrcの読み込み
let s:vim_dotfiles = split(globpath('~/dotfiles/include_vimrc', '*'),'\n')
for filename in s:vim_dotfiles
  if filereadable(expand(filename))
    execute 'source' filename
  endif
endfor

hi ExtraWhitespace ctermbg=red
autocmd BufWritePre * StripWhitespace

" change foldmethod when insertmode
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" Automatic rename of tmux window
if exists('$TMUX') && !exists('$NORENAME')
  au BufEnter * if empty(&buftype) | call system('tmux rename-window "[vim]"'.expand('%:t:S')) | endif
  au VimLeave * call system('tmux set-window automatic-rename on')
endif
