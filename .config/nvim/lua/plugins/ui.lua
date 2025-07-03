return {
  {
    'nvim-tree/nvim-tree.lua',
    cmd = {
      "NvimTreeFindFile",
      "NvimTreeToggle",
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { "<leader><S-n>f",     "<cmd>NvimTreeFindFile<CR>", desc = "NvimTreeFindFile" },
      { "<leader><S-n><S-n>", "<cmd>NvimTreeToggle<CR>",   desc = "NvimTreeToggle" },
    },
    config = function()
      require("nvim-tree").setup({
        hijack_netrw = false,
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = false,
          update_root = true
        },
        actions = {
          open_file = {
            window_picker = {
              enable = false
            }
          }
        },
        on_attach = function(bufnr)
          local api = require "nvim-tree.api"
          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end
          -- default mappings
          api.config.mappings.default_on_attach(bufnr)
          -- custom mappings
          vim.keymap.set('n', '<C-s>', api.node.open.horizontal, opts('Open: Horizontal Split'))
        end
      })
    end
  },
  {
    'stevearc/oil.nvim',
    cmd = "Oil",
    opts = {
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-g"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["C-]"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gp"] = "actions.preview",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
      use_default_keymaps = false
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    'cappyzawa/trim.nvim',
    event = "BufEnter",
    opts = {
      ft_blocklist = { 'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive', 'fugitiveblame',
        'nerdtree', 'NvimTree' },
      trim_last_line = true,
    },
  },
  {
    'keaising/im-select.nvim',
    evnet = 'VeryLazy',
    config = function()
      if vim.fn.has('mac') == 1 then
        require('im_select').setup {
          -- IM will be set to `default_im_select` in `normal` mode(`EnterVim` or `InsertLeave`)
          -- For Windows/WSL, default: "1033", aka: English US Keyboard
          -- For macOS, default: "com.apple.keylayout.ABC", aka: US
          -- You can use `im-select` in cli to get the IM's name you preferred
          default_im_select   = "com.google.inputmethod.Japanese.Roman",
          -- Set to 1 if you don't want restore IM status when `InsertEnter`
          set_previous_events = { "InsertEnter" }
        }
      end
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufEnter',
    config = function()
      require('ibl').setup({
        scope = { enabled = true },
        viewport_buffer = { min = 10, max = 100 }
      })
    end
  },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
    },
    -- opts = {
    --   open_split = { "<c-s>" },
    --   open_tab = { "<c-g>" },
    -- },
  },
  {
    'm-demare/hlargs.nvim',
    event = "VeryLazy",
    config = function()
      require('hlargs').setup({
        color = "#ef9062",
        use_colorpalette = false,
        sequential_colorpalette = false,
        colorpalette = {
          { fg = "#ef9062" },
          { fg = "#35D27F" },
          { fg = "#EB75D6" },
          { fg = "#E5D180" },
          { fg = "#8997F5" },
          { fg = "#D49DA5" },
          { fg = "#7FEC35" },
          { fg = "#F6B223" },
          { fg = "#F67C1B" },
          { fg = "#BBEA87" },
          { fg = "#EEF06D" },
          { fg = "#8FB272" },
        },
        excluded_filetypes = { "lua", "rust", "typescript", "typescriptreact", "javascript", "javascriptreact" },
      })
    end
  },
  {
    'linrongbin16/lsp-progress.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("lsp-progress").setup({
        client_format = function(client_name, spinner, series_messages)
          if #series_messages == 0 then
            return nil
          end
          return {
            name = client_name,
            body = spinner .. " " .. table.concat(series_messages, ", "),
          }
        end,
        format = function(client_messages)
          --- @param name string
          --- @param msg string?
          --- @return string
          local function stringify(name, msg)
            return msg and string.format("%s %s", name, msg) or name
          end

          local sign = "" -- nf-fa-gear \uf013
          local lsp_clients = vim.lsp.get_clients()
          local messages_map = {}
          for _, climsg in ipairs(client_messages) do
            messages_map[climsg.name] = climsg.body
          end

          if #lsp_clients > 0 then
            table.sort(lsp_clients, function(a, b)
              return a.name < b.name
            end)
            local builder = {}
            for _, cli in ipairs(lsp_clients) do
              if type(cli) == "table"
                  and type(cli.name) == "string"
                  and string.len(cli.name) > 0
              then
                if messages_map[cli.name] then
                  table.insert(builder, stringify(cli.name, messages_map[cli.name]))
                else
                  table.insert(builder, stringify(cli.name))
                end
              end
            end
            if #builder > 0 then
              return sign .. " " .. table.concat(builder, ", ")
            end
          end
          return ""
        end,
      })
    end
  },
  {
    "simeji/winresizer",
    keys = {
      { "<C-w>e", ":WinResizerStartResize<CR>" }
    },
    config = function()
      vim.cmd([[
        let g:winresizer_vert_resize = 3
        let g:winresizer_horiz_resize = 2
      ]])
    end
  },
  {
    'andymass/vim-matchup',
    event = 'VeryLazy',
    config = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      -- vim.api.nvim_set_hl(0, 'MatchParen', { fg = "lightblue2" })
      -- vim.api.nvim_set_hl(0, 'MatchWord', { fg = "lightblue2" })
      vim.api.nvim_set_hl(0, 'MatchWordCur', { underline = true })
      vim.api.nvim_set_hl(0, 'MatchParenCur', {}) -- NONEと同じ
    end
  },
  {
    'kevinhwang91/nvim-hlslens',
    event = 'VeryLazy',
    dependencies = {
      'haya14busa/vim-asterisk'
    },
    config = function()
      local kopts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('n', '<ESC><ESC>', ':nohl <CR>', {})
      vim.api.nvim_set_keymap('n', 'n',
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts)
      vim.api.nvim_set_keymap('n', 'N',
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts)
      vim.api.nvim_set_keymap('n', '*', [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap('n', '#', [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap('n', 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap('n', 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], {})

      vim.api.nvim_set_keymap('x', '*', [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap('x', '#', [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap('x', 'g*', [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]], {})
      vim.api.nvim_set_keymap('x', 'g#', [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]], {})
    end
  },
  {
    'petertriho/nvim-scrollbar',
    event = 'BufEnter',
    dependencies = { 'kevinhwang91/nvim-hlslens' },
    config = function()
      require('scrollbar').setup({
        handle = {
          text = "  ",
          blend = 85,
          highlight = 'TermCursor',
        },
        marks = {
          Cursor = { highlight = 'TermCursor' },
          Search = { text = { "--", "==" } },
          Error = { text = { "--", "==" } },
          Warn = { text = { "--", "==" } },
          Info = { text = { "--", "==" } },
          Hint = { text = { "--", "==" } },
          Misc = { highlight = 'TermCursor', text = { "--", "==" } },
        },
        handlers = {
          cursor = false
        },
        excluded_filetypes = {
          "TelescopeResults",
          "NvimTree",
          "DressingInput",
          "blink-cmp-menu",
          "blink-cmp-documentation"
        }
      })
      require('scrollbar.handlers.search').setup()
    end
  },
}
