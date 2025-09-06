local lsps = {
  'gopls',
  'lua_ls',
  'golangci-lint-langserver',
  'pyright',
  'solargraph',
  'terraformls',
  'vue-language-server',
  'vtsls',
  'delve',
  'debugpy',
  'js-debug-adapter',
}

local formatters = {
  "black",
  "markdownlint",
  "prettier",
  "yamlfmt",
}

local linters = {
  "actionlint",
  "codespell",
  { 'eslint_d', version = '13.1.2' },
  "flake8",
  "golangci-lint",
  "hadolint",
  "jsonlint",
  "markdownlint",
  "ruff",
  "shellcheck",
  -- "sqlfluff",
  "tflint",
  "vale",
}

local ensure_installed = {}
vim.list_extend(ensure_installed, lsps)
vim.list_extend(ensure_installed, formatters)
vim.list_extend(ensure_installed, linters)
return {
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall" },
    event = { "WinNew", "WinLeave", "BufRead", "BufEnter" },
    config = function()
      require("mason").setup()
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
    opts = {
      ensure_installed = ensure_installed,
    },
  },
  {
    "rshkarin/mason-nvim-lint",
    dependencies = {
      { "mason-org/mason.nvim" },
      { "mason-org/mason-lspconfig.nvim" },
      {
        "mfussenegger/nvim-lint",
        event = "VeryLazy",
        config = function()
          local lint = require("lint")
          lint.linters_by_ft = {
            -- json = { 'eslint_d' },
            sh = { 'shellcheck' },
            -- sql = { 'sqlfluff' },
            go = { 'golangcilint' },
            javascript = { 'eslint_d' },
            typescript = { 'eslint_d' },
            javascriptreact = { 'eslint_d' },
            typescriptreact = { 'eslint_d' }
          }
          vim.api.nvim_create_autocmd({ "CursorHold" }, {
            callback = function()
              lint.try_lint()
            end,
          })
        end
      },
    },
    config = function()
      require("mason-nvim-lint").setup({
        automatic_installation = true,
      })
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim" },
      { "yioneko/nvim-vtsls" },
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
            require("mason-nvim-dap").default_setup(config)
          end,
        },
      })
    end,
  },
  {
    "yioneko/nvim-vtsls",
    event = "VeryLazy",
    config = function()
      -- autocmdを使ってfiletypeがluaのときにのみコマンドを作成
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
        callback = function()
          vim.api.nvim_create_user_command(
            "OrganizeImport",
            function()
              vim.cmd("VtsExec organize_imports")
            end,
            {} -- コマンドオプション（必要に応じて設定）
          )
        end,
      })
    end,
  },
}
