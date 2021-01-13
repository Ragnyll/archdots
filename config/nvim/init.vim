call plug#begin('~/.vim/plugged')

" language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'heavenshell/vim-pydocstring'
Plug 'tell-k/vim-autopep8'
Plug 'wsdjeg/vim-lua'
Plug 'tmux-plugins/vim-tmux'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'rhysd/vim-clang-format'
" markdown
Plug 'gabrielelana/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
" make it pretty
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'Ragnyll/vim-colorschemes'
Plug 'dylanaraps/wal.vim'
Plug 'airblade/vim-gitgutter'
Plug 'kovetskiy/sxhkd-vim'
" file searching / exploring
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'kevinhwang91/rnvimr'
" konvenient keybinds
Plug 'scrooloose/nerdcommenter'

call plug#end()

" Standard remaps
let mapleader=','
let maplocalleader='//'
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim <cr>

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

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_python_flake8_args='--ignore=E501'

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
set clipboard=unnamed

" searching
set incsearch
set hlsearch
set ignorecase
set smartcase

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
nnoremap <leader>m :MarkdownPreview<cr>
autocmd FileType markdown nnoremap <leader><tab> i&nbsp;&nbsp;&nbsp;&nbsp;<Esc>

" remove all trailing whitespace on file on :w
autocmd BufWritePre * %s/\s\+$//e

" Python (SimpylFold) folding
let g:SimpylFold_docstring_preview = 1
set nofoldenable

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
