return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall" },
    event = { "WinNew", "WinLeave", "BufRead" },
    config = function()
      require("mason").setup({})
    end,
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "neovim/nvim-lspconfig" },
    },
    config = function()
      require('mason-lspconfig').setup_handlers({ function(server)
        local opt = {
          capabilities = require('cmp_nvim_lsp').default_capabilities(
            vim.lsp.protocol.make_client_capabilities()
          )
        }
        require('lspconfig')[server].setup(opt)
      end })
    end
  },
  {
    'L3MON4D3/LuaSnip',
    dependencies = {'saadparwaiz1/cmp_luasnip'}
  },
  {
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'zbirenbaum/copilot-cmp'},
      },
      keys = {
        { "D",  "<cmd>lua vim.lsp.buf.hover()<CR>" },
        { "gd", "<cmd>lua vim.lsp.buf.definition()<CR>" },
        { "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>" },
        { "gr", "<cmd>lua vim.lsp.buf.references()<CR>" },
        { "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>" },
        { "gn", "<cmd>lua vim.lsp.buf.rename()<CR>" },
        { "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>" },
        { "ge", "<cmd>lua vim.lsp.buf.open_float()<CR>" },
      },
      config = function()
        -- Set up nvim-cmp.
        local cmp = require 'cmp'

        cmp.setup({
          snippet = {
            expand = function(args)
              require('luasnip').lsp_expand(args.body)
            end,
          },
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-l>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                return cmp.complete_common_string()
              end
              fallback()
            end, { 'i', 'c' }),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          }),
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'copilot' },
            { name = 'luasnip' }, -- For luasnip users.
          }, {
            { name = 'buffer' },
          }),
          experimental = {
            ghost_text = true,
          },
        })

        cmp.setup.filetype('gitcommit', {
          sources = cmp.config.sources({
            { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
          }, {
            { name = 'buffer' },
          })
        })

        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
          vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true }
        )
      end
    }
  },
}
