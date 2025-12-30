local lsps = {
  "gopls",
  "lua_ls",
  "golangci-lint-langserver",
  "pyright",
  "solargraph",
  "terraformls",
  "vue-language-server",
  "vtsls",
  "delve",
  "debugpy",
  "js-debug-adapter",
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
  { "eslint_d", version = "13.1.2" },
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

          -- eslint_d のパス解決関数
          -- eslint_dが13.1.2より新しい場合、設定ファイルが必要で「Error: Could not find config file」が出てしまう
          -- プロジェクト内にeslintがある場合は、そちらを優先する
          local function get_eslint_d()
            local cwd = vim.fn.getcwd()
            local local_eslint_d = cwd .. "/node_modules/.bin/eslint_d"
            local local_eslint = cwd .. "/node_modules/.bin/eslint"

            if vim.fn.executable(local_eslint_d) == 1 then
              return local_eslint_d
            elseif vim.fn.executable(local_eslint) == 1 then
              return local_eslint
            else
              -- Mason 管理の eslint_d
              return vim.fn.stdpath("data") .. "/mason/bin/eslint_d"
            end
          end

          local eslint_d_original = vim.deepcopy(lint.linters.eslint_d)

          lint.linters.eslint_d = {
            cmd = get_eslint_d(),
            stdin = eslint_d_original.stdin,
            args = eslint_d_original.args,
            stream = eslint_d_original.stream,
            ignore_exitcode = eslint_d_original.ignore_exitcode,
            env = eslint_d_original.env,
            parser = eslint_d_original.parser,
          }

          lint.linters_by_ft = {
            -- json = { 'eslint_d' },
            sh = { "shellcheck" },
            -- sql = { 'sqlfluff' },
            go = { "golangcilint" },
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
          }
          vim.api.nvim_create_autocmd({ "CursorHold" }, {
            callback = function()
              lint.try_lint()
            end,
          })
        end,
      },
    },
    config = function()
      require("mason-nvim-lint").setup({
        automatic_installation = true,
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim" },
      { "yioneko/nvim-vtsls" },
    },
    config = function()
      vim.lsp.enable(lsps)
    end,
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
