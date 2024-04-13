return {
  'mg979/vim-visual-multi',
  'tpope/vim-obsession',
  {
    'junegunn/vim-easy-align',
    keys = {
      { "<leader>ga", ":EasyAlign<CR>", mode = { "x", "n" } },
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
  {
    'kevinhwang91/nvim-bqf',
    config = function()
      require('bqf').setup({
        auto_enable = true,
        auto_resize_height = true, -- highly recommended enable
        preview = {
          delay_syntax = 80,
          border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
          show_title = false,
          should_preview_cb = function(bufnr, qwinid)
            local ret = true
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            local fsize = vim.fn.getfsize(bufname)
            if fsize > 100 * 1024 then
              -- skip file size greater than 100k
              ret = false
            elseif bufname:match('^fugitive://') then
              -- skip fugitive buffer
              ret = false
            end
            return ret
          end
        },
        -- make `drop` and `tab drop` to become preferred
        func_map = {
          drop = 'o',
          openc = 'O',
          split = '<C-s>',
          tabdrop = '<C-t>',
          -- set to empty string to disable
          tabc = '',
          ptogglemode = 'z,',
        },
        filter = {
          fzf = {
            action_for = { ['ctrl-s'] = 'split' },
            extra_opts = { '--bind', 'ctrl-o:toggle-all', '--prompt', 'fzf mode> ' }
          }
        }
      })
    end
  },
  { 'raimon49/requirements.txt.vim' },
  { 'Vimjas/vim-python-pep8-indent', ft = 'python' },
  { 'vim-python/python-syntax',      ft = 'python' },
  { 'tpope/vim-rails',               ft = 'ruby' },
  { 'tpope/vim-rbenv',               ft = 'ruby' },
  { 'slim-template/vim-slim',        ft = 'ruby' },
  { 'tpope/vim-bundler',             ft = 'ruby' },
  { 'vim-ruby/vim-ruby',             ft = 'ruby' },
  { 'fatih/vim-go',                  ft = "go" },
  { 'rust-lang/rust.vim',            ft = 'rust' },
  { 'hashivim/vim-terraform',        ft = 'terraform' },
  {
    'NvChad/nvim-colorizer.lua',
    event = { "BufReadPre", "BufNewFile" },
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
