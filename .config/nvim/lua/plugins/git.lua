return {
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'rhysd/git-messenger.vim',
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      vim.keymap.set({ "n" }, "<Leader>ga", ':DiffviewFileHistory % <CR>', { silent = true })
      require('gitsigns').setup {
        signs                             = {
          add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
          change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
          delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
          topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
          changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        },
        signcolumn                        = false, -- Toggle with `:Gitsigns toggle_signs`
        numhl                             = true,  -- Toggle with `:Gitsigns toggle_numhl`
        linehl                            = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                         = false, -- Toggle with `:Gitsigns toggle_word_diff`
        on_attach                         = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']g', function()
            if vim.wo.diff then return ']g' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[g', function()
            if vim.wo.diff then return '[g' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })
        end,
        watch_gitdir                      = {
          interval = 1000,
          follow_files = true
        },
        attach_to_untracked               = true,
        current_line_blame                = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts           = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
        },
        current_line_blame_formatter_opts = {
          relative_time = false
        },
        sign_priority                     = 6,
        update_debounce                   = 100,
        status_formatter                  = nil, -- Use default
        max_file_length                   = 40000,
        preview_config                    = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        yadm                              = {
          enable = false
        },
      }
    end
  },
  {
    'sindrets/diffview.nvim',
    config = function()
      -- local cb = require'diffview.config'.diffview_callback
      require 'diffview'.setup {
        file_panel = {
          win_config = {
            position = "left",    -- One of 'left', 'right', 'top', 'bottom'
            width = 35,           -- Only applies when position is 'left' or 'right'
            height = 10           -- Only applies when position is 'top' or 'bottom'
          },
          listing_style = "list", -- One of 'list' or 'tree'
          tree_options = {
            -- Only applies when listing_style is 'tree'
            flatten_dirs = false,
            folder_statuses = "always" -- One of 'never', 'only_folded' or 'always'.
          }
        },
        key_bindings = {
          disable_defaults = false,
          view = {
            ["q"] = '<cmd>lua require"diffview".close()<CR>',
          },
          file_panel = {
            ["q"] = '<cmd>lua require"diffview".close()<CR>',
            -- ["j"] = cb("select_next_entry"),
            -- ["k"] = cb("select_prev_entry"),
          },
          file_history_panel = {
            ["q"] = '<cmd>lua require"diffview".close()<CR>',
            -- ["j"] = cb("select_next_entry"),
            -- ["k"] = cb("select_prev_entry"),
          }
        }
      }
    end
  },
}
