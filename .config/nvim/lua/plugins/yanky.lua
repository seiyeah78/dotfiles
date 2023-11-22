return {
  {
    'gbprod/yanky.nvim',
    config = function()
      vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
      vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
      vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
      vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
      vim.keymap.set({ "n", "i" }, "<C-Y><C-Y>", ':Telescope yank_history<CR>', {})
      require("yanky").setup({
        {
          ring = {
            history_length = 100,
            storage = "shada",
            sync_with_numbered_registers = true,
            cancel_event = "update",
          },
          picker = {
            select = {
              action = nil, -- nil to use default put action
            },
            telescope = {
              mappings = nil, -- nil to use default mappings
            },
          },
          system_clipboard = {
            sync_with_ring = false,
          },
          highlight = {
            on_put = true,
            on_yank = true,
            timer = 200,
          },
          preserve_cursor_position = {
            enabled = true,
          },
        }
      })
    end
  }
}
