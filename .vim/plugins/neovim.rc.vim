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
Plug 'chipsenkbeil/distant.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'github/copilot.vim'
Plug 'keaising/im-select.nvim'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'romgrk/nvim-treesitter-context'
Plug 'windwp/nvim-autopairs'
Plug 'cappyzawa/trim.nvim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
" Plug 'folke/trouble.nvim'
Plug 'neovim/nvim-lspconfig'
