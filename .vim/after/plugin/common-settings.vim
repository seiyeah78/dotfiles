"コメントアウト行後の開業時にコメントアウトを入れない
au FileType * setlocal formatoptions-=ro

function DockerCommand()
  if executable('docker') && exists("b:app_container")
    if filereadable('docker-compose.yml')
      let docker_cmd = 'docker-compose exec '
    else
      let docker_cmd = 'docker run --rm '
    endif
    let docker_cmd = docker_cmd.b:app_container.' '
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
