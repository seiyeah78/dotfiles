vim.cmd("autocmd!")
vim.scriptencoding = "utf-8"
vim.language = "en_us"
-- vim.o.{option}: :let &{option-name}のように動作します
-- vim.go.{option}: :let &g:{option-name}のように動作します
-- vim.bo.{option}: バッファローカルオプションの場合:let &l:{option-name}のように動作します
-- vim.wo.{option}: ウィンドウローカルオプションの場合:let &l:{option-name}のように動作します
-- vim.opt.{option}: :setのように動作します
-- vim.opt_global.{option}: :setglobalのように動作します
-- vim.opt_local.{option}: :setlocalのように動作します
local let_g = vim.go
local set = vim.opt

set.number = true
set.ignorecase = true
set.smartcase = true
set.fixeol = false
set.encoding = "utf-8"
set.fileencodings = "utf-8"
set.fenc = "utf-8"
set.shiftwidth = 2
set.tabstop = 2
set.softtabstop = 2
set.expandtab = true
set.autoindent = true
set.smartindent = true
set.errorbells = false
set.fileformat = "unix"
-- set.vb = "t_vb="
-- set.t_Co = 256
-- set.t_ut = nil
-- set.t_BE = nil
set.laststatus = 3
set.showmode = false
set.backspace = "indent,eol,start"
set.splitbelow = true
set.splitright = true
set.list = true
set.listchars = 'tab:¦_'
set.scrolloff = 4
-- １行辺りsyntax解析する文字数
set.synmaxcol = 600
set.guifont = "Ricty Regular for Powerline:h5"
set.guifontwide = "Ricty Regular for Powerline:h5"
-- normalモードへの時間を短縮する
set.timeout = true
set.timeoutlen = 1000
set.ttimeoutlen = 50
set.swapfile = false
set.backup = false
set.compatible = false
set.switchbuf = "useopen"
-- don't open scratch window when start complete
set.completeopt:remove("preview")
-- .un(undoファイル)の保存場所
set.undodir = vim.env.HOME .. "/.vim/undodir"
set.undofile = true
set.hidden = true
set.wildmenu = true
-- like bash complete with tab
set.wildmode = "longest,full"
set.wrapscan = true
set.updatetime = 1000
set.tags:append(".git/tags")
set.shortmess:remove({ 's', 'S' })
set.incsearch = true
set.hlsearch = true
set.diffopt = "internal,filler,algorithm:histogram,indent-heuristic"
vim.o.t_8f = "<Esc>[38;2;%lu;%lu;%lum"
vim.o.t_8b = "<Esc>[48;2;%lu;%lu;%lum"
set.termguicolors = true
if vim.fn.exists('$TMUX') then
  vim.o.t_SI = "<Esc>Ptmux;<Esc><Esc>]50;CursorShape=1x7<Esc>"
  vim.o.t_EI = "<Esc>Ptmux;<Esc><Esc>]50;CursorShape=0x7<Esc>"
else
  vim.o.t_SI = "<Esc>]50;CursorShape=1x7"
  vim.o.t_EI = "<Esc>]50;CursorShape=0x7"
end
if vim.fn.has('gui_running') then
  set.lazyredraw = true
  set.ttyfast = true
end
if vim.fn.exists('$ASDF_USER_SHIMS') then
  let_g.python_host_prog = vim.env.HOME .. '/.asdf/shims/python2'
  vim.cmd([[
    let g:python3_host_version = split(system("python3 --version 2>&1"))[1]
    let g:coc_node_path = split(system("asdf where nodejs 20.8.1"))[0] . '/bin/node'
  ]])
end


vim.cmd([[
" カーソルの位置を復元する
  augroup redhat
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
    autocmd FileType pullrequest normal! gg0
    autocmd FileType gitcommit normal! gg0
    autocmd VimEnter COMMIT_EDITMSG  normal! gg0
  augroup END

  " Automatic rename of tmux window
  if exists('$TMUX') && !exists('$NORENAME')
    au BufEnter * if empty(&buftype) | call system('tmux rename-window "[vim]"'.expand('%:t:S')) | endif
    au VimLeave * call system('tmux set-window automatic-rename on')
  endif
" ----------- matchup plugin setting ---------------
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_offscreen = {'method': 'popup'}
hi MatchParen ctermfg=166 guifg=darkorange2 cterm=italic gui=italic
hi MatchParenCur cterm=NONE gui=NONE
hi MatchWord ctermfg=166 guifg=darkorange2 cterm=NONE gui=NONE
hi MatchWordCur cterm=underline gui=underline

" ----------- highlightedyank setting ----------------
let g:highlightedyank_highlight_duration = 500
hi HighlightedyankRegion ctermbg=22 guibg=#005f00

" ------------vim-illuminate setting-----------------
hi illuminatedWord ctermbg=239 guibg=Gray30
hi IlluminatedWordText ctermbg=239 guibg=Gray30
hi IlluminatedWordRead ctermbg=239 guibg=Gray30
hi IlluminatedWordWrite ctermbg=239 guibg=Gray30
let g:Illuminate_highlightUnderCursor = 0
let g:Illuminate_delay = 800

" ----- indent blankline -------
" let g:indent_blankline_colorful = 1
let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_viewport_buffer = 10
" let g:indent_blankline_vscode_rainbow_mode = 0

" ==============terminal setting==========

  let g:terminal_color_0  = "#1b2b34" "black
  let g:terminal_color_1  = "#ed5f67" "red
  let g:terminal_color_2  = "#9ac895" "green
  let g:terminal_color_3  = "#fbc963" "yellow
  let g:terminal_color_4  = "#669acd" "blue
  let g:terminal_color_5  = "#c695c6" "magenta
  let g:terminal_color_6  = "#5fb4b4" "cyan
  let g:terminal_color_7  = "#c1c6cf" "white
  " let g:terminal_color_8  = "#65737e" "bright black
  " let g:terminal_color_9  = "#fa9257" "bright red
  " let g:terminal_color_10 = "#343d46" "bright green
  " let g:terminal_color_11 = "#4f5b66" "bright yellow
  " let g:terminal_color_12 = "#a8aebb" "bright blue
  " let g:terminal_color_13 = "#ced4df" "bright magenta
  " let g:terminal_color_14 = "#ac7967" "bright cyan
  " let g:terminal_color_15 = "#d9dfea" "bright white
  let g:terminal_color_background="#1b2b34" "background
  let g:terminal_color_foreground="#c1c6cf" "foreground

" indent setting
augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.jbuilder   set filetype=ruby
  autocmd BufNewFile,BufRead Guardfile    set filetype=ruby
  autocmd BufNewFile,BufRead Gemfile      set filetype=ruby
  autocmd BufNewFile,BufRead Gemfile.lock set filetype=ruby
  autocmd BufNewFile,BufRead .pryrc       set filetype=ruby
  " ?つきメソッド、@@インスタンスを単語とみなす
  autocmd FileType eruby  setlocal isk+=@-@,?,!
  autocmd FileType slim   setlocal isk+=@-@,?,!
  autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType blade  setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType php    setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType java   setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType groovy setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType go     setlocal tabstop=4 softtabstop=4 noexpandtab   shiftwidth=4
augroup END
]])
