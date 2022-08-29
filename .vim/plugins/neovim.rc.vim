Plug 'nvim-lua/plenary.nvim'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'kevinhwang91/nvim-bqf'
Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'chipsenkbeil/distant.nvim'
" Plug 'github/copilot.vim'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'romgrk/nvim-treesitter-context'
Plug 'windwp/nvim-autopairs'

" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': 'python'}
let g:semshi#error_sign = v:false
let g:semshi#tolerate_syntax_errors = v:false
let g:semshi#excluded_hl_groups = ['local', 'unresolved', 'attribute', 'builtin', 'free', 'global']

Plug 'kyazdani42/nvim-web-devicons'
" Plug 'folke/trouble.nvim'
Plug 'neovim/nvim-lspconfig'
