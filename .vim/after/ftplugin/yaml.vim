" set filetype by filename
autocmd BufNewFile,BufRead */config/*.yml{,.example,.sample},*/{test,spec}/fixtures/*.yml,database.yml
      \ if &filetype !=# 'yaml.eruby' |
      \   set filetype=yaml.eruby |
      \ endif
