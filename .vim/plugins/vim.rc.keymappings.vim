"================= NERDTree setting ==================
let g:NERDTreeChDirMode = 2
let NERDTreeShowHidden = 1
let g:NERDTreeWinSize = 25
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeMapMenu = 'M'

nnoremap <silent><Leader><S-n><S-n> :NERDTreeToggle<CR>
nnoremap <silent><Leader><S-n>f :NERDTreeFind<CR>

" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

