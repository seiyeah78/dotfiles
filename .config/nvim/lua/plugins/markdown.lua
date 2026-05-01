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
    opts = {
      file_types = { "markdown", "Avante" },
      completions = {
        lsp = { enabled = false },
        blink = { enable = false }
      },
      code = {
        sign = true,
        language_name = false,
        border = 'none'
      },
      anti_conceal = {
        enabled = false,        -- 有効化
        disabled_modes = false, -- 無効化モード
      },

    },
    ft = { "markdown", "Avante" },
  },
  {
    'jakewvincent/mkdnflow.nvim',
    ft = { "markdown", "gitcommit" },
    config = function()
      require('mkdnflow').setup({
        filetypes = {
          markdown = true,
          mdx = true,
          gitcommit = true,
        },
        mappings = {
          MkdnEnter = { { 'n', 'v' }, '<CR>' },
          MkdnExtendList = { { 'n', 'v' }, '<S-CR>' },
          MkdnGoBack = { 'n', '<BS>' },
          MkdnGoForward = { 'n', '<Del>' },
          MkdnMoveSource = { 'n', '<leader>ms' },
          MkdnNextLink = { 'n', '<Tab>' },
          MkdnPrevLink = { 'n', '<S-Tab>' },
          MkdnFollowLink = false,
          MkdnDestroyLink = { 'n', '<M-CR>' },
          MkdnTagSpan = { 'v', '<M-CR>' },
          MkdnYankAnchorLink = { 'n', 'yaa' },
          MkdnYankFileAnchorLink = { 'n', 'yfa' },
          MkdnNextHeading = { 'n', ']]' },
          MkdnPrevHeading = { 'n', '[[' },
          MkdnNextHeadingSame = { 'n', '][' },
          MkdnPrevHeadingSame = { 'n', '[]' },
          MkdnIncreaseHeading = { { 'n', 'v' }, '+' },
          MkdnDecreaseHeading = { { 'n', 'v' }, '-' },
          MkdnIncreaseHeadingOp = { { 'n', 'v' }, 'g+' },
          MkdnDecreaseHeadingOp = { { 'n', 'v' }, 'g-' },
          MkdnToggleToDo = { { 'n', 'v' }, '<C-Space>' },
          MkdnNewListItem = { 'i', '<CR>' },
          MkdnNewListItemBelowInsert = { 'n', 'o' },
          MkdnNewListItemAboveInsert = { 'n', 'O' },
          MkdnUpdateNumbering = { 'n', '<leader>nn' },
          MkdnTableNextCell = { 'i', '<Tab>' },
          MkdnTablePrevCell = { 'i', '<S-Tab>' },
          MkdnTableNextRow = false,
          MkdnTablePrevRow = { 'i', '<M-CR>' },
          MkdnTableNewRowBelow = { 'n', '<leader>ir' },
          MkdnTableNewRowAbove = { 'n', '<leader>iR' },
          MkdnTableNewColAfter = { 'n', '<leader>ic' },
          MkdnTableNewColBefore = { 'n', '<leader>iC' },
          MkdnTableDeleteRow = { 'n', '<leader>dr' },
          MkdnTableDeleteCol = { 'n', '<leader>dc' },
          MkdnFoldSection = { 'n', '<leader>f' },
          MkdnUnfoldSection = { 'n', '<leader>F' },
          MkdnTab = false,
          MkdnSTab = false,
          MkdnIndentListItem = { 'i', '<C-t>' },
          MkdnDedentListItem = { 'i', '<C-d>' },
          MkdnCreateLink = false,
          MkdnCreateLinkFromClipboard = { { 'n', 'v' }, '<leader>p' },
        },
      })
    end
  }
}
