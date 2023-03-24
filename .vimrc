" vim: set foldmethod=marker foldlevel=0:
language en_us
" set ambiwidth=double
if exists('$ASDF_USER_SHIMS')
  " let g:python3_host_prog = $HOME . '/.neovim3/bin/python3'
  let g:python3_host_version = split(system("python3 --version 2>&1"))[1]
  let g:python_host_prog = $HOME . '/.asdf/shims/python2'
  let g:coc_node_path = split(system("asdf where nodejs 20.8.1"))[0] . '/bin/node'
endif
scriptencoding utf-8
set ignorecase
set smartcase
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
set t_ut=
set t_BE=
if has('nvim')
  set laststatus=3
  " set cmdheight=0
else
  set laststatus=2
endif
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
" set foldmethod=indent
" set foldlevel=2
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
set updatetime=1000
set tags+=.git/tags
set shortmess-=S
set shortmess-=s
set incsearch
set hlsearch
if has("patch-8.1.0360")
  set diffopt=internal,filler,algorithm:histogram,indent-heuristic
endif

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
    let g:vim_first_install = 1
  end
endif

if !has('gui_running')
  set lazyredraw
  set ttyfast
endif

" Setting Vim-Plug
" on : loading when execute commands
" do : execute commands after install plugins
" call plug#begin('~/.vim/plugged')
"   Plug 'junegunn/vim-plug',
"         \ {'dir': '~/.vim/plugged/vim-plug/autoload'}
"
"   function s:source_plug(file)
"     execute 'source ~/dotfiles/.vim/plugins/'.a:file
"   endfunction
"
"   call s:source_plug('common.rc.vim')
"   call s:source_plug(has('nvim') ? 'neovim.rc.vim' : 'vim.rc.vim')
"   " load another plugins for projects
"   if filereadable(glob('~/.vim/plugins.local'))
"     execute 'source ~/.vim/plugins.local'
"   endif
" call plug#end()

if has('nvim')
  execute 'source ~/.vim/plugins/vim.rc.keymappings.vim'
endif

if exists("g:vim_first_install")
  execute ":PlugInstall"
endif

set noshowmode

augroup CursorLineMod
  autocmd!
  autocmd ColorScheme night-owl highlight CursorLine ctermbg=245 guibg=#19313c
  autocmd ColorScheme night-owl highlight CursorLineNr ctermfg=248 ctermbg=235 guifg=#cfdc61 guibg=#19313c
augroup END

set background=dark
let base16colorspace=256
" colorscheme iceberg
" colorscheme base16-default-dark
" colorscheme base16-material-darker
" colorscheme OceanicNext
" colorscheme sonokai
colorscheme night-owl

" dim using tmux
if exists('$TMUX')
  function! ReturnHighlightTerm(group)
    " Store output of group to variable
    let output = execute('hi ' . a:group)
    return split(output, 'xxx ')[-1]
  endfunction

  let s:list = ['Normal', 'SignColumn', 'LineNr', 'NonText', 'SpecialKey', 'EndOfBuffer', 'shComment', 'mkdCodeDelimiter']
  let g:background_colors = {}
  for key in s:list
    try
      let s:init = ReturnHighlightTerm(key)
    catch
      continue
    endtry
    if(stridx(s:init, 'links to') == -1)
      let g:background_colors[key] = s:init
    end
  endfor

  function! UpdateBackGround(enter)
    for key in keys(g:background_colors)
      let l:setting = a:enter ? g:background_colors[key] : 'ctermbg=NONE guibg=NONE'
      execute('hi ' . key . ' '. l:setting)
    endfor
  endfunction

  autocmd FocusGained * call UpdateBackGround(v:true)
  autocmd FocusLost * call UpdateBackGround(v:false)
  command! VimShowHlGroup echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
end

if exists("g:colors_name")
  if g:colors_name == "apprentice"
    hi Comment term=bold ctermfg=243 guifg=#707880
  end
