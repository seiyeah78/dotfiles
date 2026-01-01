return {
  {
    "neovim/nvim-lspconfig",
    evnet = "LspAttach",
    config = function() end,
  },
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip/loaders/from_vscode").lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load()
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = { "nvim-lspconfig" },
    keys = {
      { "D", "<cmd>Lspsaga hover_doc<CR>" },
      -- { "gd", "<cmd>Lspsaga goto_definition<CR>" },
      { "gD", "<cmd>Lspsaga peek_definition<CR>" },
      { "gt", "<cmd>Lspsaga goto_type_definition<CR>" },
      { "gr", "<cmd>Lspsaga finder<CR>" },
      { "gm", "<cmd>Lspsaga rename<CR>" },
    },
    config = function()
      local keys = {
        edit = { "<CR>", "o" },
        vsplit = "<C-v>",
        split = "<C-s>",
        tabe = "<C-g>e",
        close = "<C-c>k",
        quit = { "q", "<C-W>c", "<ESC>" },
        shuttle = "<C-w><C-w>",
        toggle_or_req = "u",
        toggle_or_open = { "<CR>", "o" },
      }
      -- https://github.com/nvimdev/lspsaga.nvim/blob/main/lua/lspsaga/init.lua
      require("lspsaga").setup({
        request_timeout = 500,
        ui = {
          winbar_prefix = "",
          --   border = vim.o.winborder,
          devicon = true,
          foldericon = true,
          title = true,
          expand = "⊞",
          collapse = "⊟",
          code_action = "💡",
          lines = { "┗", "┣", "┃", "━", "┏" },
          kind = nil,
          button = { "", "" },
          imp_sign = "󰳛 ",
          use_nerd = true,
        },
        symbol_in_winbar = {
          enable = false,
        },
        show_outline = {
          win_iwidth = 50,
          auto_preview = false,
        },
        lightbulb = {
          enable = false,
          enable_in_insert = false,
          sign = false,
          debounce = 500,
        },
        hover = {
          max_width = 0.9,
          max_height = 1.0,
          open_link = "gx",
          open_cmd = "!chrome",
        },
        diagnostic = {
          enable = false,
          diagnostic_only_current = false,
          extend_relatedInformation = false,
        },
        definition = {
          width = 0.6,
          height = 0.5,
          save_pos = true,
          keys = keys,
        },
        callhierarchy = {
          layout = "float",
          left_width = 0.2,
          keys = keys,
        },
        finder = {
          max_height = 0.5,
          left_width = 0.3,
          methods = {},
          default = "tyd+ref+imp",
          layout = "float",
          silent = false,
          filter = {},
          fname_sub = nil,
          sp_inexist = true,
          sp_global = true,
          ly_botright = true,
          keys = keys,
        },
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      npairs.setup({
        map_c_h = true,
        map_c_w = true,
        fast_wrap = {},
      })
      -- add autopairs role
      local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
      npairs.add_rules({
        Rule(" ", " "):with_pair(function(opts)
          local pair = opts.line:sub(opts.col - 1, opts.col)
          return vim.tbl_contains({
            brackets[1][1] .. brackets[1][2],
            brackets[2][1] .. brackets[2][2],
            brackets[3][1] .. brackets[3][2],
          }, pair)
        end),
      })
      for _, bracket in pairs(brackets) do
        npairs.add_rules({
          Rule(bracket[1] .. " ", " " .. bracket[2])
            :with_pair(function()
              return false
            end)
            :with_move(function(opts)
              return opts.prev_char:match(".%" .. bracket[2]) ~= nil
            end)
            :use_key(bracket[2]),
        })
      end
    end,
  },
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {},
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true, -- Ensure this is true
          auto_trigger = true, -- Consider enabling for automatic suggestions
          accept = false,
        },
        copilot_node_command = vim.fn.system("mise where nodejs@22.20.0"):gsub("\n$", "") .. "/bin/node", -- Node.js version must be >= 22.x
      })

      -- キーマップを設定(blink等他の補完系プラグインとバッティングする可能性あり)
      vim.keymap.set("i", "<Tab>", function()
        -- copilotがサジェストしていれば真
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
        else
          -- キーコードをneovimが解釈可能な形式に変換
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
        end
      end, {
        -- コマンドラインへ表示しない
        silent = true,
      })
    end,
  },
  {
    "aznhe21/actions-preview.nvim",
    -- event = { "BufReadPre", "BufNewFile" },
    dependencies = { "kosayoda/nvim-lightbulb" },
    config = function()
      vim.keymap.set({ "v", "n" }, "ga", require("actions-preview").code_actions)
      require("nvim-lightbulb").setup({
        priority = 1000,
        autocmd = { enabled = true },
        sign = {
          enabled = false,
        },
        virtual_text = {
          enabled = true,
        },
      })
    end,
  },
  {
    "dmmulroy/ts-error-translator.nvim",
    config = function()
      require("ts-error-translator").setup()
    end,
  },
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "InsertEnter",
  --   opts = {
  --     bind = true,
  --     hint_enable = false,
  --     floating_window_off_x = 0,
  --     hint_prefix = "🦊 ",
  --     hi_parameter = "Search",
  --   },
  --   config = function(_, opts)
  --     require("lsp_signature").setup(opts)
  --   end
  -- },
}
