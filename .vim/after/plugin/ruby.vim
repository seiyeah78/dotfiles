function s:DockerCommand()
  if executable('docker') && exists('$RUBOCOP_CONTAINER')
    if filereadable('docker-compose.yml')
      let docker_cmd = 'docker-compose\ exec\ '
    else
      let docker_cmd = 'docker run\ --rm\ '
    endif
    return docker_cmd.$RUBOCOP_CONTAINER.'\ '
  else
    return ''
  endif
endfunction

function s:RuboCop(current_args, is_bang)
  compiler rubocop
  exec 'setlocal makeprg='.s:RubocopCommand()
  exec (executable('Make') ? ':Make ' : ':make ').(a:is_bang ? '' : @%)
endfunction

function s:RubocopCommand()
  let l:cmd = &makeprg
  if filereadable('Gemfile')
    let l:cmd = 'bundle\ exec\ '.fnameescape(l:cmd)
  endif
  echo l:cmd
  return s:DockerCommand().l:cmd
endfunction

command! -bang -nargs=* RuboCop :call <SID>RuboCop(<q-args>, <bang>0)