end
" ~~~~~~~~~~~~~~~~~ common setting ~~~~~~~~~~~~~~
" disable provider
let g:loaded_perl_provider = 0
let g:vim_json_syntax_conceal = 0
let g:pymode_indent = 0
let g:UltiSnipsUsePythonVersion = 3
let g:strip_whitespace_on_save = has('nvim') ? 0 : 1
let g:better_whitespace_ctermcolor='red'
let g:vim_jsx_pretty_colorful_config = 1
let g:strip_whitespace_confirm = 0
let g:indentLine_fileTypeExclude = ['tex', 'markdown']
let g:Illuminate_ftblacklist = ['nerdtree', 'git', 'gitcommit', 'fugitiveblame']
let g:gitgutter_diff_args='--diff-algorithm=histogram'
let g:silicon = {
      \   'theme':              'Nord',
      \   'font':               'RictyDiminishedDiscord Nerd Font',
      \   'output': 'silicon-{time:%Y-%m-%d-%H%M%S}.png',
      \   'background':         '#AAAAFF',
      \   'shadow-color':       '#555555',
      \   'line-pad':                   2,
      \   'pad-horiz':                 80,
      \   'pad-vert':                 100,
      \   'shadow-blur-radius':         0,
      \   'shadow-offset-x':            0,
      \   'shadow-offset-y':            0,
      \   'line-number':           v:true,
      \   'round-corner':          v:true,
      \   'window-controls':       v:true,
      \ }

" ---------------tcomment_vim setting -----------"
" disable default mappings
let g:tcomment_maps = 0
noremap <C-_><C-_> :TComment<CR>
inoremap <C-_><C-_> <C-O>:TComment<CR>
noremap <C-_>b :TCommentBlock<CR>
inoremap <C-_>b <C-\><C-O>:TCommentBlock mode=#<CR>
noremap <C-_>i v:TCommentInline mode=I#<cr>
inoremap <C-_>i <C-\><C-O>:TCommentInline mode=I#<cr>
nmap <C-_>u <Plug>(TComment_Uncommentc)
vmap <C-_>u <Plug>(TComment_Uncommentc)

command! Pbcopy :let @*=@"  "最後にyank or 削除した内容をクリップボードに入れる
command! Pbcopy0 :let @*=@0 "最後にyankした内容をクリップボードに入れる

" disable F1 for help
nmap <F1> <nop>
imap <F1> <nop>

" ESC to Normal mode in terminal
if has("nvim")
  autocmd TermOpen * tnoremap <Esc> <C-\><C-N>
endif

"ctrl-j to ESC
imap <C-J> <ESC>

" Use <C-Space>. 使うときは<C-@>にマッピングする
map <C-Space>  <C-@>
cmap <C-Space>  <C-@>

" ---- setting ale.vim ----
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_fixers = {
      \ 'python': [ 'autopep8' ],
      \ 'ruby': [ 'rubocop' ],
      \ 'javascript': [ 'eslint-plugin-prettier' ],
      \}
let g:ale_linters = {
      \ 'python': [ 'flake8' ],
      \ 'php': [ 'php', 'phpmd' ],
      \ 'javascript': [ 'eslint' ],
      \}
let g:ale_php_phpmd_ruleset = 'codesize,design,naming,unusedcode'

" ---- Yank and send to clipbord --------
nnoremap YY yy:<C-U>Pbcopy0<CR>:echomsg "Copy to Clipbord!"<CR>
vnoremap YY y:<C-U>Pbcopy0<CR>:echomsg "Copy to Clipbord!"<CR>

" these Ctrl mappings work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

function! DockerTransform(cmd) abort
  return DockerCommand().a:cmd
endfunction

" make test commands execute using dispatch.vim
let test#strategy = "dispatch"
let g:test#custom_transformations = {'docker': function('DockerTransform')}
let g:test#transformation = 'docker'

if !exists('g:dispatch_compilers')
  let g:dispatch_compilers = {}
endif

let g:dispatch_compilers = {
      \ 'docker-compose exec -T app ': '',
      \ 'docker-compose run --rm -T app ': '',
      \ }

" ---- Press space twice to save --------
noremap <space><space> :<C-U>w<CR>

" ----- Tabs ----
nnoremap ]t :tabn<CR>
nnoremap [t :tabp<CR>

" ----- Buffers ----
nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>

nnoremap ]q :cnext<CR>zz
nnoremap [q :cprev<CR>zz
nnoremap ]l :lnext<CR>zz
nnoremap [l :lprev<CR>zz

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

let g:indentLine_faster = 1
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*', 'git*']

" ------------ ctag setting ------------
" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]>
nnoremap <C-W><C-]> <C-W>g<C-]>

