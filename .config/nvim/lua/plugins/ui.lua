local remap = vim.api.nvim_set_keymap

return {
  {
    {
      'nvim-tree/nvim-tree.lua',
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
      opts = {
        ft_blocklist = { 'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive', 'fugitiveblame',
          'nerdtree', 'NvimTree' },
        trim_last_line = true,
      },
    },
    {
      'gelguy/wilder.nvim',
      config = function()
        local wilder = require('wilder')
        wilder.setup({
          modes = { ':', '/', '?' },
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
      config = function()
        local npairs = require('nvim-autopairs')
        local Rule = require('nvim-autopairs.rule')
        npairs.setup({
          map_cr = false,
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
        -- skip it, if you use another global object
        _G.MUtils = {}

        MUtils.completion_confirm = function()
          if vim.fn["coc#pum#visible"]() ~= 0 then
            return vim.fn["coc#pum#confirm"]()
          else
            return npairs.autopairs_cr()
          end
        end
        remap('i', '<CR>', 'v:lua.MUtils.completion_confirm()', { expr = true, noremap = true })
      end
    },

    {
      'keaising/im-select.nvim',
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
      config = function()
        require('ibl').setup({
          scope = { enabled = true },
          viewport_buffer = { min = 10, max = 100 }
        })
      end
    }
  }
}
