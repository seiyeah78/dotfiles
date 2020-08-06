" set filetype by filename
autocmd BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible

function! HasSpecificFile()
  return (match(fnamemodify(expand('%'),':.'), 'config/settings') != -1)
endfunction

autocmd BufRead,BufNewFile *.yml,*.yaml if IsRailsActive() || HasSpecificFile() | set filetype=yaml.eruby endif
