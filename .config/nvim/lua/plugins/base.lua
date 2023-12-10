return {
  { 'neoclide/coc.nvim', branch = 'release' },
  'mg979/vim-visual-multi',
  'tpope/vim-obsession',
  'tpope/vim-endwise',
  'junegunn/vim-easy-align',
  'honza/vim-snippets',
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
  {
    'andymass/vim-matchup',
    config = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      vim.api.nvim_set_hl(0, 'MatchParen', { fg = "darkorange2" })
      vim.api.nvim_set_hl(0, 'MatchWord', { fg = "darkorange2" })
      vim.api.nvim_set_hl(0, 'MatchWordCur', { underline = true })
      vim.api.nvim_set_hl(0, 'MatchParenCur', {}) -- NONEと同じ
    end
  },
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
  'iamcco/markdown-preview.nvim',
  'godlygeek/tabular',
  'dhruvasagar/vim-table-mode',
  'mzlogin/vim-markdown-toc',
  'rhysd/vim-gfm-syntax',
  'fatih/vim-go',
  'rust-lang/rust.vim',
  'hashivim/vim-terraform',
  'NvChad/nvim-colorizer.lua',
}
