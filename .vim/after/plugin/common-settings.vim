" コメントアウト行後の開業時にコメントアウトを入れない
au FileType * setlocal formatoptions-=ro
au FileType * set tw=0

" 特定のfiletypeではqだけで閉じるようにする
au FileType help nnoremap <buffer><silent>q :<C-U>q<CR>
au FileType fugitiveblame nmap <buffer><silent>q gq

function! IsRailsActive()
  return (exists("g:loaded_rails") && g:loaded_rails == 1)
endfunction

function! ExecCompiler(compiler_cmd, current_args, is_bang)
  exec 'setlocal makeprg='.fnameescape(a:compiler_cmd)
  exec (executable('Make') ? ':Make' : ':make').(a:is_bang ? '! ' :' ').a:current_args
endfunction

function! StartDockerCompose(container_name)
  echomsg 'docker-compose ps --filter name='.a:container_name.' -q'
  let result = system('docker-compose ps --filter name='.a:container_name.' -q')
  if (!exists(result))
    call system('docker-compose up -d '.a:container_name)
  endif
endfunction

function! BuildDockerCmd(container_name) abort
  let cmd = 'docker run --rm '
  if filereadable('docker-compose.yml')
    call StartDockerCompose(a:container_name)
    let cmd = 'docker-compose exec -T '
  endif
  return cmd.a:container_name.' '
endfunction

function! DockerCommand()
  let container_name = $APP_CONTAINER_NAME != '' ? $APP_CONTAINER_NAME : 'app'
  if executable('docker')
    let docker_cmd = BuildDockerCmd(container_name)
  else
    let docker_cmd = ''
  endif
  return docker_cmd
endfunction

if !has("nvim")
  let g:default_home_dir = '~/.vim'
else
  let g:default_home_dir = '~/.config/nvim'
endif
