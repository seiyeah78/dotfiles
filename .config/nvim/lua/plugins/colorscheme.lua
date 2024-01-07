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
        end
      })
      vim.cmd [[colorscheme tokyonight]]
    end
  }
}
