local opts = {
  defaults = {
    lazy = false,
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
}
require("lazy").setup("plugins", opts)
