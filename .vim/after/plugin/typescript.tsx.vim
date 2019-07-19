autocmd FileType typescript.tsx nnoremap <buffer><C-_><C-_> :TCommentAs <C-R>=&ft<CR><CR>
autocmd FileType typescript.tsx inoremap <buffer><C-_><C-_> <C-O>:TCommentAs <C-R>=&ft<CR><CR>
call tcomment#type#Define('typescript.tsx', '{/* %s */}')
call tcomment#type#Define('typescript.tsx_block', '{/* %s */}')
call tcomment#type#Define('typescript.tsx_inline', '{/* %s */}')

