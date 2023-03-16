vim.cmd([[
nnoremap <silent><Leader><S-n><S-n> :NvimTreeToggle<CR>
nnoremap <silent><Leader><S-n>f :NvimTreeFindFile<CR>
" ---------------tcomment_vim setting -----------"
" disable default mappings
let g:tcomment_maps = 0
noremap <C-_><C-_> :TComment<CR>
inoremap <C-_><C-_> <C-O>:TComment<CR>
noremap <C-_>b :TCommentBlock<CR>
inoremap <C-_>b <C-\><C-O>:TCommentBlock mode=#<CR>
noremap <C-_>i v:TCommentInline mode=I#<cr>
inoremap <C-_>i <C-\><C-O>:TCommentInline mode=I#<cr>
nmap <C-_>u <Plug>(TComment_Uncommentc)
vmap <C-_>u <Plug>(TComment_Uncommentc)

command! Pbcopy :let @*=@"  "最後にyank or 削除した内容をクリップボードに入れる
command! Pbcopy0 :let @*=@0 "最後にyankした内容をクリップボードに入れる

" disable F1 for help
nmap <F1> <nop>
imap <F1> <nop>

" ESC to Normal mode in terminal
autocmd TermOpen * tnoremap <Esc> <C-\><C-N>

"ctrl-j to ESC
imap <C-J> <ESC>

" Use <C-Space>. 使うときは<C-@>にマッピングする
map <C-Space>  <C-@>
cmap <C-Space>  <C-@>

" ---- Yank and send to clipbord --------
nnoremap YY yy:<C-U>Pbcopy0<CR>:echomsg "Copy to Clipbord!"<CR>
vnoremap YY y:<C-U>Pbcopy0<CR>:echomsg "Copy to Clipbord!"<CR>

" these Ctrl mappings work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" ---- Press space twice to save --------
noremap <space><space> :<C-U>w<CR>

" ----- Tabs ----
nnoremap ]t :tabn<CR>
nnoremap [t :tabp<CR>

" ----- Buffers ----
nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>

nnoremap ]q :cnext<CR>zz
nnoremap [q :cprev<CR>zz
nnoremap ]l :lnext<CR>zz
nnoremap [l :lprev<CR>zz

function! Strip(input_string)
  return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

" Zoom
function! s:zoom()
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
        \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction
nnoremap <silent> <leader>z :call <sid>zoom()<CR>

" ----------------------------------------------------------------------------
" <Leader>?/! | Google it / Feeling lucky
" ----------------------------------------------------------------------------
function! s:goog(pat, lucky)
  let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
  let q = substitute(q, '[[:punct:] ]',
        \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
  call system(printf('open "https://www.google.com/search?%sq=%s"',
        \ a:lucky ? 'btnI&' : '', q))
endfunction

nnoremap <leader>? :call <SID>goog(expand("<cword>"), 0)<cr>
nnoremap <leader>! :call <SID>goog(expand("<cWord>"), 1)<cr>
vnoremap <leader>? y:<C-U>Pbcopy0<CR> \| :call <SID>goog(expand(@"), 0)<cr>
vnoremap <leader>! y:<C-U>Pbcopy0<CR> \| :call <SID>goog(expand(@"), 1)<cr>

" ------------ vim-easyclip ------------
imap <c-v> <plug>EasyClipInsertModePaste
cmap <c-v> <plug>EasyClipCommandModePaste
let g:EasyClipShareYanks = 1
let g:EasyClipAutoFormat = 1
let g:EasyClipUsePasteDefaults = 1
let g:EasyClipYankHistorySize = 200

let g:indentLine_faster = 1
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*', 'git*']

" ------------ ctag setting ------------
" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]>
nnoremap <C-W><C-]> <C-W>g<C-]>

" Switching windows
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h
noremap <silent><C-w>s :<C-u>split<CR>
noremap <silent><C-w>v :<C-u>vsplit<CR>

" ----------- winresizer setting -------------
let g:winresizer_start_key = '<C-w>e'
let g:winresizer_vert_resize = 3
let g:winresizer_horiz_resize = 2

" Move visual block (eclipseみたいなアレ)
vnoremap <silent>J :m'>+1<CR>gv=gv
vnoremap <silent>K :m-2<CR>gv=gv
nnoremap <silent>J :m+<CR>==
nnoremap <silent>K :m-2<CR>==

" command line mode moving
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>

cnoremap <C-x> <C-f>

" insert mode moving
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Open current line on GitHub
nnoremap <Leader>go :GBrowse<CR>
vnoremap <Leader>go :GBrowse<CR>
nnoremap <Leader>gv :GV!<CR>
autocmd VimEnter * nnoremap <silent><expr><Leader>ga ':DiffviewFileHistory '. expand("%")<CR>

" git add current file
noremap <Leader>gs :Git<CR>
noremap <Leader>gF :GFiles?<CR>
noremap <Leader>gb :Git blame<CR>
noremap <Leader>gd :Gvdiff<CR>
nmap ]g <Plug>(GitGutterNextHunk)
nmap [g <Plug>(GitGutterPrevHunk)

" =============== vim-visual-multi ============
let g:VM_manual_infoline = 0
let g:VM_leader=','
let g:VM_maps = {}
" let g:VM_maps["Add Cursor At Word"] = 'g<cr>'
let g:VM_maps["Add Cursor Up"]   = '<M-k>'
let g:VM_maps["Add Cursor Down"] = '<M-j>'
"
function! VM_Start()
  HighlightedyankOff
endfunction
fun! VM_Exit()
  HighlightedyankOn
endfun

"=============vim-easy-align setting============
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
nmap <C-w>m <Plug>(git-messenger)
let g:git_messenger_include_diff = 'current'
let g:git_messenger_always_into_popup = v:true
let g:git_messenger_max_popup_height = 100
function! s:setup_git_messenger_popup() abort
  " Your favorite configuration here
  " For example, set go back/forward history to <C-o>/<C-i>
  nmap <buffer><ESC> q
  nmap <buffer><C-o> o
  nmap <buffer><C-i> O
endfunction
autocmd FileType gitmessengerpopup call <SID>setup_git_messenger_popup()

" ------------- scratch.vim ----------------
let g:scratch_autohide = 0
let g:scratch_insert_autohide = 0
let g:scratch_no_mappings = 0
nmap gs :<C-U>Scratch<CR>
xmap gs <plug>(scratch-selection-reuse)

" -------- switch.vim --------
let g:switch_mapping = ''
function! s:Switching(reverse)
  let opt = a:reverse ? [{'reverse': 1}, "\<C-X>"] : [{}, "\<C-A>"]
  let char = matchstr(getline('.'), '\%' . col('.') . 'c.')

  if char =~# '^\d\+$'
    execute "normal! ".opt[1]
    return
  endif

  if !switch#Switch(opt[0])
    execute "normal! ".opt[1]
    end
  endfunction
  nnoremap <silent><C-A> :call <SID>Switching(v:false)<CR>
  nnoremap <silent><C-X> :call <SID>Switching(v:true)<CR>

  " 他の.vimrcの読み込み
  let s:vim_dotfiles = split(globpath('~/dotfiles/include_vimrc', '*'),'\n')
  for filename in s:vim_dotfiles
    if filereadable(expand(filename))
      execute 'source' filename
    endif
  endfor

  " https://github.com/wellle/targets.vim/issues/257
  let g:targets_nl = ['n', 'N']

  function! s:toggle_conceal(arg, is_bang)
    let level = &conceallevel
    let toggle = level != 0 ? 0 : 2
    let &conceallevel=toggle
  endfunction
  command! -bang -nargs=* ToggleConceal call s:toggle_conceal(<q-args>, <bang>0)

  " ランタイムを読み込む
  set rtp+=/usr/local/opt/fzf

  " This is the default extra key bindings
  " fzf中に実行できるコマンド
  let g:fzf_action = {
        \ 'ctrl-s': 'split',
        \ 'ctrl-v': 'vsplit',
        \ 'ctrl-g': 'tabnew'
        \ }

  " Default fzf layout
  " - down / up / left / right
  if exists('$TMUX')
    let g:fzf_layout = { 'tmux': $FZF_TMUX_OPTS }
  else
    " let g:fzf_layout = { 'down': '~40%' }
    let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.5 } }
  endif

  " Mapping selecting mappings
  nmap <leader><tab> <plug>(fzf-maps-n)
  xmap <leader><tab> <plug>(fzf-maps-x)
  omap <leader><tab> <plug>(fzf-maps-o)
  " Insert mode completion
  imap <C-x><C-w> <plug>(fzf-complete-word)
  " Fileパスをfileコマンドでcomp
  " imap <C-x><C-p> <plug>(fzf-complete-path)
  " Fileパスをagコマンドでcomp
  imap <C-x><C-p> <plug>(fzf-complete-file-ag)
  imap <C-x><C-l> <plug>(fzf-complete-line)

  " Agコマンドで検索する
  nnoremap <silent> <leader>ag  :Ag <C-R><C-W><CR>
  nnoremap <silent> <leader>AG  :Ag <C-R><C-A><CR>
  xnoremap <silent> <leader>ag  y:Ag <C-R>"<CR>

  " Rgコマンドで検索する
  nnoremap <silent> <leader>rg  :Rg <C-R><C-W><CR>
  nnoremap <silent> <leader>RG  :Rg <C-R><C-A><CR>
  xnoremap <silent> <leader>rg  y:Rg <C-R>"<CR>

  " :Filesによる表示の変更
  let g:fzf_files_options = '-i --tiebreak=end,index ' .$FZF_PREVIEW_OPTS
  let g:fzf_buffers_jump = 1

  autocmd VimEnter * nnoremap <silent><expr><leader>F (expand('%') =~ 'NERD_tree' ? "\<C-W>\<C-W>" : '').':FilesMru'.(!empty(expand('<cword>')) ? '--query='.expand('<cword>') : '').'<CR>'
  autocmd VimEnter * nnoremap <silent><expr><C-P> (coc#pum#visible() ? "\<C-P>" : expand('%') =~ 'NERD_tree' ? "\<C-W>\<C-W>" : '').":FilesMru<CR>"
  autocmd VimEnter * nnoremap <leader>b :<C-U>Buffers<CR>
  if(has('nvim'))
    autocmd FileType fzf tunmap <ESC>
  endif

  ":Colorsによる表示の変更
  autocmd VimEnter * command! -bang Colors
        \ call fzf#vim#colors({'left': '~15%', 'options': '--reverse --margin 20%,0'}, <bang>0)

  " Augmenting Ag command using fzf#vim#with_preview function
  " プロンプト表示を「コマンド名（検索文字列）> 」みたいにする
  function! s:exec_grep_command(arg, is_bang, command_name)
    let tokens = split(a:arg)
    let opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
    let query = join(filter(copy(tokens), 'v:val !~ "^-"'))

    let fzf_options = {'options': ''}
    let cul_dir = ' (' . getcwd() . ') '

    let display_search_str = '> "'
    if !empty(query)
      let display_search_str = '['.query.']> "'
    endif

    let fzf_options.options .= ' --prompt="'.a:command_name. cul_dir. display_search_str

    if a:is_bang
      let fzf_options = fzf#vim#with_preview(fzf_options, 'up:60%')
    else
      let fzf_options = fzf#vim#with_preview(fzf_options, 'right:50%:hidden', '?')
      end

      if a:command_name == 'Ag'
        call fzf#vim#ag(query, opts. ' --hidden --skip-vcs-ignores --path-to-ignore ~/.ignore', fzf_options, a:is_bang)
      else
        call fzf#vim#grep(
              \  'rg --column --line-number --hidden --no-heading --color always --no-ignore --ignore-file ~/.ignore '.shellescape(query),
              \  1,
              \  fzf_options,
              \  a:is_bang)
      endif
    endfunction

    autocmd VimEnter * command! -bang -nargs=* Ag call s:exec_grep_command(<q-args>, <bang>0, 'Ag')
    autocmd VimEnter * command! -bang -nargs=* Rg call s:exec_grep_command(<q-args>, <bang>0, 'Rg')

    " command for git grep
    " fzf#vim#grep(command, with_column, [options], [fullscreen])
    command! -bang -nargs=* GGrep
          \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

    function! s:tags_sink(line)
      let parts = split(a:line, '\t\zs')
      let excmd = matchstr(parts[2:], '^.*\ze;"\t')
      execute 'silent e' parts[1][:-2]
      let [magic, &magic] = [&magic, 0]
      execute excmd
      let &magic = magic
    endfunction

    function! s:tags(query)
      if empty(tagfiles())
        echohl WarningMsg
        echom 'Preparing tags'
        echohl None
      endif
      " 優先度の高いtagfileだけ使う
      let tagfile = tagfiles()[0]
      " let proc = 'perl -ne ''unless (/^\!/) { s/^(.*?)\t(.*?)\t/'.s:yellow('\1', 'Function').'\t'.s:blue('\2', 'String').'\t/; print }'' '
      let copt = '--ansi '

      if !empty(a:query)
        let query_option = ' --query='.shellescape(a:query)
      else
        let query_option = ''
      endif

      call fzf#run({
            \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
            \            '| grep -v -a ^!',
            \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index '.
            \            '--prompt="TTags> "'.query_option,
            \ 'down':    '40%',
            \ 'sink':    function('s:tags_sink')})
    endfunction
    command! -nargs=* TTags call s:tags(<q-args>)

    " ------------- 引数の内容を無名レジスタにコピー---------"
    function! s:add_latest_register(line)
      let @" = a:line
      echomsg "Add Register!!"
    endfunction

    command! -nargs=* BacklogIssues call fzf#run({
          \ 'source': 'ruby -S backlog_access.rb myissue',
          \ 'options': '--ansi ',
          \ 'down':    '40%',
          \ 'sink': function('s:add_latest_register')
          \ })

    function! s:yank_list()
      redir => ys
      " silent :Yanks
      " redir END
      silent call s:all_yanks()
      redir END
      return split(substitute(ys, '\^M', '\\\\\\n', 'g'), '\n')[1:]
    endfunction

    function! s:yank_handler(reg)
      if empty(a:reg)
        echo "aborted register paste"
      else
        let token = split(a:reg, ' ')
        execute 'Paste' . token[0]
      endif
    endfunction

    command! FZFYank call fzf#run({
          \ 'source': <sid>yank_list(),
          \ 'sink': function('<sid>yank_handler'),
          \ 'options': '-m --prompt="FZFYank> " --preview="echo -e {2..}"',
          \ 'down':    '40%'
          \ })

    nnoremap <C-Y><C-Y> :<C-U>FZFYank<CR>
    inoremap <C-Y><C-Y> <C-O>:<C-U>FZFYank<CR>

    function! s:all_yanks()
      let i = 0
      for msg in EasyClip#Yank#EasyClipGetAllYanks()
        let index = printf("%-4d", i)
        let line = substitute(msg.text, '\V\n', '^M', 'g')
        echohl Directory | echo  index
        echohl None      | echon line
        echohl None
        let i += 1
      endfor
    endfunction


