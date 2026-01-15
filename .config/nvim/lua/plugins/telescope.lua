require("utils")
local plugins = {
  "fzf",
  "yank_history",
  "frecency",
  "luasnip",
}
return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<C-P>", function()
        builtin.find_files()
      end, {})
      vim.keymap.set("n", "<leader>fg", function()
        builtin.live_grep()
      end, {})
      vim.keymap.set("n", "<leader>fb", function()
        builtin.buffers()
      end, {})
      vim.keymap.set("n", "gd", function()
        builtin.lsp_definitions({ reuse_win = true })
      end, {})
      vim.keymap.set("n", "<C-W>d", function()
        builtin.lsp_definitions({
          jump_type = "split",
          reuse_win = true,
        })
      end, { desc = "Goto definition split." })
      vim.keymap.set("n", "<C-W>v", function()
        builtin.lsp_definitions({
          jump_type = "vsplit",
          reuse_win = true,
        })
      end, { desc = "Goto definition" })
      require("telescope").setup({
        defaults = {
          layout_strategy = "vertical",
          sorting_strategy = "ascending",
          layout_config = {
            vertical = {
              height = 0.95,
              prompt_position = "top",
              width = 0.75,
            },
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
              ["<C-e>"] = { "<end>", type = "command" },
            },
          },
        },
        pickers = {
          find_files = {
            find_command = Split(vim.env.FZF_DEFAULT_COMMAND, " "),
          },
          live_grep = {
            additional_args = {
              "--hidden",
              "--no-heading",
              "--no-ignore",
              "--ignore-file",
              vim.fs.normalize("~/.ignore"), -- チルダをそのまま解釈できない。絶対パスにする
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          },
          frecency = {
            show_unindexed = true,
            auto_validate = false,
          },
          media_files = {
            filetypes = { "png", "jpg", "mp4", "mkv", "webm", "webp", "pdf", "epub" },
            find_cmd = "rg",
          },
        },
      })
      for i = 1, #plugins do
        require("telescope").load_extension(plugins[i])
      end
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    event = "VeryLazy",
    build = "make",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "benfowler/telescope-luasnip.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },

  {
    "prochri/telescope-all-recent.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua",
      -- optional, if using telescope for vim.ui.select
      "stevearc/dressing.nvim",
    },
    opts = {
      scoring = {
        -- recency_modifier = {                 -- 「最近使った」スコアの加算ルール（frecencyに類似）
        --   [1] = { age = 120, value = 120 },  -- 過去2時間以内なら +120
        --   [2] = { age = 240, value = 100 },  -- 過去4時間以内なら +100
        --   [3] = { age = 1440, value = 80 },  -- 過去1日以内なら +80
        --   [4] = { age = 4320, value = 60 },  -- 過去3日以内なら +60
        --   [5] = { age = 10080, value = 40 }, -- 過去1週間以内なら +40
        --   [6] = { age = 43200, value = 20 }, -- 過去1ヶ月以内なら +20
        --   [7] = { age = 129600, value = 10 } -- 過去90日以内なら +10
        -- },
        boost_factor = 0.001, -- 「最近使ったスコア」の強化倍率（スコアにどの程度影響を与えるか）
      },
      -- pickers = {                            -- allows you to overwrite the default settings for each picker
      --   find_files = {                       -- enable man_pages picker. Disable cwd and use frecency sorting.
      --     sorting = "recent"
      --   },
      -- }
    },
  },
  -- {
  --   'nvim-telescope/telescope-media-files.nvim',
  --   event = 'VeryLazy',
  --   dependencies = {
  --     'nvim-telescope/telescope.nvim'
  --   }
  -- }
}
