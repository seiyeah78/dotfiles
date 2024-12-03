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
        'vtsls',
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
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'yioneko/nvim-vtsls' },
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
        end,
        ["vtsls"] = function()
          lspconfig.vtsls.setup(vim.tbl_deep_extend("force", common_opts, require("vtsls").lspconfig, {
            handlers = {
              ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
                require("ts-error-translator").translate_diagnostics(err, result, ctx, config)
                vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
              end,
            },
          }))
        end
      })
      vim.lsp.inlay_hint.enable(true)
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-nvim-dap").setup({
        automatic_setup = true,
        ensure_installed = { "python", "delve" },
        handlers = {
          function(config)
            require('mason-nvim-dap').default_setup(config)
          end,
        },
      })
    end
  },
  {
    'yioneko/nvim-vtsls',
    event = 'VeryLazy',
    config = function()
      -- autocmdを使ってfiletypeがluaのときにのみコマンドを作成
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
        callback = function()
          vim.api.nvim_create_user_command(
            'OrganizeImport',
            function()
              vim.cmd('VtsExec organize_imports')
            end,
            {} -- コマンドオプション（必要に応じて設定）
          )
        end
      })
    end
  },
}
