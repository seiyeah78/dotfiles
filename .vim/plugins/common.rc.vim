" -----------------------------------------------
" Utility
" -----------------------------------------------
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim' | Plug 'tweekmonster/fzf-filemru'
Plug 'neoclide/coc.nvim', { 'branch': 'release' } | Plug 'antoinemadec/coc-fzf'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'tpope/vim-surround'
Plug 'simeji/winresizer'
Plug 'mg979/vim-visual-multi'
Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb' | Plug 'junegunn/gv.vim'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-endwise'
Plug 'elzr/vim-json'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'honza/vim-snippets'
Plug 'thinca/vim-qfreplace'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat' | Plug 'svermeulen/vim-easyclip'
Plug 'junegunn/goyo.vim', { 'on': ['Goyo'] } | Plug 'amix/vim-zenroom2', { 'on': ['Goyo'] }
Plug 'majutsushi/tagbar', { 'on': ['TagbarToggle'] }
Plug 'ntpeters/vim-better-whitespace'
Plug 'tomtom/tcomment_vim'
Plug 'kana/vim-textobj-user' | Plug 'terryma/vim-expand-region' | Plug 'kana/vim-textobj-line' | Plug 'kana/vim-textobj-entire'
Plug 'wellle/targets.vim'
Plug 'haya14busa/is.vim' | Plug 'haya14busa/vim-asterisk'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'andymass/vim-matchup'
Plug 'tyru/open-browser.vim'
Plug 'mattn/emmet-vim', { 'for': ['html','javascript','typescript','jsx','tsx','typescript.tsx'] }
Plug 'machakann/vim-highlightedyank'
Plug 'RRethy/vim-illuminate'
Plug 'rhysd/git-messenger.vim'
Plug 'janko/vim-test' | Plug 'tpope/vim-dispatch'
Plug 'mtth/scratch.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'metakirby5/codi.vim'
Plug 'tpope/vim-projectionist'
Plug 'pechorin/any-jump.vim'
Plug 'segeljakt/vim-silicon', { 'do': 'curl https://sh.rustup.rs -sySf \| sh; cargo install silicon' }
Plug 'towolf/vim-helm'
" if exists('$TMUX')
"   Plug 'wellle/tmux-complete.vim'
" end

" -----------------------------------------------
" Language,Framework
" -----------------------------------------------

" Ruby
Plug 'tpope/vim-rails', { 'for': ['ruby', 'eruby', 'slim'] }
Plug 'tpope/vim-rbenv', { 'for': ['ruby', 'eruby', 'slim'] }
Plug 'slim-template/vim-slim', { 'for': ['ruby', 'eruby', 'slim'] }
Plug 'tpope/vim-bundler', { 'for': 'ruby' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

" PHP
" Plug 'vim-scripts/tagbar-phpctags', { 'for': 'php' }
" Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
" Plug 'phpactor/phpactor', { 'for': 'php', 'branch': 'master', 'do': 'composer install --no-dev -o' }
" Plug 'noahfrederick/vim-laravel', { 'for': 'php', 'do': 'composer install' }

" Typescript
" Plug 'posva/vim-vue', { 'for': 'vue', 'do': 'npm i -g eslint eslint-plugin-vue' }
" Plug 'herringtonDarkholme/yats.vim', { 'for': ['html', 'javascript', 'typescript', 'jsx', 'tsx', 'typescript.tsx', 'typescriptreact'] }
" Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'typescript.tsx', 'typescriptreact', 'tsx'] }
" Plug 'MaxMEllon/vim-jsx-pretty', { 'for': ['typescript', 'typescript.tsx', 'typescriptreact', 'tsx'] }

" Python
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
Plug 'vim-python/python-syntax', { 'for': 'python' }
Plug 'raimon49/requirements.txt.vim', { 'for': 'requirements' }
" Plug 'relastle/vim-nayvy'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }
Plug 'godlygeek/tabular', { 'for': ['markdown'] }
Plug 'dhruvasagar/vim-table-mode', { 'for': ['markdown'] }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['markdown'] }
Plug 'rhysd/vim-gfm-syntax', { 'for': ['markdown'] }

" Go
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
" _enable変数はvimrcじゃないと効果なし
let g:go_doc_keywordprg_enabled = 0

" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust', 'do': 'rustup component add rls rust-analysis rust-src rustfmt' }
let g:rust_clip_command = 'pbcopy'

" Terraform
Plug 'hashivim/vim-terraform', { 'for': 'terraform' }

" colorschemes plugins
Plug 'gkeep/iceberg-dark'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/seoul256.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'joshdick/onedark.vim'
Plug 'rhysd/vim-color-spring-night'
Plug 'morhetz/gruvbox'
Plug 'cocopon/iceberg.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'romainl/Apprentice'
Plug 'mhartington/oceanic-next'
Plug 'chriskempson/base16-vim'
Plug 'haishanh/night-owl.vim'
Plug 'sainnhe/sonokai'

" lint engine
" Plug 'w0rp/ale'
