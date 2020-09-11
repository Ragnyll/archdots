call plug#begin('~/.vim/plugged')

" language support
" Plug 'davidhalter/jedi-vim' im seeing how deoplete compares
Plug 'Shougo/deoplete.nvim'
Plug 'heavenshell/vim-pydocstring'
Plug 'wsdjeg/vim-lua'
Plug 'tmux-plugins/vim-tmux'
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
" markdown
Plug 'gabrielelana/vim-markdown'
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
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim' " bclose is a dependency of ranger.vim
" konvenient keybinds
Plug 'scrooloose/nerdcommenter'

call plug#end()

" Startup commands
let g:deoplete#enable_at_startup = 1

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

" ranger
let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1

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
nnoremap <leader>r :Ranger<cr>
nnoremap <leader>R :vsplit <bar> :Ranger<cr>
nnoremap <leader>t :RangerNewTab<cr>

" Visual Mode remaps
vnoremap H ^
vnoremap L $

" Operator remaps
onoremap p i(

" markdown utility
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
