return {
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/", "~/projects", "~/codes" },
      close_filetypes_on_save = { 'checkhealth', 'qf' }
    },
    config = function(_, opts)
      require('auto-session').setup(opts)
      vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal,localoptions"
    end,
  },
}
