" ------------ markdown setting ----------
let g:netrw_nogx = 1 " disable netrw's gx mapping.
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_close_text = 'TOC'
let g:vmt_fence_hidden_markdown_style = 'GFM'
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

function! s:ExecGenToc()
  let &filetype=g:vmt_fence_hidden_markdown_style.'.'.&filetype
  execute ':GenTocModeline'
  let &filetype='markdown'
endfunction
command! GenToc :call <SID>ExecGenToc()

let g:NERDTreeMapMenu = 'M'
