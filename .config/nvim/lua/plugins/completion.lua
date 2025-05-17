return {
  {
    "neovim/nvim-lspconfig",
    evnet = "LspAttach",
    config = function()
      vim.diagnostic.config({
        update_in_insert = false,
        virtual_text = false,
        signs = true,
        underline = true,
        severity_sort = true,
        float = {
          source = "always", -- Or "if_many"
          border = 'rounded'
        },
      })
    end
  },
  {
    'L3MON4D3/LuaSnip',
    event = 'InsertEnter',
    dependencies = {
      'rafamadriz/friendly-snippets'
    },
    config = function()
      require("luasnip/loaders/from_vscode").lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load()
      local ls = require("luasnip")
      vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<TAB>", function()
        if ls.expand_or_jumpable() then
          ls.jump(1)
        else
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<TAB>', true, true, true), 'n')
        end
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<S-TAB>", function()
        if ls.expand_or_jumpable() then
          ls.jump(-1)
        else
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<S-TAB>', true, true, true), 'n')
        end
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(1) end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-K>", function() ls.jump(-1) end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-E>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })
    end
  },
  -- {
  --   'hrsh7th/nvim-cmp',
  --   event = 'InsertEnter',
  --   dependencies = {
  --     { 'hrsh7th/cmp-nvim-lsp' },
  --     { 'hrsh7th/cmp-buffer' },
  --     { 'hrsh7th/cmp-path' },
  --     { 'hrsh7th/cmp-cmdline' },
  --     { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
  --     { 'zbirenbaum/copilot-cmp' },
  --     { 'onsails/lspkind.nvim' }
  --   },
  --   keys = {
  --     -- { "D",  "<cmd>lua vim.lsp.buf.hover()<CR>" },
  --     -- { "gd", "<cmd>lua vim.lsp.buf.definition({reuse_win = true})<CR>" },
  --     -- { "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>" },
  --     -- { "gr", "<cmd>lua vim.lsp.buf.references()<CR>" },
  --     -- { "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>" },
  --     -- { "gn", "<cmd>lua vim.lsp.buf.rename()<CR>" },
  --     -- { "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>" },
  --     { "gl", "<cmd>lua vim.diagnostic.open_float()<CR>" },
  --   },
  --   config = function()
  --     local cmp = require('cmp')
  --     local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  --     local lspkind = require('lspkind')
  --     ---Return view is visible or not.
  --     cmp.visible = function()
  --       return cmp.core.view:visible() or vim.fn.pumvisible() == 1
  --     end
  --     cmp.event:on(
  --       'confirm_done',
  --       cmp_autopairs.on_confirm_done()
  --     )
  --     cmp.setup({
  --       preselect = cmp.PreselectMode.None, -- 補完開始時に選択させない
  --       -- completion = {
  --       --   completeopt = "menu,menuone,noneselect"
  --       -- },
  --       snippet = {
  --         expand = function(args)
  --           require('luasnip').lsp_expand(args.body)
  --         end,
  --       },
  --       window = {
  --         completion = cmp.config.window.bordered(),
  --         documentation = cmp.config.window.bordered(),
  --       },
  --
  --       mapping = cmp.mapping.preset.insert({
  --         ["<C-p>"] = cmp.mapping.select_prev_item(),
  --         ["<S-TAB>"] = cmp.mapping.select_prev_item(),
  --         ["<C-n>"] = cmp.mapping.select_next_item(),
  --         ["<TAB>"] = cmp.mapping.select_next_item(),
  --         ['<C-Space>'] = cmp.mapping.complete(),
  --         ['<C-l>'] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             return cmp.complete_common_string()
  --           end
  --           fallback()
  --         end, { 'i', 'c' }),
  --         ['<C-e>'] = cmp.mapping.abort(),
  --         ['<CR>'] = cmp.mapping.confirm({ select = false }),
  --       }),
  --
  --       sources = cmp.config.sources({
  --         { name = 'nvim_lsp',       priority = 100, max_item_count = 20 },
  --         { name = 'luasnip',        priority = 50,  max_item_count = 10 },
  --         { name = 'copilot',        priority = 0 },
  --         { name = 'render-markdown' }
  --       }, {
  --         { name = 'buffer', priority = 70 },
  --       }),
  --       formatting = {
  --         format = lspkind.cmp_format({
  --           max_width = 10,
  --           symbol_map = { Copilot = "" }
  --         }),
  --       }
  --     })
  --     cmp.setup.filetype('gitcommit', {
  --       sources = cmp.config.sources({
  --         { name = 'git' },
  --         { name = 'luasnip', priority = 10 },
  --       }, {
  --         { name = 'buffer', priority = 9 },
  --       })
  --     })
  --     cmp.setup.filetype({ 'typescript', 'typescriptreact' }, {
  --       window = {
  --         documentation = cmp.config.disable
  --       }
  --     })
  --     cmp.setup.cmdline({ '/', '?' }, {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = {
  --         { name = 'nvim_lsp_document_symbol' }
  --       },
  --       {
  --         { name = 'buffer' }
  --       }
  --     })
  --     cmp.setup.cmdline(':', {
  --       mapping = cmp.mapping.preset.cmdline(),
  --       sources = cmp.config.sources({
  --         { name = 'path' }
  --       }, {
  --         { name = 'cmdline' }
  --       })
  --     })
  --
  --     require("copilot_cmp").setup()
  --   end
  -- },
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    dependencies = { 'nvim-lspconfig' },
    keys = {
      { "D",  "<cmd>Lspsaga hover_doc<CR>" },
      -- { "gd", "<cmd>Lspsaga goto_definition<CR>" },
      { "gD", "<cmd>Lspsaga peek_definition<CR>" },
      { "gt", "<cmd>Lspsaga goto_type_definition<CR>" },
      { "gr", "<cmd>Lspsaga finder<CR>" },
      { "gm", "<cmd>Lspsaga rename<CR>" },
    },
    config = function()
      local keys = {
        edit = { '<CR>', 'o' },
        vsplit = '<C-v>',
        split = '<C-s>',
        tabe = '<C-g>e',
        close = '<C-c>k',
        quit = { 'q', '<C-W>c', '<ESC>' },
        shuttle = '<C-w><C-w>',
        toggle_or_req = 'u',
        toggle_or_open = { '<CR>', 'o' },
      }
      -- https://github.com/nvimdev/lspsaga.nvim/blob/main/lua/lspsaga/init.lua
      require('lspsaga').setup({
        request_timeout = 500,
        ui = {
          winbar_prefix = '',
          border = vim.o.winborder,
          devicon = true,
          foldericon = true,
          title = true,
          expand = '⊞',
          collapse = '⊟',
          code_action = '💡',
          lines = { '┗', '┣', '┃', '━', '┏' },
          kind = nil,
          button = { '', '' },
          imp_sign = '󰳛 ',
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
          debounce = 500
        },
        hover = {
          max_width = 0.9,
          max_height = 1.0,
          open_link = 'gx',
          open_cmd = '!chrome',
        },
        diagnostic = {
          enable = false, -- falseにしないとnvim-lintの診断と重複して出てしまう(存在しないオプションだけど)
          diagnostic_only_current = true,
          extend_relatedInformation = true
        },
        definition = {
          width = 0.6,
          height = 0.5,
          save_pos = true,
          keys = keys,
        },
        callhierarchy = {
          layout = 'float',
          left_width = 0.2,
          keys = keys,
        },
        finder = {
          max_height = 0.5,
          left_width = 0.3,
          methods = {},
          default = 'tyd+ref+imp',
          layout = 'float',
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
        suggestion = { enabled = false },
        panel = { enabled = false },
        copilot_node_command = vim.fn.system("asdf where nodejs 20.8.1"):gsub("\n$", "") ..
            "/bin/node", -- Node.js version must be > 18.x
      })
    end,
  },
  {
    'aznhe21/actions-preview.nvim',
    -- event = { "BufReadPre", "BufNewFile" },
    dependencies = { 'kosayoda/nvim-lightbulb' },
    config = function()
      vim.keymap.set({ "v", "n" }, "ga", require("actions-preview").code_actions)
      require("nvim-lightbulb").setup({
        priority = 1000,
        autocmd = { enabled = true },
        sign = {
          enabled = false
        },
        virtual_text = {
          enabled = true
        }
      })
    end
  },
  {
    'dmmulroy/ts-error-translator.nvim',
    config = function()
      require('ts-error-translator').setup()
    end
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
