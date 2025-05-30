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
vim.o.regexpengine = 0
vim.o.winborder = 'bold'
set.signcolumn = 'yes'
set.regexpengine = 0
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
set.wildmode = { "longest:full", "full" }
set.wrapscan = true
-- set.updatetime = 1000
set.tags:append(".git/tags")
set.shortmess:remove({ 's', 'S' })
set.incsearch = true
set.hlsearch = true
set.diffopt = "internal,filler,algorithm:histogram,indent-heuristic"
-- set.lazyredraw = true
set.ttyfast = true
set.wildmenu = true
