return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = false,
        insert_mappings = false,
        terminal_mappings = true,
        shade_terminals = false,
      })
    end,
  },
}
