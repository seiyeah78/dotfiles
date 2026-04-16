local api = vim.api

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    main = 'nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
      "RRethy/nvim-treesitter-endwise"
    },
    init = function()
      local parsers = {
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
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      }

      local highlight_disable = {
        lua = true,
        toml = true,
        ruby = true,
        c_sharp = true,
        vue = true,
        bash = true,
        haskell = true,
        vim = true,
        html = true,
        swift = true,
        beancount = true,
        dockerfile = true,
      }

      local indent_disable = {
        python = true,
        yaml = true,
        ruby = true,
      }

      local ts = require("nvim-treesitter")
      local installed = ts.get_installed("parsers")
      local to_install = vim.iter(parsers)
          :filter(function(lang)
            return not vim.tbl_contains(installed, lang)
          end)
          :totable()

      if #to_install > 0 then
        ts.install(to_install)
      end

      -- treesitterを有効にするautocmd
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ft = args.match
          local lang = vim.treesitter.language.get_lang(ft) or ft

          local ok = vim.treesitter.language.add(lang)
          if ok then
            if not highlight_disable[lang] and not highlight_disable[ft] then
              pcall(vim.treesitter.start, args.buf, lang)
              vim.bo[args.buf].syntax = "OFF"
            end

            if not indent_disable[lang] and not indent_disable[ft] then
              vim.bo[args.buf].indentexpr =
              "v:lua.require'nvim-treesitter'.indentexpr()"
            else
              vim.bo[args.buf].indentexpr = ""
            end
          end
        end,
      })

      require("nvim-treesitter-endwise").init()
      vim.api.nvim_create_user_command("TSInstallInfo", function()
        local parser_defs = require("nvim-treesitter.parsers")

        -- 全parser一覧（install可能なもの）
        local all_langs = {}
        for lang, def in pairs(parser_defs) do
          if type(def) == "table" and def.install_info then
            table.insert(all_langs, lang)
          end
        end
        table.sort(all_langs)

        -- インストール済み
        local installed_set = {}
        for _, lang in ipairs(installed) do
          installed_set[lang] = true
        end

        local lines = {
          "=== Treesitter Parsers ===",
          "",
        }

        for _, lang in ipairs(all_langs) do
          local status = installed_set[lang] and "✓ installed" or "✘ missing"
          table.insert(lines, string.format("%-18s %s", lang, status))
        end

        -- 表示
        vim.cmd("new")
        local buf = vim.api.nvim_get_current_buf()

        vim.bo[buf].buftype = "nofile"
        vim.bo[buf].bufhidden = "wipe"
        vim.bo[buf].swapfile = false
        vim.bo[buf].modifiable = true
        vim.bo[buf].filetype = "tsinstallinfo"

        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        vim.bo[buf].modifiable = false
      end, {
        desc = "Show Treesitter parsers (✓ installed / ✘ missing)",
      })
    end,
    opts = {},
  },
  {
    'romgrk/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup {
        enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = {
          -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
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
      }
      api.nvim_create_autocmd({ 'CursorHold' }, {
        pattern = '*',
        command = 'TSContext enable',
      })
      api.nvim_create_autocmd({ 'CursorMoved' }, {
        pattern = '*',
        command = 'TSContext disable',
      })
    end
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  }
}
