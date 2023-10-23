return {
  'mg979/vim-visual-multi',
  {
    'haya14busa/vim-asterisk',
    event = 'VeryLazy',
    config = function()
      vim.cmd([[
        map *  <Plug>(asterisk-z*)
        map #  <Plug>(asterisk-z#)
        map g* <Plug>(asterisk-gz*)
        map g# <Plug>(asterisk-gz#)
      ]])
    end
  },
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
  'AndrewRadev/switch.vim',
  'segeljakt/vim-silicon',
  'towolf/vim-helm',
  'nvim-lua/plenary.nvim',
  'kevinhwang91/nvim-bqf',
  'github/copilot.vim',
  'tpope/vim-rails',
  'tpope/vim-rbenv',
  'slim-template/vim-slim',
  'tpope/vim-bundler',
  'vim-ruby/vim-ruby',
  'Vimjas/vim-python-pep8-indent',
  'vim-python/python-syntax',
  'raimon49/requirements.txt.vim',
  { 'fatih/vim-go',           ft = "go" },
  { 'rust-lang/rust.vim',     ft = 'rust' },
  { 'hashivim/vim-terraform', ft = 'terraform' },
  {
    'NvChad/nvim-colorizer.lua',
    event = { "BufReadPre", "BufNewFile" },
  },
}
