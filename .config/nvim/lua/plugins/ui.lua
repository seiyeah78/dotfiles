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
    event = 'VeryLazy',
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
    'cappyzawa/trim.nvim',
    event = "BufEnter",
    opts = {
      ft_blocklist = { 'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive', 'fugitiveblame',
        'nerdtree', 'NvimTree' },
      trim_last_line = true,
    },
  },
  {
    'gelguy/wilder.nvim',
    event = 'CmdlineEnter',
    config = function()
      local wilder = require('wilder')
      wilder.setup({
        modes = { ':', '/', '?' },
        next_key = '<TAB>',
        previous_key = '<S-TAB>',
      })
      wilder.set_option('renderer', wilder.popupmenu_renderer({
        highlighter = wilder.basic_highlighter(),
        left = { ' ', wilder.popupmenu_devicons() },
        right = { ' ', wilder.popupmenu_scrollbar() },
        highlights = {
          accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#f4468f' } }),
        },
      }))
    end
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      local npairs = require('nvim-autopairs')
      local Rule = require('nvim-autopairs.rule')
      npairs.setup({
        map_c_h = true,
        map_c_w = true,
        fast_wrap = {},
      })
      -- add autopairs role
      local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
      npairs.add_rules {
        Rule(' ', ' ')
            :with_pair(function(opts)
              local pair = opts.line:sub(opts.col - 1, opts.col)
              return vim.tbl_contains({
                brackets[1][1] .. brackets[1][2],
                brackets[2][1] .. brackets[2][2],
                brackets[3][1] .. brackets[3][2],
              }, pair)
            end)
      }
      for _, bracket in pairs(brackets) do
        npairs.add_rules {
          Rule(bracket[1] .. ' ', ' ' .. bracket[2])
              :with_pair(function() return false end)
              :with_move(function(opts)
                return opts.prev_char:match('.%' .. bracket[2]) ~= nil
              end)
              :use_key(bracket[2])
        }
      end
    end
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
    cmd = { "Trouble", "TroubleToggle" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      open_split = { "<c-s>" },
      open_tab = { "<c-t>" }
    }
  },
  {
    'm-demare/hlargs.nvim',
    event = "VeryLazy",
    config = function()
      require('hlargs').setup()
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
          local lsp_clients = vim.lsp.get_active_clients()
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
      { "<C-w>e", ":WinResizeStartResize<CR>" }
    },
    config = function()
      vim.cmd([[
        let g:winresizer_vert_resize = 3
        let g:winresizer_horiz_resize = 2
      ]])
    end
  },
  {
    'miversen33/sunglasses.nvim',
    opts = {
      filter_percent = 0.15
    }
  },
  {
    'andymass/vim-matchup',
    event = 'VeryLazy',
    config = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
      vim.api.nvim_set_hl(0, 'MatchParen', { fg = "darkorange2" })
      vim.api.nvim_set_hl(0, 'MatchWord', { fg = "darkorange2" })
      vim.api.nvim_set_hl(0, 'MatchWordCur', { underline = true })
      vim.api.nvim_set_hl(0, 'MatchParenCur', {}) -- NONEと同じ
    end
  },
}
