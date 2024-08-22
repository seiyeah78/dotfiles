return {
  {
    'tpope/vim-fugitive',
    dependencies = {
      'tpope/vim-rhubarb',
    },
    config = function()
      vim.cmd([[
        " Open current line on GitHub
        nnoremap <Leader>go :GBrowse<CR>
        vnoremap <Leader>go :GBrowse<CR>
        nnoremap <Leader>gv :GV!<CR>

        " git add current file
        noremap <Leader>gs :Git<CR>
        noremap <Leader>gF :GFiles?<CR>
        noremap <Leader>gb :Git blame<CR>
        noremap <Leader>gd :Gvdiff<CR>
      ]])
    end,
  },
  {
    'rhysd/git-messenger.vim',
    keys = {
      "<C-w>m", "<Plug>(git-messenger)", mode = "n"
    },
    cmd = { 'GitMessenger' },
    config = function()
      vim.cmd([[
        let g:git_messenger_include_diff = 'current'
        let g:git_messenger_always_into_popup = v:true
        let g:git_messenger_max_popup_height = 100
        function! s:setup_git_messenger_popup() abort
          " Your favorite configuration here
          " For example, set go back/forward history to <C-o>/<C-i>
          nmap <buffer><ESC> q
          nmap <buffer><C-o> o
          nmap <buffer><C-i> O
        endfunction
        autocmd FileType gitmessengerpopup call <SID>setup_git_messenger_popup()
      ]])
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('gitsigns').setup {
        signs                   = {
          add          = { text = '│' },
          change       = { text = '│' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
        },
        signcolumn              = false,           -- Toggle with `:Gitsigns toggle_signs`
        numhl                   = true,            -- Toggle with `:Gitsigns toggle_numhl`
        linehl                  = false,           -- Toggle with `:Gitsigns toggle_linehl`
        word_diff               = false,           -- Toggle with `:Gitsigns toggle_word_diff`
        on_attach               = function(bufnr)
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
        watch_gitdir            = {
          interval = 1000,
          follow_files = true
        },
        attach_to_untracked     = true,
        current_line_blame      = false,           -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
        },
        sign_priority           = 6,
        update_debounce         = 100,
        status_formatter        = nil,           -- Use default
        max_file_length         = 40000,
        preview_config          = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
      }
    end
  },
  {
    'sindrets/diffview.nvim',
    keys = {
      { "<Leader>ga", ":DiffviewFileHistory % <CR>", { silent = true } },
    },
    config = function()
      -- local cb = require'diffview.config'.diffview_callback
      require 'diffview'.setup {
        file_panel = {
          win_config = {
            position = "left",         -- One of 'left', 'right', 'top', 'bottom'
            width = 35,                -- Only applies when position is 'left' or 'right'
            height = 10                -- Only applies when position is 'top' or 'bottom'
          },
          listing_style = "list",      -- One of 'list' or 'tree'
          tree_options = {             -- Only applies when listing_style is 'tree'
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
        },
        hooks = {}
      }
    end
  },
}
