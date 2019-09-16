"コメントアウト行後の開業時にコメントアウトを入れない
au FileType * setlocal formatoptions-=ro

function DockerCommand()
  let container_name = $APP_CONTAINER_NAME != '' ? $APP_CONTAINER_NAME : 'app'
  if executable('docker')
    if filereadable('docker-compose.yml')
      let docker_cmd = 'docker-compose exec '
    else
      let container_name = system('docker ps --filter name=$APP_CONTAINER_NAME  -q')
      let docker_cmd = container_name != '' ? 'docker run --rm ' : ''
    endif
    let docker_cmd = docker_cmd.container_name.' '
  else
    let docker_cmd = ''
  endif
  return docker_cmd
endfunction

function ExecCompiler(compiler_cmd, is_bang)
  exec 'setlocal makeprg='.fnameescape(a:compiler_cmd)
  exec (executable('Make') ? ':Make ' : ':make ').(a:is_bang ? '' : @%)
endfunction

if !has("nvim")
  let g:default_home_dir = '~/.vim'
else
  let g:default_home_dir = '~/.config/nvim'
endif
