return {
  {
    "neovim/nvim-lspconfig",
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
      'saadparwaiz1/cmp_luasnip',
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
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'zbirenbaum/copilot-cmp' },
      { 'onsails/lspkind.nvim' }
    },
    -- keys = {
    --   { "D",  "<cmd>lua vim.lsp.buf.hover()<CR>" },
    --   { "gd", "<cmd>lua vim.lsp.buf.definition({reuse_win = true})<CR>" },
    --   { "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>" },
    --   { "gr", "<cmd>lua vim.lsp.buf.references()<CR>" },
    --   { "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>" },
    --   { "gn", "<cmd>lua vim.lsp.buf.rename()<CR>" },
    --   { "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>" },
    --   { "ge", "<cmd>lua vim.lsp.buf.open_float()<CR>" },
    -- },
    config = function()
      require("copilot_cmp").setup()
      local cmp = require('cmp')
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local lspkind = require('lspkind')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<S-TAB>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<TAB>"] = cmp.mapping.select_next_item(),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-l>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              return cmp.complete_common_string()
            end
            fallback()
          end, { 'i', 'c' }),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        }),

        sources = cmp.config.sources({
          { name = 'nvim_lsp',               priority = 8 },
          { name = 'copilot',                priority = 9 },
          { name = 'luasnip',                priority = 5 },
          { name = 'nvim_lsp_signature_help' },
        }, {
          { name = 'buffer', priority = 7 },
        }),
        formatting = {
          format = lspkind.cmp_format({
            max_width = 50,
            symbol_map = { Copilot = "" }
          }),
        }
      })
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
          { name = 'luasnip', priority = 10 },
        }, {
          { name = 'buffer', priority = 9 },
        })
      })

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
      -- cmp.setup.cmdline(':', {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = cmp.config.sources({
      --     { name = 'path' }
      --   }, {
      --     { name = 'cmdline' }
      --   })
      -- })

      -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      --   vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true }
      -- )
    end
  },
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    dependencies = { 'nvim-lspconfig' },
    keys = {
      { "D",  "<cmd>Lspsaga hover_doc<CR>" },
      { "gd", "<cmd>Lspsaga goto_definition<CR>" },
      { "gD", "<cmd>Lspsaga peek_definition<CR>" },
      { "gr", "<cmd>Lspsaga finder<CR>" },
      { "gn", "<cmd>Lspsaga rename<CR>" },
      -- { "ga", "<cmd>Lspsaga code_action<CR>" },
      { "gl", "<cmd>Lspsaga show_line_diagnostics<CR>" },
    },
    config = function()
      local keys = {
        edit = { '<CR>', 'o' },
        vsplit = '<C-v>',
        split = '<C-s>',
        tabe = '<C-g>e',
        close = '<C-c>k',
        quit = { 'q', '<C-W>c', '<ECS>' },
        shuttle = '<C-w><C-w>',
        toggle_or_req = 'u',
        toggle_or_open = { '<CR>', 'o' },
      }
      -- https://github.com/nvimdev/lspsaga.nvim/blob/main/lua/lspsaga/init.lua
      require('lspsaga').setup({
        request_timeout = 500,
        border_stype = 'rounded',
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
          max_height = 0.8,
          open_link = 'gx',
          open_cmd = '!chrome',
        },
        diagnostic = {
          enable = true,
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
    event = "VeryLazy",
    config = function()
      -- Example mapping to toggle outline
      require('outline').setup({})
      vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = true },
        panel = { enabled = false },
        copilot_node_command = vim.fn.system("asdf where nodejs 20.8.1"):gsub("\n$", "") .. "/bin/node", -- Node.js version must be > 18.x
      })
    end,
  },
  {
    'aznhe21/actions-preview.nvim',
    event = { "BufReadPre", "BufNewFile" },
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
    "RRethy/nvim-treesitter-endwise",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter.configs").setup({
        endwise = {
          enable = true,
        },
      })
    end
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      bind = false,
      hint_enable = false,
      floating_window_off_x = 0
    },
  }
}
