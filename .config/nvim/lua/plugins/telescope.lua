require("utils")
local plugins = {
  'fzf',
  'yank_history',
  'frecency',
  'smart_open'
}

return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")
      vim.keymap.set('n', '<C-P>', ':Telescope find_files <CR>', {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>b', builtin.buffers, {})
      require('telescope').setup {
        defaults = {
          layout_strategy = 'vertical',
          layout_config = {
            vertical = {
              height = 0.95,
              preview_cutoff = 40,
              prompt_position = "bottom",
              width = 0.95
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
            }
          }
        },
        pickers = {
          find_files = {
            find_command = Split(vim.env.FZF_DEFAULT_COMMAND, ' ')
          }
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
            filename_first = false,
            ignore_patterns = { "*.git/*", "*/tmp/*", "*/nodle_modules/*" },
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
    branch = "0.2.x",
    dependencies = {
      "kkharji/sqlite.lua",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
}
