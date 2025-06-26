return {
  {
    'junegunn/fzf',
    lazy = false,
    build = function()
      vim.cmd([[ call fzf#install() ]])
    end,
    dependencies = {
      "ibhagwan/fzf-lua"
    }
  },
  {
    'junegunn/fzf.vim',
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
      { "<leader>ag",    "y:Ag <C-R>\"<CR>",             mode = "x" },
      { "<leader>rg",    ":Rg <C-R><C-W><CR>" },
      { "<leader>RG",    ":Rg <C-R><C-A><CR>" },
      { "<leader>b",     "<cmd>Buffers<CR>" },
      { "<leader>rg",    "y:Rg <C-R>\"<CR>",             mode = "x" },
      { "<leader><tab>", "<Plug>(fzf-maps-n)",           noremap = false },
      { "<leader><tab>", "<Plug>(fzf-maps-x)",           noremap = false, mode = "x" },
      { "<leader><tab>", "<Plug>(fzf-maps-o)",           noremap = false, mode = "o" },
      { "<C-X<C-W>",     "<Plug>(fzf-complete-word)",    noremap = false, mode = "i" },
      { "<C-X<C-P>",     "<Plug>(fzf-complete-file-ag)", noremap = false, mode = "i" },
      { "<C-X<C-L>",     "<Plug>(fzf-complete-line)",    noremap = false, mode = "i" },
    },
    config = function()
      vim.cmd([[
        " Augmenting Ag command using fzf#vim#with_preview function
        " プロンプト表示を「コマンド名（検索文字列）> 」みたいにする
        function! s:exec_grep_command(arg, is_bang, command_name)
          let tokens = split(a:arg)
          let opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
          let query = join(filter(copy(tokens), 'v:val !~ "^-"'))

          let fzf_options = {'options': ''}
          let cul_dir = ' (' . getcwd() . ') '

          let display_search_str = '> "'
          if !empty(query)
            let display_search_str = '['.query.']> "'
          endif

          let fzf_options.options .= ' --prompt="'.a:command_name. cul_dir. display_search_str

          if a:is_bang
            let fzf_options = fzf#vim#with_preview(fzf_options, 'up:60%')
          else
            let fzf_options = fzf#vim#with_preview(fzf_options, 'right:50%:hidden', '?')
            end

            if a:command_name == 'Ag'
              call fzf#vim#ag(query, opts. ' --hidden --skip-vcs-ignores --path-to-ignore ~/.ignore', fzf_options, a:is_bang)
            else
              call fzf#vim#grep(
                    \  'rg --column --line-number --hidden --no-heading --color always --no-ignore --ignore-file ~/.ignore '.shellescape(query),
                    \  1,
                    \  fzf_options,
                    \  a:is_bang)
            endif
          endfunction

          command! -bang -nargs=* Ag call s:exec_grep_command(<q-args>, <bang>0, 'Ag')
          command! -bang -nargs=* Rg call s:exec_grep_command(<q-args>, <bang>0, 'Rg')


      ]])
      -- vim.api.nvim_create_autocmd("FileType", {
      --   pattern = "fzf",
      --   callback = function()
      --     vim.keymap.del("t", "<ECS>")
      --   end,
      -- })
      if vim.fn.exists('$TMUX') == 1 then
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
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('fzf-lua').setup({
        winopts = {
          preview = {
            default = "bat",
          },
        },
        grep = {
          cmd = "rg",
          file_icons = false,
          color_icons = false,
          git_icons = false,
        },
      })
    end
  }
}
