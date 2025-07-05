return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "godlygeek/tabular",
    ft = { "markdown" },
  },
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
  },
  {
    "mzlogin/vim-markdown-toc",
    ft = { "markdown" },
  },
  {
    -- Make sure to set this up properly if you have lazy=true
    "MeanderingProgrammer/render-markdown.nvim",
    tag = "v8.5.0",
    opts = {
      file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
  },
}
