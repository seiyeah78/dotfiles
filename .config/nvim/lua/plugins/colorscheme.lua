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
