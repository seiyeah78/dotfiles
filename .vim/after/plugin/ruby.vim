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

function s:RuboCop(current_args, is_bang)
  compiler rubocop
  call ExecCompiler(GemCommand(), a:is_bang)
endfunction

function s:RSpec(current_args, is_bang)
  compiler rspec
  call ExecCompiler(GemCommand(), a:is_bang)
endfunction

function GemCommand()
  let l:cmd = &makeprg
  if filereadable('Gemfile')
    let l:cmd = 'bundle exec '.l:cmd
  endif
  return DockerCommand().l:cmd
endfunction

" let test#ruby#rspec#options = {
"       \ 'all': '--require '.g:default_home_dir.'/spec/support/formatters/vim_formatter.rb --format VimFormatter'
"       \}

command! -bang -nargs=* RuboCop :call <SID>RuboCop(<q-args>, <bang>0)
command! -bang -nargs=* RSpec :call <SID>RSpec(<q-args>, <bang>0)
