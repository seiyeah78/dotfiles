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
  " let s:vim_dotfiles = split(globpath('~/dotfiles/include_vimrc', '*'),'\n')
  " for filename in s:vim_dotfiles
  "   if filereadable(expand(filename))
  "     execute 'source' filename
  "   endif
  " endfor

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
  "   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
  "   * Preview script requires Ruby
  "   * Install Highlight or CodeRay to enable syntax highlighting
  "
  "   :Ag  - Start fzf with hidden preview window that can be enabled with "?"
  "   key
  "   :Ag! - Start fzf in fullscreen and display the preview window above

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
