return {
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      close_unsupported_windows = true,
      suppressed_dirs = {
        "~/",
        "~/Projects",
        "~/Downloads",
        "/",
        "~/projects",
        "~/codes",
        "/private/var",
        "/tmp",
      },
      close_filetypes_on_save = { 'checkhealth', 'qf', 'fugitiveblame', 'gitcommit' }
    },
    config = function(_, opts)
      require('auto-session').setup(opts)
      vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal,localoptions"
    end,
  },
}
