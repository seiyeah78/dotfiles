return {
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua", stop_after_first = true },
          go = { "goimports" },
          bash = { "shfmt" },
          python = { "black", "ruff" },
          typescript = { "biome", "prettierd", stop_after_first = true },
          javascript = { "biome", "prettierd", stop_after_first = true },
          typescriptreact = { "biome", "prettierd", stop_after_first = true },
          javascriptreact = { "biome", "prettierd", stop_after_first = true },
          vue = { "prettierd", "vue-language-server", stop_after_first = true },
          svelte = { "prettierd", stop_after_first = true },
          json = { "prettierd" },
          jsonc = { "prettierd" },
          yaml = { "prettierd" },
          css = { "prettierd" },
        },
        format_on_save = {
          timeout_ms = 2000,
          lsp_format = "fallback",
        },
      })
      vim.api.nvim_create_user_command('Format', function(args)
        require("conform").format({ bufnr = args.buf })
      end, {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        json = { 'eslint_d' },
        markdown = { 'markdownlint' },
        sh = { 'shellcheck' },
        sql = { 'sqlfluff' },
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
  }
}
