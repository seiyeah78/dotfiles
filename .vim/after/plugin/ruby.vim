let rubocop_cmd='rubocop\ -f\ emacs'
if filereadable('docker-compose.yml')
  let rubocop_cmd='docker-compose\ exec\ -T\ app\ bundle\ exec\ '.rubocop_cmd
endif
command! -complete=file -nargs=* RuboCop setlocal errorformat=%f:%l:%c:%m,%-G%.%# | exec 'setlocal makeprg='.rubocop_cmd | exec ':Make'
