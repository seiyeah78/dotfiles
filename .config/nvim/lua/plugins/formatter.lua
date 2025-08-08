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
        format_on_save = function(bufnr)
          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          return { timeout_ms = 2000, lsp_format = "fallback" }
        end,
      })
      vim.api.nvim_create_user_command('Format', function(args)
        require("conform").format({ bufnr = args.buf })
      end, {})
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
        vim.print('Disable autoformat-on-save')
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
        vim.print('Re-enable autoformat-on-save')
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
  },
}
