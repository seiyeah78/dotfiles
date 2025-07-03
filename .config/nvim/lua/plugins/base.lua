return {
  'mg979/vim-visual-multi',
  {
    'junegunn/vim-easy-align',
    keys = {
      { "<leader>ea", ":EasyAlign<CR>", mode = { "x", "n" } },
    },
    cmd = { 'EasyAlign' },
  },
  'tpope/vim-repeat',
  'AndrewRadev/splitjoin.vim',
  'tyru/open-browser.vim',
  'mattn/emmet-vim',
  {
    'AndrewRadev/switch.vim',
    event = 'VeryLazy'
  },
  {
    "krivahtoo/silicon.nvim",
    build = "./install.sh",
    cmd = 'Silicon',
    config = true,
  },
  'towolf/vim-helm',
  { 'raimon49/requirements.txt.vim' },
  { 'Vimjas/vim-python-pep8-indent', ft = 'python' },
  { 'vim-python/python-syntax',      ft = 'python' },
  { 'tpope/vim-rails',               ft = 'ruby' },
  { 'slim-template/vim-slim',        ft = 'ruby' },
  { 'vim-ruby/vim-ruby',             ft = 'ruby' },
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
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false,   -- This plugin is already lazy
    ft = { 'rust' },
  },
  {
    'brenoprata10/nvim-highlight-colors',
    event = "BufEnter",
    opts = {
      exclude_filetypes = {
        "help",
        "dashboard",
        "dashpreview",
        "NvimTree",
        "coc-explorer",
      },
      exclude_buftypes = {}
    }
  }
}
