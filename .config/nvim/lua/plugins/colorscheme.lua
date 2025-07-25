return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require('tokyonight').setup({
        style = "storm",
        styles = {
          comments = { italic = false },
        },
        -- defaultでは境界線の色がないため
        on_colors = function(colors)
          colors.border = "#565f89"
        end,
        on_highlights = function(hl, colors)
          hl.CursorLineNr = { fg = colors.yellow }
          hl.LineNr = { fg = "#8186a3" }
          hl.IncSearch = { fg = "#1d202f", bg = "#cc7e50" }
        end
      })
      vim.cmd [[colorscheme tokyonight]]
    end
  },
  -- {
  --   "scottmckendry/cyberdream.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("cyberdream").setup({
  --       -- Set light or dark variant
  --       variant = "dark", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`
  --
  --       -- Enable transparent background
  --       transparent = true,
  --
  --       -- Reduce the overall saturation of colours for a more muted look
  --       saturation = 0.5, -- accepts a value between 0 and 1. 0 will be fully desaturated (greyscale) and 1 will be the full color (default)
  --
  --       -- Enable italics comments
  --       italic_comments = false,
  --
  --       -- Replace all fillchars with ' ' for the ultimate clean look
  --       hide_fillchars = false,
  --
  --       -- Apply a modern borderless look to pickers like Telescope, Snacks Picker & Fzf-Lua
  --       borderless_pickers = false,
  --
  --       -- Set terminal colors used in `:terminal`
  --       terminal_colors = true,
  --
  --       -- Improve start up time by caching highlights. Generate cache with :CyberdreamBuildCache and clear with :CyberdreamClearCache
  --       cache = false,
  --
  --       -- Override highlight groups with your own colour values
  --
  --       -- Override colors
  --       -- Disable or enable colorscheme extensions
  --       extensions = {
  --         telescope = true,
  --         notify = true,
  --       },
  --     })
  --     -- vim.cmd [[colorscheme cyberdream]]
  --   end
  -- }
  -- {
  --   "asiryk/auto-hlsearch.nvim",
  --   config = function()
  --     require("auto-hlsearch").setup({
  --       remap_keys = { "/", "?", "*", "#", "n", "N" },
  --       create_commands = true,
  --       pre_hook = function()
  --       end,
  --       post_hook = function()
  --       end,
  --     })
  --     vim.api.nvim_create_autocmd('BufEnter', {
  --       pattern = '*',
  --       callback = function()
  --         if vim.bo.filetype == 'ruby' then
  --           -- vim.cmd("AutoHlsearchEnable")
  --           -- vim.cmd("set hlsearch")
  --         end
  --       end
  --     })
  --     vim.api.nvim_create_autocmd('BufLeave', {
  --       pattern = '*',
  --       callback = function()
  --         if vim.bo.filetype == 'ruby' then
  --           -- vim.cmd("AutoHlsearchDisable")
  --         end
  --       end
  --     })
  --   end
  -- }
}
