return {
  {
    'junegunn/fzf.vim',
    build = function()
      vim.cmd([[ call fzf#install() ]])
    end,
    lazy = false,
    dependencies = {
      'junegunn/fzf',
    },
    cmd = {
      "FZF",
      "Ag",
      "AG",
      "Rg",
      "RG",
      "Files",
      "GFiles",
      "GFiles",
      "Buffers",
      "Colors",
      "Lines",
      "BLines",
      "Tags",
      "BTags",
      "Changes",
      "Marks",
      "Jumps",
      "Windows",
      "Locate",
      "History",
      "History",
      "History",
      "Snippets",
      "Commits",
      "BCommits",
      "Commands",
      "Maps",
      "Helptags",
      "Filetypes",
    },
    keys = {
      { "<leader>ag",    ":Ag <C-R><C-W><CR>" },
      { "<leader>AG",    ":Ag <C-R><C-A><CR>" },
      { "<leader>ag",    "y:Ag <C-R><CR>",               mode = "x" },
      { "<leader>rg",    ":Rg <C-R><C-W><CR>" },
      { "<leader>RG",    ":Rg <C-R><C-A><CR>" },
      { "<leader>rg",    "y:Rg <C-R><CR>",               mode = "x" },
      { "<leader><tab>", "<Plug>(fzf-maps-n)",           noremap = false },
      { "<leader><tab>", "<Plug>(fzf-maps-x)",           noremap = false, mode = "x" },
      { "<leader><tab>", "<Plug>(fzf-maps-o)",           noremap = false, mode = "o" },
      { "<C-X<C-W>",     "<Plug>(fzf-complete-word)",    noremap = false, mode = "i" },
      { "<C-X<C-P>",     "<Plug>(fzf-complete-file-ag)", noremap = false, mode = "i" },
      { "<C-X<C-L>",     "<Plug>(fzf-complete-line)",    noremap = false, mode = "i" },
    },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fzf",
        callback = function()
          vim.keymap.del("t", "<ECS>")
        end,
      })
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "*",
        callback = function()
          vim.keymap.set("t", "<ECS>", "<C-\\><C-N>", { noremap = true })
        end,
      })
      vim.api.nvim_create_autocmd("VimEnter", {
        pattern = "*",
        callback = function()
          vim.keymap.set('n', '<leader>b', "<cmd>Buffers<CR>")
          vim.api.nvim_create_user_command('Colors',
            ":call fzf#vim#colors({'left': '~15%', 'options': '--reverse --margin 20%,0'})",
            { bang = true })
        end,
      })
      if vim.fn.exists('$TMUX') then
        vim.g.fzf_layout = { tmux = vim.env.FZF_TMUX_OPTS }
      else
        vim.g.fzf_layout = { window = { width = 0.7, height = 0.5 } }
      end
      vim.g.fzf_files_options = '-i --tiebreak=end,index ' .. vim.env.FZF_PREVIEW_OPTS
      vim.g.fzf_buffers_jump = 1
      vim.g.fzf_action = {
        ['ctrl-s'] = 'split',
        ['ctrl-v'] = 'vsplit',
        ['ctrl-g'] = 'tabnew'
      }
    end
  },
}
