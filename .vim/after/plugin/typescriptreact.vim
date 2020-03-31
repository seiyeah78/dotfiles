autocmd FileType typescriptreact set filetype=typescript.tsx
nnoremap <buffer><C-_><C-_> :TCommentAs <C-R>=&ft<CR><CR>
inoremap <buffer><C-_><C-_> <C-O>:TCommentAs <C-R>=&ft<CR><CR>
call tcomment#type#Define('typescriptreact', '{/* %s */}')
call tcomment#type#Define('typescriptreact_block', '{/* %s */}')
call tcomment#type#Define('typescriptreact_inline', '{/* %s */}')
