return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      input = {
        enabled = true,
      },
      picker = {
        enabled = true,
        -- 必要に応じて vim.ui.select を snacks に置き換える
        ui_select = true,
      },
      styles = {
        input = {
          -- Change position relative to the cursor
          relative = "cursor",
          -- Default fallbacks if you want to keep them centered instead:
          -- relative = "editor",
          -- row = 2,
        }
      }
    }
  }
}
