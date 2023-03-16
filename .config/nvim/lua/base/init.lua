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
    let g:coc_node_path = split(system("asdf where nodejs 16.17.1"))[0] . '/bin/node'
  ]])
end
