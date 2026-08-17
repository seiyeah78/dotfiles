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
      close_filetypes_on_save = { 'checkhealth', 'qf', 'fugitiveblame', 'gitcommit', 'Outline', 'OverseerOutput' },
      -- 復元直後に強制的にウィンドウを等倍化するフックを追加
      post_restore_cmds = {
        function()
          vim.cmd("wincmd =")
        end
      },
    },
    config = function(_, opts)
      require('auto-session').setup(opts)
      vim.opt.sessionoptions:remove("terminal")
      vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,terminal,localoptions"
    end,
  },
}
