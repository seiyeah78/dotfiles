vim.cmd("autocmd!")
vim.cmd('language en_US')
vim.scriptencoding = "utf-8"
vim.lsp.set_log_level("off")
-- vim.o.{option}: :let &{option-name}のように動作します
-- vim.go.{option}: :let &g:{option-name}のように動作します
-- vim.bo.{option}: バッファローカルオプションの場合:let &l:{option-name}のように動作します
-- vim.wo.{option}: ウィンドウローカルオプションの場合:let &l:{option-name}のように動作します
-- vim.opt.{option}: :setのように動作します
-- vim.opt_global.{option}: :setglobalのように動作します
-- vim.opt_local.{option}: :setlocalのように動作します
local set = vim.opt

vim.g.editorconfig = true
set.signcolumn = 'yes'
set.cursorline = true
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
set.lazyredraw = true
set.ttyfast = true
-- vim.o.t_8f = "<Esc>[38;2;%lu;%lu;%lum"
-- vim.o.t_8b = "<Esc>[48;2;%lu;%lu;%lum"
-- set.termguicolors = true
-- if vim.fn.exists('$TMUX') then
--   vim.o.t_SI = "<Esc>Ptmux;<Esc><Esc>]50;CursorShape=1x7<Esc>"
--   vim.o.t_EI = "<Esc>Ptmux;<Esc><Esc>]50;CursorShape=0x7<Esc>"
-- else
--   vim.o.t_SI = "<Esc>]50;CursorShape=1x7"
--   vim.o.t_EI = "<Esc>]50;CursorShape=0x7"
-- end
-- if vim.fn.has('gui_running') then
--   set.ttyfast = true
-- end
-- if vim.fn.exists('$ASDF_USER_SHIMS') then
--   let_g.python_host_prog = vim.env.HOME .. '/.asdf/shims/python2'
--   vim.cmd([[
--     let g:python3_host_version = split(system("python3 --version 2>&1"))[1]
--     let g:coc_node_path = split(system("asdf where nodejs 20.8.1"))[0] . '/bin/node'
--   ]])
-- end

-- ハイライト
-- https://jdhao.github.io/2020/09/22/highlight_groups_cleared_in_nvim/
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, 'TextYankPostColor', {
      bg = "#56514e",
    })
  end,
})
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "TextYankPostColor", timeout = 500 })
  end,
  desc = "Highlight yank",
})

-- vim.api.nvim_create_autocmd("TermOpen", {
--   pattern = "*",
--   callback = function()
--     vim.keymap.set("t", "<ESC>", "<C-\\><C-N>", { noremap = true })
--   end,
-- })


vim.cmd([[
" jqによるフォーマット"
command! Jqf %!jq '.'

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

" ==============terminal setting==========
let g:terminal_color_0  = "#1b2b34" "black
let g:terminal_color_1  = "#ed5f67" "red
let g:terminal_color_2  = "#9ac895" "green
let g:terminal_color_3  = "#fbc963" "yellow
let g:terminal_color_4  = "#669acd" "blue
let g:terminal_color_5  = "#c695c6" "magenta
let g:terminal_color_6  = "#5fb4b4" "cyan
let g:terminal_color_7  = "#c1c6cf" "white
let g:terminal_color_background="#1b2b34" "background
let g:terminal_color_foreground="#c1c6cf" "foreground

" dim using tmux
if exists('$TMUX')
  function! ReturnHighlightTerm(group)
    " Store output of group to variable
    let output = execute('hi ' . a:group)
    return split(output, 'xxx ')[-1]
  endfunction

  let g:background_colors = {}
  function! StoreBackGroundColors()
    let s:list = ['Normal', 'SignColumn', 'LineNr', 'NonText', 'SpecialKey', 'EndOfBuffer', 'shComment', 'mkdCodeDelimiter']

    for key in s:list
      try
        let s:init = ReturnHighlightTerm(key)
      catch
        continue
      endtry
      if(stridx(s:init, 'links to') == -1)
        let g:background_colors[key] = s:init == 'cleared' ? 'NONE' : s:init
      end
    endfor
  endfunction

  function! UpdateBackGround(enter)
    if empty(g:background_colors)
      return
    end
    for key in keys(g:background_colors)
      let l:setting = a:enter ? g:background_colors[key] : 'ctermbg=NONE guibg=NONE'
      execute('hi ' . key . ' '. l:setting)
    endfor
  endfunction

  " ColorSchemeがアタッチされてから取得する
  autocmd ColorScheme * call StoreBackGroundColors()
  autocmd FocusGained * call UpdateBackGround(v:true)
  autocmd FocusLost * call UpdateBackGround(v:false)
  command! VimShowHlGroup echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
end

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
