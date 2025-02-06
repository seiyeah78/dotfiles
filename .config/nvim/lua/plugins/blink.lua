return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      "giuxtaposition/blink-cmp-copilot",
    },
    version = '*',
    opts = {
      keymap = {
        preset = "enter",
        cmdline = {
          preset = "super-tab",
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
            auto_insert = function(ctx)
              return ctx.mode ~= 'cmdline' and not require('blink.cmp').snippet_active({ direction = 1 })
            end
          }
        },
        accept = {
          auto_brackets = { enabled = true },
        },
        menu = {
          scrollbar = false,
          border = 'single',
        },
        documentation = {
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
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
    opts_extend = { "sources.default" }
  }
}
