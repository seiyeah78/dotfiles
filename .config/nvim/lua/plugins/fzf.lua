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
      { "<leader>ag",    "<cmd>Ag <C-R><C-W><CR>" },
      { "<leader>AG",    "<cmd>Ag <C-R><C-A><CR>" },
      { "<leader>ag",    "y<cmd>Ag <C-R><CR>",           mode = "x" },
      { "<leader>rg",    "<cmd>Rg <C-R><C-W><CR>" },
      { "<leader>RG",    "<cmd>Rg <C-R><C-A><CR>" },
      { "<leader>rg",    "y<cmd>Rg <C-R><CR>",           mode = "x" },
      { "<leader><tab>", "<Plug>(fzf-map-n)",            noremap = false },
      { "<leader><tab>", "<Plug>(fzf-map-x)",            noremap = false, mode = "x" },
      { "<leader><tab>", "<Plug>(fzf-map-o)",            noremap = false, mode = "o" },
      { "<C-X<C-W>",     "<Plug>(fzf-complete-word)",    mode = "i" },
      { "<C-X<C-P>",     "<Plug>(fzf-complete-file-ag)", mode = "i" },
      { "<C-X<C-L>",     "<Plug>(fzf-complete-line)",    mode = "i" },

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
            "<cmd> call fzf#vim#colors({'left': '~15%', 'options': '--reverse --margin 20%,0'})",
            { bang = true })
        end,
      })
      if vim.fn.exists('$TMUX') then
        vim.g.fzf_layout = { tmux = vim.env.FZF_TMUX_OPTS }
      else
        vim.g.fzf_layout = { window = { width = 0.7, height = 0.5 } }
      end
      vim.g.fzf_files_options = '-i --tiebreak=end,index' .. vim.env.FZF_PREVIEW_OPTS
      vim.g.fzf_buffers_jump = 1

      vim.cmd([[
        let g:fzf_action = {
              \ 'ctrl-s': 'split',
              \ 'ctrl-v': 'vsplit',
              \ 'ctrl-g': 'tabnew'
              \ }
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
        end
        autocmd VimEnter * command! -bang -nargs=* Rg call s:exec_grep_command(<q-args>, <bang>0, 'Rg')
        autocmd VimEnter * command! -bang -nargs=* Ag call s:exec_grep_command(<q-args>, <bang>0, 'Ag')
        endfunction
      ]])
    end
  },
}
