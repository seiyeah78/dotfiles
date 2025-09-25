return {
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/", "~/projects", "~/codes" },
    },
    config = function()
      require('auto-session').setup()
      vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal,localoptions"
    end,
  },
}
