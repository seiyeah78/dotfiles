local remap = vim.api.nvim_set_keymap

return {
  {
    {
      'nvim-tree/nvim-tree.lua',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require("nvim-tree").setup({
          hijack_netrw = false,
          view = {
            mappings = {
              list = {
                { key = "<C-s>", action = "split" }
              },
            },
          },
          actions = {
            open_file = {
              window_picker = {
                enable = false
              }
            }
          }
        })
      end
    },
    {
      'cappyzawa/trim.nvim',
      config = function()
        require('trim').setup({
          ft_blocklist = { 'diff', 'git', 'gitcommit', 'unite', 'qf', 'help', 'markdown', 'fugitive', 'fugitiveblame',
            'nerdtree', 'NvimTree' },
          trim_last_line = true,
          -- if you want to remove multiple blank lines
          -- patterns = {
          --   [[%s/\(\n\n\)\n\+/\1/]],   -- replace multiple blank lines with a single line
          -- },
        })
      end
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
      'RRethy/vim-illuminate',
      config = function()
        -- default configuration
        require('illuminate').configure({
          -- providers: provider used to get references in the buffer, ordered by priority
          providers = {
            'lsp',
            'treesitter',
            'regex',
          },
          -- delay: delay in milliseconds
          delay = 100,
          -- filetype_overrides: filetype specific overrides.
          -- The keys are strings to represent the filetype while the values are tables that
          -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
          filetype_overrides = {},
          -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
          filetypes_denylist = {
            'dirvish',
            'fugitive',
            'NvimTree',
            'python'
          },
          -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
          filetypes_allowlist = {},
          -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
          -- See `:help mode()` for possible values
          modes_denylist = {},
          -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
          -- See `:help mode()` for possible values
          modes_allowlist = {},
          -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
          -- Only applies to the 'regex' provider
          -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
          providers_regex_syntax_denylist = {},
          -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
          -- Only applies to the 'regex' provider
          -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
          providers_regex_syntax_allowlist = {},
          -- under_cursor: whether or not to illuminate under the cursor
          under_cursor = false,
          -- large_file_cutoff: number of lines at which to use large_file_config
          -- The `under_cursor` option is disabled when this cutoff is hit
          large_file_cutoff = nil,
          -- large_file_config: config to use for large files (based on large_file_cutoff).
          -- Supports the same keys passed to .configure
          -- If nil, vim-illuminate will be disabled for large files.
          large_file_overrides = nil,
          -- min_count_to_highlight: minimum number of matches required to perform highlighting
          min_count_to_highlight = 1,
        })
      end,
      {
        'keaising/im-select.nvim',
        config = function()
          require('im_select').setup {
            default_im_select    = "com.google.inputmethod.Japanese.Roman",
            disable_auto_restore = 1,
          }
        end
      }
    }
  }
}
