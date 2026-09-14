return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      input = {
        enabled = true,
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
