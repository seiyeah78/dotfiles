local opts = {
  defaults = {
    lazy = false,
  },
  rocks = {
    disabled = false,
    hererocks = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = false, -- get a notification when changes are found
  },
  ui = {
    border = vim.o.winborder,
  },
}
require("lazy").setup("plugins", opts)
