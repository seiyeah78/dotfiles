  require'nvim-treesitter.configs'.setup {
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ignore_install = { "haskell" },
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
        'python'
      }
    },
    indent = {
      enable = true,
      disable = {
        'python',
        'yaml'
      }
    }
  }
  require('gitsigns').setup()
