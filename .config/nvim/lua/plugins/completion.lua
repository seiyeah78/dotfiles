return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall" },
    event = { "WinNew", "WinLeave", "BufRead" },
    config = function()
      require("mason").setup({})
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
      end
    end,
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim" },
      { "neovim/nvim-lspconfig" },
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    config = function()
      require('mason-lspconfig').setup_handlers({
        function(server)
          local opt = {
            capabilities = require('cmp_nvim_lsp').default_capabilities(
              vim.lsp.protocol.make_client_capabilities()
            )
          }
          require('lspconfig')[server].setup(opt)
          require("lspconfig").pyright.setup {
            settings = {
              python = {
                venvPath = ".",
                pythonPath = "./.venv/bin/python",
                analysis = {
                  extraPaths = { "." }
                }
              }
            }
          }
        end
      })
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
    event = 'InsertEnter',
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets'
    },
    config = function()
      require("luasnip/loaders/from_vscode").lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load()
      local ls = require("luasnip")
      vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<TAB>", function()
        if ls.expand_or_jumpable() then
          ls.jump(1)
        else
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<TAB>', true, true, true), 'n')
        end
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<S-TAB>", function()
        if ls.expand_or_jumpable() then
          ls.jump(-1)
        else
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<S-TAB>', true, true, true), 'n')
        end
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(1) end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-K>", function() ls.jump(-1) end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-E>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })
    end
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
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
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local lspkind = require('lspkind')
      lspkind.init({
        mode = 'symbol',
        preset = 'codicons',
        maxwidth = 50,
        ellipsis_char = '...',
      })
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
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
  },
  {
    'aznhe21/actions-preview.nvim',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { 'kosayoda/nvim-lightbulb' },
    config = function()
      vim.keymap.set({ "v", "n" }, "<leader>ca", require("actions-preview").code_actions)
      require("nvim-lightbulb").setup({
        priority = 1000,
        autocmd = { enabled = true },
        sign = {
          enabled = false
        },
        virtual_text = {
          enabled = true
        }
      })
      require("actions-preview").setup {
        diff = {
          algorithm = "patience",
          ignore_whitespace = true,
        },
        telescope = require("telescope.themes").get_dropdown { winblend = 10 },
      }
    end
  }
}
