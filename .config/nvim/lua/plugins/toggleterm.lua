return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<C-\>]],
        insert_mappings = false,
        terminal_mappings = true,
        shade_terminals = false,
      })
    end,
  },
}
