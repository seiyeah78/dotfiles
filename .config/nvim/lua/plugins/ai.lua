local system_prompt =
  "あなたは優秀なプログラミングアシスタントです。すべての応答は日本語で行ってください。コードのコメントも日本語で記述してください。"
return {
  {
    "yetone/avante.nvim",
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- add any opts here
      mode = "legacy",
      -- this file can contain specific instructions for your project
      instructions_file = "avante.md",
      -- for example
      provider = "copilot",
      auto_suggestions_provider = "copilot",
      system_prompt = system_prompt,
      providers = {
        copilot = {
          model = "claude-sonnet-4.5",
        },
      },
      acp_providers = {
        ["opencode"] = {
          command = "opencode",
          args = { "acp" },
        },
      },
      input = {
        height = 12,
      },
      windows = {
        input = {
          height = 12,
        },
        edit = {
          start_insert = true, -- Start insert mode when opening the edit window
        },
        ask = {
          start_insert = false, -- Start insert mode when opening the ask window
          floating = false,
        },
        sidebar_header = {
          enabled = true,
          rounded = true,
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "folke/snacks.nvim", -- for input provider snacks
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    config = function(_, opts)
      require("avante").setup(opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "AvanteInput", -- ← filetype を指定（複数指定も可: {"lua", "go"}）
        callback = function()
          vim.keymap.set("n", "<leader>ac", ":AvanteClear<CR>", { buffer = true, desc = "AvanteClear" })
        end,
      })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "franco-ruggeri/codecompanion-spinner.nvim",
    },
    opts = {
      extensions = {
        spinner = {},
      },
      display = {
        chat = {
          show_settings = true,
          show_tools_processing = true,
          floating_window = {
            width = function()
              return vim.o.columns - 5
            end,
            height = function()
              return vim.o.lines - 2
            end,
            row = "center",
            col = "center",
            relative = "editor",
            opts = {
              wrap = false,
              number = false,
              relativenumber = false,
            },
          },
        },
        diff = {
          enabled = true,
          provider = "split", -- inline|split|mini.diff
        },
      },
      --Refer to: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
      interactions = {
        --NOTE: Change the adapter as required
        chat = {
          adapter = {
            name = "copilot",
            model = "claude-sonnet-4.5",
            opts = {
              system_prompt = system_prompt,
            },
          },
        },
        inline = {
          adapter = "copilot",
          model = "claude-sonnet-4.5",
        },
      },
    },
  },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
}
