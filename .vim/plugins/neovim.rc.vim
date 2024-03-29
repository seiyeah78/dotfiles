function! UpdateRemotePlugins(...)
  " Needed to refresh runtime files
  let &rtp=&rtp
  UpdateRemotePlugins
endfunction

Plug 'nvim-lua/plenary.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'kevinhwang91/nvim-bqf'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'github/copilot.vim'
Plug 'keaising/im-select.nvim'
Plug 'm-demare/hlargs.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'romgrk/nvim-treesitter-context'
Plug 'windwp/nvim-autopairs'
Plug 'cappyzawa/trim.nvim'

" Plug 'wookayin/semshi', {'do': ':UpdateRemotePlugins', 'for': 'python'}
let g:semshi#error_sign = v:false
let g:semshi#tolerate_syntax_errors = v:false
let g:semshi#excluded_hl_groups = ['local', 'unresolved', 'attribute', 'builtin', 'free', 'global']

Plug 'kyazdani42/nvim-web-devicons'
Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
" Plug 'folke/trouble.nvim'
Plug 'neovim/nvim-lspconfig'