" Better display for messages
" set cmdheight=2

let g:coc_config_home = $HOME.'/.config/nvim'

let g:coc_global_extensions = [
\  'coc-lists'
\, 'coc-json'
\, 'coc-marketplace'
\, 'coc-html'
\, 'coc-css'
\, 'coc-tsserver'
\, 'coc-solargraph'
\, 'coc-pyright'
\, 'coc-snippets'
\, 'coc-rust-analyzer'
\, 'coc-import-cost'
\, 'coc-go'
\ ]
" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" change custom highlight
hi link CocMenuSel PmenuSel
hi CocHintSign ctermfg=12 guifg=#15aabf

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" for https://github.com/neoclide/coc.nvim/pull/3862
inoremap <silent><expr> <TAB>
\ coc#pum#visible() ? coc#pum#next(1) :
\ <SID>check_back_space() ? "\<Tab>" :
\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
inoremap <silent><expr> <c-space> coc#refresh()
else
inoremap <silent><expr> <c-@> coc#refresh()
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
endif

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
let g:VM_maps["I Return"] = coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <C-w><C-d> :call CocActionAsync('jumpDefinition', 'CocSplitIfNotOpen')<CR>
nmap <silent> <C-w>d :call CocActionAsync('jumpDefinition', 'CocSplitIfNotOpen')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! SplitIfNotOpen(...)
let fname = a:1
let call = ''
if a:0 == 2
let fname = a:2
let call = a:1
endif
let bufnum=bufnr(expand(fname))
let winnum=bufwinnr(bufnum)
if winnum != -1
" Jump to existing split
exe winnum . "wincmd w"
else
" Make new split as usual
exe call. " " . fname
endif
endfunction

