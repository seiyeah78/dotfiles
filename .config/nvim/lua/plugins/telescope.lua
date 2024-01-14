require("utils")
local plugins = {
  'fzf',
  'yank_history',
  'frecency',
  'smart_open',
  'aerial'
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
      vim.keymap.set('n', '<C-P>', ':Telescope smart_open <CR>', {})
      vim.keymap.set('n', '<leader>ff', ':Telescope find_files <CR>', {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
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
            filename_first = false,
            ignore_patterns = { "*.git/*", "*/tmp/*", "*/nodle_modules/*" },
          },
          frecency = {
            show_unindexed = true,
          },
          aerial = {
            -- Display symbols as <root>.<parent>.<symbol>
            show_nesting = {
              ["_"] = false, -- This key will be the default
              json = true,   -- You can set the option for specific filetypes
              yaml = true,
            },
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
    event = 'VeryLazy',
    dependencies = {
      "kkharji/sqlite.lua",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
}
