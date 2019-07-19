" ft-ruby-syntax
" see: http://vim-jp.org/vimdoc-ja/syntax.html
let ruby_operators = 1
let ruby_space_errors = 1
" let ruby_no_expensive = 1
" let ruby_spellcheck_strings = 1
let ruby_line_continuation_error = 1
let ruby_global_variable_error   = 1

" ============ tagbar setting =============
" see --list-kinds=Ruby
" let g:tagbar_type_ruby = {
"     \ 'kinds'      : ['m:modules',
"                     \ 'c:classes',
"                     \ 'C:constants',
"                     \ 'F:singleton methods',
"                     \ 'f:methods',
"                     \ 'a:aliases'],
"     \ 'kind2scope' : { 'c' : 'class',
"                      \ 'm' : 'class' },
"     \ 'scope2kind' : { 'class' : 'c' },
"     \ 'ctagsbin'   : 'ripper-tags',
"     \ 'ctagsargs'  : ['-f', '-']
"     \ }
let g:tagbar_type_ruby = {
      \ 'kinds' : [
      \ 'm:modules',
      \ 'c:classes',
      \ 'r:associations',
      \ 'C:constants',
      \ 'f:methods',
      \ 'S:singleton methods'
      \ ],
      \ 'kind2scope' : { 'c' : 'class',
      \ 'm' : 'module',
      \ },
      \ 'scope2kind' : { 'module' : 'm',
      \ 'class' : 'c'
      \ },
      \ }

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
