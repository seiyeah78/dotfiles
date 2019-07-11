if exists('g:polyglot_disabled') && index(g:polyglot_disabled, 'ruby') != -1
  finish
endif

if exists("current_compiler")
  finish
endif
let current_compiler = "rubocop"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=rubocop\ -f\ emacs
CompilerSet errorformat=%f:%l:%c:%m,%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8:
