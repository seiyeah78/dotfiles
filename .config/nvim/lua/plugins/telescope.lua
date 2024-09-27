require("utils")
local plugins = {
  'fzf',
  'yank_history',
  'frecency',
  'smart_open',
}

return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")
      vim.keymap.set('n', '<C-P>', function()
        require('telescope').extensions.smart_open.smart_open {
          cwd_only = true,
          filename_first = false,
        }
      end, {})
      vim.keymap.set('n', '<leader>ff', ':Telescope find_files <CR>', {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<C-W>d',
        function()
          require('telescope.builtin').lsp_definitions({
            jump_type = 'split',
            reuse_win = true,
          })
        end,
        { desc = 'Goto definition split. ' }
      )
      vim.keymap.set('n', '<C-W>v',
        function()
          require('telescope.builtin').lsp_definitions({
            jump_type = 'vsplit',
            reuse_win = true,
          })
        end,
        { desc = 'Goto definition' }
      )
      require('telescope').setup {
        defaults = {
          layout_strategy = 'vertical',
          sorting_strategy = "ascending",
          layout_config = {
            vertical = {
              height = 0.95,
              prompt_position = "top",
              width = 0.75
            }
          },
          -- Default configuration for telescope goes here:
          -- config_key = value,
          borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          mappings = {
            i = {
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              ["<C-s>"] = "file_split",
              ["<esc>"] = actions.close,
              ["<C-u>"] = false,
              ["<C-a>"] = { "<home>", type = "command" },
              ["<C-e>"] = { "<end>", type = "command" }
            }
          }
        },
        pickers = {
          find_files = {
            find_command = Split(vim.env.FZF_DEFAULT_COMMAND, ' ')
          },
          live_grep = {
            additional_args = {
              "--hidden",
              "--no-heading",
              "--no-ignore",
              "--ignore-file",
              vim.fs.normalize("~/.ignore"), -- チルダをそのまま解釈できない。絶対パスにする
            }
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          },
          smart_open = {
            match_algorithm = "fzf",
            cwd_only = true,
            show_scores = true,
            ignore_patterns = { "*.git/*", "*/tmp/*", "*/nodle_modules/*" },
          },
          frecency = {
            show_unindexed = true,
            auto_validate = false,
          },
        }
      }
      for i = 1, #plugins do
        require('telescope').load_extension(plugins[i])
      end
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    event = 'VeryLazy',
    build = 'make',
    dependencies = {
      'nvim-telescope/telescope.nvim'
    }
  },
  {
    'nvim-telescope/telescope-frecency.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-telescope/telescope.nvim'
    }
  },
  {
    'danielfalk/smart-open.nvim',
    event = 'VeryLazy',
    dependencies = {
      "kkharji/sqlite.lua",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
}
