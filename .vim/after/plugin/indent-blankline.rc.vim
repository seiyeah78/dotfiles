let char_highlight_list = []
let s:indent_blankline_colorful = get(g:, 'indent_blankline_colorful', 0)
let s:indent_blankline_vscode_rainbow_mode = get(g:, 'indent_blankline_vscode_rainbow_mode', 0)

if(s:indent_blankline_colorful)
  " let g:indent_blankline_show_current_context = v:false
  let char_highlight_list_prefix = 'IndentBlanklineChar'
  let space_char_highlight_prefix = 'IndentBlanklineSpaceChar'

  " like VSCode indent-rainbow
  if(s:indent_blankline_vscode_rainbow_mode)
    let g:indent_blankline_char = '▏'
    let char_highlight_list = [['#788898','#4E5F00'], ['#788898','#005A00'], ['#788898','#53005C'], ['#788898','#004B4F']]
  else
    let char_highlight_list = [['#E06C75',''], ['#E5C07B',''], ['#98C379',''], ['#56B6C2',''], ['#61AFEF',''], ['#C678DD','']]
  endif

  let i = 1
  for colors in char_highlight_list
    execute('hi '.char_highlight_list_prefix.i.' guifg='.colors[0].' guibg='.colors[1].' blend=nocombine')
    execute('hi '.space_char_highlight_prefix.i.' guibg='.colors[1].' blend=nocombine')
    let i = i + 1
  endfor

  let g:indent_blankline_char_highlight_list = map(range(1, len(char_highlight_list)),'char_highlight_list_prefix.v:val')
  let g:indent_blankline_space_char_highlight_list = map(range(1, len(char_highlight_list)),'space_char_highlight_prefix.v:val')
endif
let g:indent_blankline_space_char_blankline = " "
let g:indent_blankline_show_trailing_blankline_indent = v:false
let g:indent_blankline_filetype_exclude = ['help','dashboard','dashpreview','NvimTree','coc-explorer','startify','vista','sagahover','qfreplace','gitcommit','tagbar']
