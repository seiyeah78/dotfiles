return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall" },
    event = { "WinNew", "WinLeave", "BufRead" },
    config = function()
      require("mason").setup()
      local signs = { Error = "", Warn = "", Hint = "", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
      end
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    cmd = { 'MasonToolsInstall', 'MasonToolsUpdate', 'MasonToolsClean' },
    opts = {
      ensure_installed = {
        'actionlint',
        'biome',
        'black',
        'flake8',
        'gopls',
        'jsonlint',
        'lua-language-server',
        'prettierd',
        'pyright',
        'ruff',
        'solargraph',
        'terraform-ls',
        -- 'typescript-language-server',
        'vue-language-server',
        'yamlfmt',
        -- 'ruby-lsp',
        'delve',
        'debugpy',
        'js-debug-adapter',
        'sqlfluff',
        'golangcilint'
      }
    },
  },
  {
    "rshkarin/mason-nvim-lint",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "mfussenegger/nvim-lint" },
    },
    config = function()
      require('mason-nvim-lint').setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim" },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local util = require('lspconfig/util')
      -- 共通のoptionを作成
      local client_capabilities = vim.lsp.protocol.make_client_capabilities()
      client_capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      local common_opts = {
        capabilities = require('cmp_nvim_lsp').default_capabilities(
          client_capabilities
        )
      }
      require('mason-lspconfig').setup_handlers({
        function(server)
          lspconfig[server].setup(common_opts)
        end,
        -- サーバごとに個別設定を入れることができる
        ["pyright"] = function()
          lspconfig.pyright.setup(vim.tbl_deep_extend("force", common_opts, {
            settings = {
              python = {
                venvPath = ".",
                pythonPath = "./.venv/bin/python",
                analysis = {
                  extraPaths = { "." }
                }
              }
            }
          }))
        end,
        ['volar'] = function()
          lspconfig.volar.setup(vim.tbl_deep_extend("force", common_opts, {
            root_dir = util.root_pattern('tsconfig.json', 'package.json', 'nuxt.config.ts', 'uno.config.ts', '.git'),
            on_attach = function(client, _)
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentRangeFormattingProvider = false
            end,
          }))
        end,
        -- ["ts_ls"] = function()
        --   local vue_typescript_plugin = require("mason-registry").get_package("vue-language-server"):get_install_path() ..
        --       "/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"
        --
        --   local filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" }
        --   lspconfig.ts_ls.setup(vim.tbl_deep_extend("force", common_opts, {
        --     root_dir = util.root_pattern('tsconfig.json', 'package.json', 'nuxt.config.ts', 'uno.config.ts', '.git'),
        --     filetypes = filetypes,
        --     init_options = {
        --       plugins = {
        --         {
        --           name = "@vue/typescript-plugin",
        --           location = vue_typescript_plugin,
        --           languages = filetypes,
        --         },
        --       },
        --     },
        --   }))
        -- end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup(vim.tbl_deep_extend("force", common_opts, {
            settings = {
              Lua = {
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = { 'vim' },
                },
              },
            },
          }))
        end
      })
      vim.lsp.inlay_hint.enable(true)
    end
  }
}
