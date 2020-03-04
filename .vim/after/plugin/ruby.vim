" ft-ruby-syntax
" see: http://vim-jp.org/vimdoc-ja/syntax.html
let ruby_operators = 1
let ruby_space_errors = 1
" let ruby_no_expensive = 1
" let ruby_spellcheck_strings = 1
let ruby_line_continuation_error = 1
let ruby_global_variable_error   = 1

setlocal isk+=@-@,?,!
autocmd BufNewFile,BufRead *spec.rb if exists("g:loaded_rails") && g:loaded_rails == 1 | set syntax=ruby | endif

" -------------- vim-rails -------------
let g:rails_projections = {
      \  "app/controllers/*_controller.rb": {
      \      "test": [
      \        "spec/requests/{}_spec.rb",
      \        "spec/features/{}_spec.rb",
      \        "spec/system/{}_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \      "alternate": [
      \        "spec/requests/{}_spec.rb",
      \        "spec/features/{}_spec.rb",
      \        "spec/system/{}_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \   },
      \   "spec/requests/*_spec.rb": {
      \      "command": "request",
      \      "alternate": "app/controllers/{}_controller.rb",
      \      "template": "require 'rails_helper'\n\n" .
      \        "RSpec.describe '{}' do\nend",
      \   },
      \   "spec/features/*_spec.rb": {
      \      "command": "feature",
      \      "alternate": "app/controllers/{}_controller.rb",
      \      "template": "require 'rails_helper'\n\n" .
      \        "RSpec.feature '{}' do\nend",
      \   },
      \   "spec/system/*_spec.rb": {
      \      "command": "system",
      \      "alternate": "app/controllers/{}_controller.rb",
      \      "template": "require 'rails_helper'\n\n" .
      \        "RSpec.describe '{}' do\nend",
      \   },
      \ }

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
