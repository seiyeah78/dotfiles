return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      "giuxtaposition/blink-cmp-copilot",
      "zbirenbaum/copilot.lua",
    },
    version = '*',
    opts = {
      enabled = function() return not vim.tbl_contains({ "AvantePromptInput" }, vim.bo.filetype) end,
      keymap = {
        preset = "enter",
      },
      cmdline = {
        keymap = {
          preset = "cmdline",
          ['<CR>'] = {
            function(cmp)
              if cmp.snippet_active() then
                return cmp.accept()
              else
                return cmp.accept_and_enter()
              end
            end,
            'fallback'
          },
        },
        completion = {
          list = {
            selection = {
              preselect = false,
              auto_insert = true,
            }
          },
          menu = {
            auto_show = true,
          },
        }
      },
      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      signature = { enabled = true },
      completion = {
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          }
        },
        accept = {
          auto_brackets = { enabled = true },
        },
        menu = {
          scrollbar = false,
          border = 'single',
          draw = {
            columns = { { "label", "label_description" }, { "kind_icon", "kind", gap = 1 } }
          }
        },
        documentation = {
          auto_show = true,
          window = {
            scrollbar = false,
            border = 'single',
          },
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                item.kind_icon = ''
                item.kind_name = 'Copilot'
              end
              return items
            end
          },
        },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    opts_extend = { "sources.default" }
  }
}
