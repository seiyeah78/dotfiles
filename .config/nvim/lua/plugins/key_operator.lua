return {
  {
    'gbprod/cutlass.nvim',
    opts = {
      cut_key = "m",
      override_del = true,
      exclude = {},
      registers = {
        select = "_",
        delete = "_",
        change = "_",
      },
    }
  },
  {
    'gbprod/yanky.nvim',
    event = "VeryLazy",
    config = function()
      -- optsだとうまく反映されない
      require("yanky").setup({
        ring = {
          history_length = 1000,
          storage = "shada",
          storage_path = vim.fn.stdpath("data") .. "/databases/yanky.db", -- Only for sqlite storage
          sync_with_numbered_registers = true,
          cancel_event = "update",
          ignore_registers = { "_" },
          update_register_on_cycle = false,
        },
        picker = {
          select = {
            action = nil, -- nil to use default put action
          },
          telescope = {
            use_default_mappings = true, -- if default mappings should be used
            mappings = nil,              -- nil to use default mappings or no mappings (see `use_default_mappings`)
          },
        },
        system_clipboard = {
          sync_with_ring = true,
        },
        highlight = {
          on_put = false,
          on_yank = false,
          timer = 500,
        },
        preserve_cursor_position = {
          enabled = true,
        },
        textobj = {
          enabled = true,
        },
      })
      -- YankyPutBeforeにするとregisterに登録されない
      vim.keymap.set({ 'x' }, 'p', '<Plug>(YankyPutBefore)')
      vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
      vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
      vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
      vim.keymap.set("i", "<C-Y><C-Y>", '<C-O>:<C-U>Telescope yank_history<CR>', {})
      vim.keymap.set("n", "<C-Y><C-Y>", ':<C-U>Telescope yank_history<CR>', {})
    end
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },
  {
    'Wansmer/treesj',
    event = "VeryLazy",
    keys = { '<space>m', '<space>j', '<space>s' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = true
  }
}
