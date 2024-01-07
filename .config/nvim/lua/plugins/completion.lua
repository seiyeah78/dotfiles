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
      { 'hrsh7th/cmp-nvim-lsp' },
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
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require('mason-null-ls').setup({
        ensure_installed = { 'prettierd', 'black' },
        handlers = {},
      })
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    dependencies = { 'saadparwaiz1/cmp_luasnip' },
    config = function()
      require("luasnip.loaders.from_snipmate").lazy_load()
    end
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'zbirenbaum/copilot-cmp' },
      { 'onsails/lspkind.nvim' }
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
      local cmp = require('cmp')
      local lspkind = require('lspkind')
      lspkind.init({
        mode = 'symbol',
        preset = 'codicons',
        maxwidth = 50,
        ellipsis_char = '...',
      })
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
          ["<S-TAB>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<TAB>"] = cmp.mapping.select_next_item(),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-l>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              return cmp.complete_common_string()
            end
            fallback()
          end, { 'i', 'c' }),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'copilot' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        }),
        formatting = {
          format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]

            return vim_item
          end
        }
      })

      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        })
      })

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- cmp.setup.cmdline(':', {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = cmp.config.sources({
      --     { name = 'path' }
      --   }, {
      --     { name = 'cmdline' }
      --   })
      -- })

      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true }
      )
    end
  }
}
