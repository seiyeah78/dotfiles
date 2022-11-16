-- https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = "99999"

require('nvim-treesitter.configs').setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "haskell", "markdown", "beancount", "swift" },
  highlight = {
    enable = true,  -- false will disable the whole extension
    disable = {
      'lua',
      'ruby',
      'toml',
      'c_sharp',
      'vue',
      'bash',
      'haskell',
      'vim',
      'html',
      'markdown',
      'swift',
      'beancount'
    }
  },
  indent = {
    enable = true,
    disable = {
      'python',
      'yaml',
      'ruby'
    }
  }
}

require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  keymaps = {
    -- Default keymap options
    noremap = false,

    ['n ]g'] = { expr = true, "&diff ? ']g' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n [g'] = { expr = true, "&diff ? '[g' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    -- ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    -- ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    -- ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    -- ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    -- ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    -- ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    -- ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    -- ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
    -- ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
    -- ['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

    -- Text objects
    -- ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    -- ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
  },
  current_line_blame_formatter_opts = {
    relative_time = false
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}

-- local cb = require'diffview.config'.diffview_callback
require'diffview'.setup {
  file_panel = {
    win_config = {
      position = "left",            -- One of 'left', 'right', 'top', 'bottom'
      width = 35,                 -- Only applies when position is 'left' or 'right'
      height = 10                -- Only applies when position is 'top' or 'bottom'
    },
    listing_style = "list",       -- One of 'list' or 'tree'
    tree_options = {              -- Only applies when listing_style is 'tree'
      flatten_dirs = false,
      folder_statuses = "always"  -- One of 'never', 'only_folded' or 'always'.
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

require'treesitter-context'.setup {
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  throttle = true, -- Throttles plugin updates (may improve performance)
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
    -- For all filetypes
    -- Note that setting an entry here replaces all other patterns for this entry.
    -- By setting the 'default' entry below, you can control which nodes you want to
    -- appear in the context window.
    default = {
      'class',
      'function',
      'method',
      -- 'for', -- These won't appear in the context
      -- 'while',
      -- 'if',
      -- 'switch',
      -- 'case',
    },
    -- Example for a specific filetype.
    -- If a pattern is missing, *open a PR* so everyone can benefit.
    --   rust = {
    --       'impl_item',
    --   },
  },
}


require 'wilder'.setup {
  modes = { ':' },
  next_key = {'<C-J>', '<Tab>'},
  previous_key = {'<C-K>', '<S-Tab>'},
  enable_cmdline_enter = 0
}
vim.cmd [[
if has('nvim-0.7')
  call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
        \ 'highlighter': wilder#basic_highlighter(),
        \ 'highlights': {
        \   'border': 'Normal',
        \   'accent': wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}])
        \ },
        \ 'left': [
        \   ' ', wilder#popupmenu_devicons(),
        \ ],
        \ 'right': [
        \   ' ', wilder#popupmenu_scrollbar(),
        \ ],
        \ 'border': 'rounded',
        \ })))
  call wilder#set_option('pipeline', [
        \   wilder#branch(
        \     wilder#cmdline_pipeline({
        \       'language': 'python',
        \       'fuzzy': 1,
        \     }),
        \     wilder#python_search_pipeline({
        \       'pattern': wilder#python_fuzzy_pattern(),
        \       'sorter': wilder#python_difflib_sorter(),
        \       'engine': 're',
        \     }),
        \   ),
        \ ])
fi
]]

local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')
npairs.setup(
  {
    map_cr = false,
    fast_wrap = {}
  }
)

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.completion_confirm=function()
    if vim.fn["coc#pum#visible"]() ~= 0  then
        return vim.fn["coc#pum#confirm"]()
    else
        return npairs.autopairs_cr()
    end
end

remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})

require('distant').setup {
  -- Applies Chip's personal settings to every machine you connect to
  --
  -- 1. Ensures that distant servers terminate with no connections
  -- 2. Provides navigation bindings for remote directories
  -- 3. Provides keybinding to jump into a remote file's parent directory
  ['*'] = require('distant.settings').chip_default()
}

local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')
npairs.setup({
  map_cr = false,
  map_c_h = true,
  map_c_w = true,
  fast_wrap = {},
})

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.completion_confirm=function()
    if vim.fn["coc#pum#visible"]() ~= 0  then
        return vim.fn["coc#pum#confirm"]()
    else
        return npairs.autopairs_cr()
    end
end

remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})

require("nvim-tree").setup({
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
