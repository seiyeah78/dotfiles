if has('nvim-0.5')
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'lewis6991/gitsigns.nvim'

  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
end

Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': 'python'}
let g:semshi#error_sign = v:false
let g:semshi#tolerate_syntax_errors = v:false
let g:semshi#excluded_hl_groups = ['local', 'unresolved', 'attribute', 'builtin', 'free', 'global']

Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'neovim/nvim-lspconfig'
