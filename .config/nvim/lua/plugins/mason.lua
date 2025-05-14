local lsps = {
  'actionlint',
  'biome',
  'black',
  'flake8',
  'gopls',
  'jsonlint',
  'lua_ls',
  'prettierd',
  'golangci-lint-langserver',
  'pyright',
  'ruff',
  'solargraph',
  'terraform-ls',
  'vue-language-server',
  'vtsls',
  'yamlfmt',
  'delve',
  'debugpy',
  'js-debug-adapter',
  'sqlfluff',
}

return {
  {
    "mason-org/mason.nvim",
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
      ensure_installed = lsps
    },
  },
  {
    "rshkarin/mason-nvim-lint",
    dependencies = {
      { "mason-org/mason.nvim" },
      { "mason-org/mason-lspconfig.nvim" },
      { "mfussenegger/nvim-lint" },
    },
    opt = {
      ensure_installed = lsps
    }
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim" },
      { 'yioneko/nvim-vtsls' },
    },
    config = function()
      -- vim.lsp.config('*', {
      --   capabilities = require('blink.cmp').get_lsp_capabilities(),
      --   root_makers = { ".git" }
      -- })
      -- vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx)
      --   require("ts-error-translator").translate_diagnostics(err, result, ctx)
      --   vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
      -- end
      vim.lsp.enable(lsps)
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = { "mason-org/mason.nvim" },
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
