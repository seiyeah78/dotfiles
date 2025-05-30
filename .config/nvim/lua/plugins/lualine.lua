return {
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'tokyonight',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = { {
            'mode',
            fmt = function(res)
              if string.find(res, '-') then
                return res:sub(1, 3)
              else
                return res:sub(1, 1)
              end
            end
          } },
          lualine_b = { 'branch', 'diff', 'diagnostics', function()
            return require('arrow.statusline')
                .text_for_statusline_with_icons()
          end },
          lualine_c = {
            'ObsessionStatus',
            { 'filename', path = 1 },
            require('lsp-progress').progress,
          },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      }
    end
  },
}
