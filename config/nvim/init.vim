call plug#begin('~/.vim/plugged')

" language support
" supports rust coc-pyright
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'cespare/vim-toml'
" Lua
Plug 'wsdjeg/vim-lua'
" python
Plug 'tell-k/vim-autopep8'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
" c++
Plug 'rhysd/vim-clang-format'
" tmux
Plug 'tmux-plugins/vim-tmux'
" markdown
Plug 'gabrielelana/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
" make it pretty
" Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'dylanaraps/wal.vim'
Plug 'airblade/vim-gitgutter'
Plug 'kovetskiy/sxhkd-vim'
Plug 'pseewald/vim-anyfold'
" file searching / exploring
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'kevinhwang91/rnvimr'
Plug 'RobertAudi/git-blame.vim'
Plug 'APZelos/blamer.nvim'
" konvenient keybinds
Plug 'scrooloose/nerdcommenter'

call plug#end()
set clipboard=unnamed

" Standard remaps
let mapleader=','
let maplocalleader='//'
nnoremap <leader>ev :tabedit ~/.config/nvim/init.vim <cr>

" FZF
nnoremap <leader>o :FZF<cr>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Ack
nnoremap <leader>f :Ag<cr>

" Supertab
let g:SupertabDefaultCompletionType='<c-n>'

" Nerdcommenter
" Add spaces after comment delimeters by default
let g:NERDSpaceDelims = 1
" Enable trimming of whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Python Specific
autocmd FileType python let b:coc_root_patterns = ['.git', '.env']
let g:autopep8_disable_show_diff=1
let g:pydocstring_doq_path = '~/.local/bin/doq'
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" ranger (rnvimr)
let g:rnvimr_enable_ex = 1
let g:rnvimr_hide_gitignore = 1
nnoremap <leader>r :RnvimrToggle<cr>
let g:rnvimr_action = {
    \ '<A-t>': 'NvimEdit tabedit',
    \ '<A-x>': 'NvimEdit split',
    \ '<A-v>': 'NvimEdit vsplit',
    \ 'gw': 'JumpNvimCwd',
    \ 'yw': 'EmitRangerCwd'
    \ }

" Rust racer
set hidden
let g:racer_cmd = "/home/ragnyll/.cargo/bin/racer"
let g:racer_experimental_completer = 1
augroup Racer
    autocmd!
    autocmd FileType rust nmap <buffer> gd         <Plug>(rust-def-tab)
    autocmd FileType rust nmap <buffer> <leader>gd <Plug>(rust-doc)
augroup END

" rust-gdb
packadd termdebug
autocmd FileType rust let termdebugger="rust-gdb"

" ctags
" basic commands
" ctrl + ] go to def
" ctrl + T go back
" ctrl + W ctrl + ] open in horizantal split
" leader + ] to open def in new tag
" leader + \ to open def in new vertial split
map <leader>] :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <leader>\ :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" rusty-ctags
" to tag everything up for the first time call `rusty-tags vi` in a project root dir
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

syntax on
set background=dark
colorscheme wal
hi Normal ctermbg=none
filetype plugin indent on
set autoindent
set complete-=i
set backspace=indent,eol,start
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set encoding=utf-8
set relativenumber
set number

" searching
set incsearch
set hlsearch
set ignorecase
set smartcase

" formatting
" <F1> is annoying so make it useful
autocmd FileType rust nnoremap <F1> :RustFmt<cr>
autocmd FileType python nnoremap <buffer> <F1> :Autopep8<CR>

" Normal Mode remaps
nnoremap <space> viw
nnoremap <leader><space> viW
nnoremap U <c-R>
nnoremap H ^
nnoremap L $

" Visual Mode remaps
vnoremap H ^
vnoremap L $

" Operator remaps
onoremap p i(

" markdown utility
let g:mkdp_auto_close = 0
autocmd FileType markdown nnoremap <leader>p :MarkdownPreviewToggle<cr>
autocmd FileType markdown nnoremap Q gqq
autocmd FileType markdown iabbrev NBSP &nbsp;&nbsp;&nbsp;
" preview markdown in surf (cuz its sexy without tabs)
let g:mkdp_browser = 'surf'

" remove all trailing whitespace on file on :w
autocmd BufWritePre * %s/\s\+$//e

" Enable fzf keybindings in vim
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Enable persistent undo
set undofile
set undodir=~/.vim/undo

" Enable mouse mode
set mouse=a

" quickly turn off numbers
nnoremap <F2> :set number! norelativenumber!<cr>
" function Permalink()
    " let s:curline = getline('.')
    " exec "!git-permalink ~/dev/rust-todo/src/cli/cli_parser.rs 80-90"
" endfunction
