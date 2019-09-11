call plug#begin('~/.vim/plugged')

Plug '~/.fzf'
Plug 'Konfekt/FastFold'
Plug 'tmhedberg/SimpylFold'
Plug 'airblade/vim-gitgutter'
Plug 'craigemery/vim-autotag'
Plug 'ervandew/supertab'
Plug 'majutsushi/tagbar'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf.vim'
Plug 'Ragnyll/vim-colorschemes'
Plug 'vim-airline/vim-airline'

call plug#end()

" Standard remaps
let mapleader=','
let maplocalleader='//'
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim <cr>

" FZF
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
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

" tagbar
nnoremap <leader>t :TagbarToggle<CR>

syntax on
set background=dark
colorscheme monokai-phoenix
hi Normal ctermbg=none
filetype plugin indent on
set autoindent
set complete-=i
set backspace=indent,eol,start
set smarttab
set tabstop=4
set shiftwidth=4
set encoding=utf-8
set number
set clipboard=unnamed

" searching
set incsearch
set hlsearch
set ignorecase
set smartcase


" Normal Mode remaps
nnoremap <space> viw
nnoremap U <c-R>
nnoremap H ^
nnoremap L $
nnoremap <leader>1 :Vex<cr>
nnoremap <leader>r :reg<cr>

" Visual Mode remaps
vnoremap H ^
vnoremap L $

" Operator remaps
onoremap p i(

" Python (SimpylFold) folding
let g:SimpylFold_docstring_preview = 1
set nofoldenable

