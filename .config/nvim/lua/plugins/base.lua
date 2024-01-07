return {
  'mg979/vim-visual-multi',
  'tpope/vim-obsession',
  'tpope/vim-endwise',
  'junegunn/vim-easy-align',
  'thinca/vim-qfreplace',
  'tpope/vim-abolish',
  'tpope/vim-repeat',
  {
    'kana/vim-textobj-user',
    dependencies = {
      'terryma/vim-expand-region',
      'kana/vim-textobj-line',
      'kana/vim-textobj-entire',
    }
  },
  'AndrewRadev/splitjoin.vim',
  'tyru/open-browser.vim',
  'mattn/emmet-vim',
  {
    'mtth/scratch.vim',
    config = function()
      vim.cmd([[
        let g:scratch_autohide = 0
        let g:scratch_insert_autohide = 0
        let g:scratch_no_mappings = 0
      ]])
    end
  },
  'AndrewRadev/switch.vim',
  'segeljakt/vim-silicon',
  'towolf/vim-helm',
  'nvim-lua/plenary.nvim',
  'kevinhwang91/nvim-bqf',
  'github/copilot.vim',
  'neovim/nvim-lspconfig',
  'tpope/vim-rails',
  'tpope/vim-rbenv',
  'slim-template/vim-slim',
  'tpope/vim-bundler',
  'vim-ruby/vim-ruby',
  'Vimjas/vim-python-pep8-indent',
  'vim-python/python-syntax',
  'raimon49/requirements.txt.vim',
  'rhysd/vim-gfm-syntax',
  'fatih/vim-go',
  'rust-lang/rust.vim',
  'hashivim/vim-terraform',
  {
    'NvChad/nvim-colorizer.lua',
    event = { "BufReadPre", "BufNewFile" },
  },
}
