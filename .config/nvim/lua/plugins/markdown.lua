return {
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    'godlygeek/tabular',
    ft = { "markdown" },
  },
  {
    'dhruvasagar/vim-table-mode',
    ft = { "markdown" },
  },
  {
    'mzlogin/vim-markdown-toc',
    ft = { "markdown" },
  },
  {
    'rhysd/vim-gfm-syntax',
    ft = { "markdown" },
  }
}