command! -nargs=+ CocSplitIfNotOpen :call SplitIfNotOpen('split', <f-args>)
command! -nargs=+ CocVSplitIfNotOpen :call SplitIfNotOpen('split', <f-args>)

" Use D for show documentation in preview window
nnoremap <silent> D :call <SID>show_documentation()<CR>

function! s:show_documentation()
if (index(['vim','help'], &filetype) >= 0)
execute 'h '.expand('<cword>')
elseif (coc#rpc#ready())
call CocActionAsync('doHover')
else
execute '!' . &keywordprg . " " . expand('<cword>')
endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')
" hi CocHighlightText ctermbg=239 guibg=Gray30

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

augroup mygroup
autocmd!
" Setup formatexpr specified filetype(s).
autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
" Update signature help on jump placeholder.
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf <Plug>(coc-fix-current)

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<C-R>=coc#float#scroll(1)\<CR>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<C-R>=coc#float#scroll(0)\<CR>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OrgImport :call CocAction('runCommand', 'editor.action.organizeImport')

" Using CocFzfList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-U>CocFzfList diagnostics<CR>
" Manage extensions
nnoremap <silent> <space>e  :<C-U>CocFzfList extensions<CR>
" Show commands
nnoremap <silent> <space>c  :<C-U>CocFzfList commands<CR>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-U>CocFzfList outline<CR>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-U>CocFzfList -I symbols<CR>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-U>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-U>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-U>CocFzfListResume<CR>

"============= LightLine settings ==============
" vim-gitgutter
let g:gitgutter_sign_added = '✚'
let g:gitgutter_sign_modified = '➜'
let g:gitgutter_sign_removed = '✘'

let g:lightline = {
\ 'colorscheme': 'nightowl',
\ 'active': {
\   'left': [ [ 'mode', 'paste'],
\             [ 'cocstatus', 'sessionState', 'fugitive', 'gitgutter', 'filename' ] ],
\   'right': [ [ 'lineinfo' ],
\              [ 'percent' ],
\              [ 'fileformat', 'fileencoding', 'filetype' ] ]
\ },
\ 'component_function': {
\   'modified': 'MyModified',
\   'readonly': 'MyReadonly',
\   'fugitive': 'MyFugitive',
\   'filename': 'MyFilename',
\   'fileformat': 'MyFileformat',
\   'filetype': 'MyFiletype',
\   'fileencoding': 'MyFileEncoding',
\   'lineinfo': 'MyLineInfo',
\   'percent': 'MyPercent',
\   'gitgutter': 'MyGitGutter',
\   'sessionState': 'ObsessionStatus',
\   'mode': 'MyMode',
\ },
\ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
\ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
\ }

let g:lightline.mode_map = {
\ 'n' : 'N',
\ 'i' : 'I',
\ 'R' : 'R',
\ 'v' : 'V',
\ 'V' : 'V-L',
\ "\<C-v>": 'V-B',
\ 'c' : 'C',
\ 's' : 'S',
\ 'S' : 'S-L',
\ "\<C-s>": 'S-B',
\ 't': 'TERM',
\ }

let g:VM_theme = 'iceblue'

function! IsNotFiles()
return &ft =~? 'vimfiler\|gundo\|nerdtree\NvimTree\|fugitive.*'
endfunction
function! IsShowStatus(length)
return winwidth(0) > a:length && !IsNotFiles()
endfunction
function! MyModified()
return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! MyReadonly()
return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction
function! GetFilename()
let filename = '[No Name]'
if('' != fnamemodify(expand('%'),':.'))
if(IsNotFiles())
let filename = &ft
else
let filename = fnamemodify(expand('%'),':.')
let r = split(filename,'/')
if (winwidth(0) <= 90 && len(r) > 3)
let short_name = r[:1]
call add(short_name, '...')
call add(short_name, r[-1])
let filename = join(short_name, '/')
endif
end
endif
return filename
endfunction
function! MyFilename()
return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
\ GetFilename() .
\ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
function! MyFugitive()
let branch = ''
if (winwidth(0) > 140)
try
if &ft !~? 'vimfiler\|gundo' && (exists('*fugitive#head') || exists('*FugitiveHead'))
let branch = fugitive#head()
let branch = branch == '' ? '' : ' '.branch
endif
catch
endtry
endif
return branch
endfunction

function! MyFileformat()
return IsShowStatus(70) ? &fileformat : ''
endfunction
function! MyFiletype()
return IsShowStatus(70) ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction
function! MyFileEncoding()
return IsShowStatus(70) ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction
function! MyLineInfo()
return IsShowStatus(70) ? printf("%3d:%-2d", line('.'), col('.')) : ''
endfunction
function! MyPercent()
return IsShowStatus(70) ? (100 * line('.') / line('$')) . '%' : ''
endfunction
function! MyMode()
return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
function! MyGitGutter()
if ! exists('*GitGutterGetHunkSummary')
\ || ! get(g:, 'gitgutter_enabled', 0)
\ || winwidth('.') <= 90
return ''
endif
let symbols = [
\ g:gitgutter_sign_added . ' ',
\ g:gitgutter_sign_modified . ' ',
\ g:gitgutter_sign_removed . ' '
\ ]
let hunks = GitGutterGetHunkSummary()
let ret = []
for i in [0, 1, 2]
if hunks[i] > 0
call add(ret, symbols[i] . hunks[i])
endif
endfor
return join(ret, ' ')
endfunction

" カーソルの位置を復元する
if has("autocmd")
augroup redhat
" In text files, always limit the width of text to 78 characters
autocmd BufRead *.txt set tw=78
" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\   exe "normal! g'\"" |
\ endif
autocmd FileType pullrequest normal! gg0
autocmd FileType gitcommit normal! gg0
autocmd VimEnter COMMIT_EDITMSG  normal! gg0
augroup END
endif

" ==============terminal setting==========
if has("nvim")
let g:terminal_color_0  = "#1b2b34" "black
let g:terminal_color_1  = "#ed5f67" "red
let g:terminal_color_2  = "#9ac895" "green
let g:terminal_color_3  = "#fbc963" "yellow
let g:terminal_color_4  = "#669acd" "blue
let g:terminal_color_5  = "#c695c6" "magenta
let g:terminal_color_6  = "#5fb4b4" "cyan
let g:terminal_color_7  = "#c1c6cf" "white
" let g:terminal_color_8  = "#65737e" "bright black
" let g:terminal_color_9  = "#fa9257" "bright red
" let g:terminal_color_10 = "#343d46" "bright green
" let g:terminal_color_11 = "#4f5b66" "bright yellow
" let g:terminal_color_12 = "#a8aebb" "bright blue
" let g:terminal_color_13 = "#ced4df" "bright magenta
" let g:terminal_color_14 = "#ac7967" "bright cyan
" let g:terminal_color_15 = "#d9dfea" "bright white
let g:terminal_color_background="#1b2b34" "background
let g:terminal_color_foreground="#c1c6cf" "foreground
endif

" ===============Goyo Settig===============
let g:goyo_width = '60%'
let g:goyo_height = '80%'
let g:goyo_linenr = 1

" Goyoに入ったときに実行する
function! s:goyo_enter()
silent !tmux set status off
silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
" Goyo 100%
set noshowmode
set noshowcmd
set relativenumber
let g:tmp_scrolloff = &scrolloff
set scrolloff=999
let term_name = has('termguicolors') ? 'guibg' : 'ctermbg'
exec 'hi Normal '.term_name.'='.g:default_bg
Limelight
endfunction
function! s:goyo_leave()
silent !tmux set status on
silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
set showcmd
set norelativenumber
exec 'set scrolloff='.g:tmp_scrolloff
hi Normal ctermbg=NONE guibg=NONE
Limelight!
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 255

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'black'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 0

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
" let g:limelight_bop = '^\s'
" let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

" indent setting
augroup fileTypeIndent
autocmd!
autocmd BufNewFile,BufRead *.jbuilder   set filetype=ruby
autocmd BufNewFile,BufRead Guardfile    set filetype=ruby
autocmd BufNewFile,BufRead Gemfile      set filetype=ruby
autocmd BufNewFile,BufRead Gemfile.lock set filetype=ruby
autocmd BufNewFile,BufRead .pryrc       set filetype=ruby
" ?つきメソッド、@@インスタンスを単語とみなす
autocmd FileType eruby  setlocal isk+=@-@,?,!
autocmd FileType slim   setlocal isk+=@-@,?,!
autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType blade  setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType php    setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType java   setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType groovy setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType go     setlocal tabstop=4 softtabstop=4 noexpandtab   shiftwidth=4
augroup END

augroup flowLevelSetting
autocmd!
autocmd FileType git* setlocal foldlevel=99
autocmd BufNewFile,BufRead,BufEnter *Agit* if !empty(matchstr(expand('%:t'), "Agit")) | setlocal foldlevel=99 | endif
augroup END

" Automatic rename of tmux window
if exists('$TMUX') && !exists('$NORENAME')
au BufEnter * if empty(&buftype) | call system('tmux rename-window "[vim]"'.expand('%:t:S')) | endif
au VimLeave * call system('tmux set-window automatic-rename on')
endif

" ----------- matchup plugin setting ---------------
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_offscreen = {'method': 'popup'}
hi MatchParen ctermfg=166 guifg=darkorange2 cterm=italic gui=italic
hi MatchParenCur cterm=NONE gui=NONE
hi MatchWord ctermfg=166 guifg=darkorange2 cterm=NONE gui=NONE
hi MatchWordCur cterm=underline gui=underline

" ----------- highlightedyank setting ----------------
let g:highlightedyank_highlight_duration = 500
hi HighlightedyankRegion ctermbg=22 guibg=#005f00

" ------------vim-illuminate setting-----------------
hi illuminatedWord ctermbg=239 guibg=Gray30
hi IlluminatedWordText ctermbg=239 guibg=Gray30
hi IlluminatedWordRead ctermbg=239 guibg=Gray30
hi IlluminatedWordWrite ctermbg=239 guibg=Gray30
let g:Illuminate_highlightUnderCursor = 0
let g:Illuminate_delay = 800

" ----- indent blankline -------
" let g:indent_blankline_colorful = 1
let g:indent_blankline_show_current_context = v:true
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_viewport_buffer = 10
" let g:indent_blankline_vscode_rainbow_mode = 0
]])
