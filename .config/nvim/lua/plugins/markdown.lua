return {
  lazy = true,
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    'godlygeek/tabular',
  },
  {
    'dhruvasagar/vim-table-mode',
  },
  {
    'mzlogin/vim-markdown-toc',
  },
}
