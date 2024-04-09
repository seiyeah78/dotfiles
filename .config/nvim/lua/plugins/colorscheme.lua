return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require('tokyonight').setup({
        style = "storm",
        -- defaultでは境界線の色がないため
        on_colors = function(colors)
          colors.border = "#565f89"
        end,
        on_highlights = function(hl, colors)
          hl.CursorLineNr = { fg = colors.yellow }
          hl.LineNr = { fg = "#8186a3" }
        end
      })
      vim.cmd [[colorscheme tokyonight]]
    end
  }
}
