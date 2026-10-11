local api = vim.api

return {
  {
    "romus204/tree-sitter-manager.nvim",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
    }, -- tree-sitter CLI must be installed system-wide
    config = function()
      require("tree-sitter-manager").setup({

        -- 1. パーサーの一括自動インストール設定
        ensure_installed = {
          "bash",
          "dockerfile",
          "go",
          "helm",
          "html",
          "http",
          "javascript",
          "json",
          "markdown",
          "python",
          "ruby",
          "rust",
          "sql",
          "terraform",
          "toml",
          "tsx",
          "lua",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },

        -- 2. ハイライトを無効化する言語の設定 (highlight_disable に対応)
        nohighlight = {
          "lua",
          "toml",
          "c_sharp",
          "vue",
          "bash",
          "haskell",
          "vim",
          "html",
          "swift",
          "beancount",
          "dockerfile",
        },
      })

      require("nvim-treesitter-endwise").init()
    end,
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   branch = "main",
  --   main = "nvim-treesitter",
  --   lazy = false,
  --   build = ":TSUpdate",
  --   dependencies = {
  --     "RRethy/nvim-treesitter-endwise",
  --   },
  --   init = function()
  --     local parsers = {
  --       "bash",
  --       "dockerfile",
  --       "go",
  --       "helm",
  --       "html",
  --       "http",
  --       "javascript",
  --       "json",
  --       "markdown",
  --       "python",
  --       "ruby",
  --       "rust",
  --       "sql",
  --       "terraform",
  --       "toml",
  --       "tsx",
  --       "lua",
  --       "typescript",
  --       "vim",
  --       "vimdoc",
  --       "yaml",
  --     }
  --
  --     local highlight_disable = {
  --       lua = true,
  --       toml = true,
  --       ruby = true,
  --       c_sharp = true,
  --       vue = true,
  --       bash = true,
  --       haskell = true,
  --       vim = true,
  --       html = true,
  --       swift = true,
  --       beancount = true,
  --       dockerfile = true,
  --     }
  --
  --     local indent_disable = {
  --       python = true,
  --       yaml = true,
  --       ruby = false,
  --     }
  --
  --     local ts = require("nvim-treesitter")
  --     local installed = ts.get_installed("parsers")
  --     local to_install = vim
  --       .iter(parsers)
  --       :filter(function(lang)
  --         return not vim.tbl_contains(installed, lang)
  --       end)
  --       :totable()
  --
  --     if #to_install > 0 then
  --       ts.install(to_install)
  --     end
  --
  --     -- treesitterを有効にするautocmd
  --     vim.api.nvim_create_autocmd("FileType", {
  --       callback = function(args)
  --         local ft = args.match
  --         local lang = vim.treesitter.language.get_lang(ft) or ft
  --
  --         local ok = vim.treesitter.language.add(lang)
  --         if ok then
  --           if not highlight_disable[lang] and not highlight_disable[ft] then
  --             pcall(vim.treesitter.start, args.buf, lang)
  --             vim.bo[args.buf].syntax = "OFF"
  --           end
  --
  --           if not indent_disable[lang] and not indent_disable[ft] then
  --             vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  --           else
  --             vim.bo[args.buf].indentexpr = ""
  --           end
  --         end
  --       end,
  --     })
  --   end,
  --   opts = {},
  -- },
  {
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = {
          -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            "class",
            "function",
            "method",
            -- 'for', -- These won't appear in the context
            -- 'while',
            -- 'if',
            -- 'switch',
            -- 'case',
          },
          -- Example for a specific filetype.
          -- If a pattern is missing, *open a PR* so everyone can benefit.
          --   rust = {
          --       'impl_item',
          --   },
        },
      })
      api.nvim_create_autocmd({ "CursorHold" }, {
        pattern = "*",
        command = "TSContext enable",
      })
      api.nvim_create_autocmd({ "CursorMoved" }, {
        pattern = "*",
        command = "TSContext disable",
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}
