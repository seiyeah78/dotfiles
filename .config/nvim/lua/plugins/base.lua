return {
  'mg979/vim-visual-multi',
  'tpope/vim-obsession',
  {
    'junegunn/vim-easy-align',
    keys = {
      { "<leader>ea", ":EasyAlign<CR>", mode = { "x", "n" } },
    },
    cmd = { 'EasyAlign' },
  },
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
  {
    "krivahtoo/silicon.nvim",
    build = "./install.sh build",
    cmd = 'Silicon',
    config = function()
      require('silicon').setup({})
    end,
  },
  'towolf/vim-helm',
  'nvim-lua/plenary.nvim',
  { 'raimon49/requirements.txt.vim' },
  { 'Vimjas/vim-python-pep8-indent', ft = 'python' },
  { 'vim-python/python-syntax',      ft = 'python' },
  { 'tpope/vim-rails',               ft = 'ruby' },
  { 'tpope/vim-rbenv',               ft = 'ruby' },
  { 'slim-template/vim-slim',        ft = 'ruby' },
  { 'tpope/vim-bundler',             ft = 'ruby' },
  { 'vim-ruby/vim-ruby',             ft = 'ruby' },
  -- { 'fatih/vim-go',                  ft = "go" },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        lsp_inlay_hints = {
          enable = false
        },
        diagnostic = false, -- for lspsaga
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  { 'rust-lang/rust.vim',     ft = 'rust' },
  { 'hashivim/vim-terraform', ft = 'terraform' },
  {
    'NvChad/nvim-colorizer.lua',
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      filetypes = {
        '*', -- Highlight all files, but customize some others.
        "!help",
        "!dashboard",
        "!dashpreview",
        "!NvimTree",
        "!coc-explorer",
      },
    }
  },
  -- {
  --   "wookayin/semshi",
  --   build = ":UpdateRemotePlugins",
  --   version = "*",    -- Recommended to use the latest release
  --   init = function() -- example, skip if you're OK with the default config
  --     vim.g['semshi#error_sign'] = false
  --   end,
  -- }
}