let g:vista#executives = ['coc']
let g:vista_default_executive = 'coc'
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1
let g:vista_echo_cursor_strategy = 'floating_win'

let g:vista_fzf_preview = ['right:50%']
nmap <silent><leader>T :Vista!!<CR>

" Switching windows
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h
noremap <silent><C-w>s :<C-u>split<CR>
noremap <silent><C-w>v :<C-u>vsplit<CR>

" ----------- winresizer setting -------------
let g:winresizer_start_key = '<C-w>e'
let g:winresizer_vert_resize = 3
let g:winresizer_horiz_resize = 2

" Move visual block (eclipseみたいなアレ)
vnoremap <silent>J :m'>+1<CR>gv=gv
vnoremap <silent>K :m-2<CR>gv=gv
nnoremap <silent>J :m+<CR>==
nnoremap <silent>K :m-2<CR>==

" command line mode moving
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>

cnoremap <C-x> <C-f>

" insert mode moving
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Open current line on GitHub
nnoremap <Leader>go :GBrowse<CR>
vnoremap <Leader>go :GBrowse<CR>
nnoremap <Leader>gv :GV!<CR>

" git add current file
noremap <Leader>gs :Git<CR>
noremap <Leader>gF :GFiles?<CR>
noremap <Leader>gb :Git blame<CR>
noremap <Leader>gd :Gvdiff<CR>
nmap ]g <Plug>(GitGutterNextHunk)
nmap [g <Plug>(GitGutterPrevHunk)

" =============== vim-visual-multi ============
let g:VM_manual_infoline = 0
let g:VM_leader=','
let g:VM_maps = {}
" let g:VM_maps["Add Cursor At Word"] = 'g<cr>'
let g:VM_maps["Add Cursor Up"]   = '<M-k>'
let g:VM_maps["Add Cursor Down"] = '<M-j>'
"
function! VM_Start()
  HighlightedyankOff
endfunction
fun! VM_Exit()
  HighlightedyankOn
endfun

"=============vim-easy-align setting============
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
nmap <C-w>m <Plug>(git-messenger)
let g:git_messenger_include_diff = 'current'
let g:git_messenger_always_into_popup = v:true
let g:git_messenger_max_popup_height = 100
function! s:setup_git_messenger_popup() abort
  " Your favorite configuration here
  " For example, set go back/forward history to <C-o>/<C-i>
  nmap <buffer><ESC> q
  nmap <buffer><C-o> o
  nmap <buffer><C-i> O
endfunction
autocmd FileType gitmessengerpopup call <SID>setup_git_messenger_popup()

" ------------- scratch.vim ----------------
let g:scratch_autohide = 0
let g:scratch_insert_autohide = 0
let g:scratch_no_mappings = 0
nmap gs :<C-U>Scratch<CR>
xmap gs <plug>(scratch-selection-reuse)

" -------- switch.vim --------
let g:switch_mapping = ''
function! s:Switching(reverse)
  let opt = a:reverse ? [{'reverse': 1}, "\<C-X>"] : [{}, "\<C-A>"]
  let char = matchstr(getline('.'), '\%' . col('.') . 'c.')

  if char =~# '^\d\+$'
    execute "normal! ".opt[1]
    return
  endif

  if !switch#Switch(opt[0])
    execute "normal! ".opt[1]
  end
endfunction
nnoremap <silent><C-A> :call <SID>Switching(v:false)<CR>
nnoremap <silent><C-X> :call <SID>Switching(v:true)<CR>

" 他の.vimrcの読み込み
let s:vim_dotfiles = split(globpath('~/dotfiles/include_vimrc', '*'),'\n')
for filename in s:vim_dotfiles
  if filereadable(expand(filename))
    execute 'source' filename
  endif
endfor

" https://github.com/wellle/targets.vim/issues/257
let g:targets_nl = ['n', 'N']

function! s:toggle_conceal(arg, is_bang)
  let level = &conceallevel
  let toggle = level != 0 ? 0 : 2
  let &conceallevel=toggle
endfunction
command! -bang -nargs=* ToggleConceal call s:toggle_conceal(<q-args>, <bang>0)

" change foldmethod when insertmode
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
" autocmd BufWritePre * normal :StripWhiteSpace

command! Jqf %!jq '.'
