local api = vim.api

return {
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        ignore_install = { "haskell", "markdown", "beancount", "swift", "gitcommit", "wing" },
        highlight = {
          enable = true, -- false will disable the whole extension
          disable = {
            'lua',
            'toml',
            'ruby',
            'c_sharp',
            'vue',
            'bash',
            'haskell',
            'vim',
            'html',
            'markdown',
            'swift',
            'beancount',
            'gitcommit'
          }
        },
        indent = {
          enable = true,
          disable = {
            'python',
            'yaml',
            'ruby',
            'gitcommit'
          }
        }
      }
    end
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
        command = 'TSContextEnable',
      })
      api.nvim_create_autocmd({ 'CursorMoved' }, {
        pattern = '*',
        command = 'TSContextDisable',
      })
    end
  },
}
