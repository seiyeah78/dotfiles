" ------------ markdown setting ----------
let g:netrw_nogx = 1 " disable netrw's gx mapping.
let g:mkdp_auto_close = 1
let g:mkdp_echo_preview_url = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_close_text = 'TOC'
let g:vmt_fence_hidden_markdown_style = 'GFM'
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

function! s:ExecGenToc()
  let l:tmp_filetype=&filetype
  let &filetype=g:vmt_fence_hidden_markdown_style.'.markdown'
  execute ':GenTocModeline'
  let &filetype=l:tmp_filetype
endfunction
command! GenToc :call <SID>ExecGenToc()
