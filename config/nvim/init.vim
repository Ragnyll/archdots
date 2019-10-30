call plug#begin('~/.vim/plugged')

" make it pretty
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'Ragnyll/vim-colorschemes'
Plug 'airblade/vim-gitgutter'
Plug 'rust-lang/rust.vim'
Plug 'kovetskiy/sxhkd-vim'
" file searching / exploring
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'
" tags
Plug 'majutsushi/tagbar'
Plug 'craigemery/vim-autotag'
Plug 'ervandew/supertab'
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

" ranger
let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1

" tagbar
nnoremap <leader>t :TagbarToggle<cr>

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
nnoremap <leader>r :Ranger<cr>
nnoremap <leader>R :vsplit <bar> :Ranger<cr>
nnoremap <leader>t :RangerNewTab<cr>
nnoremap <leader>p :reg<cr>

" Visual Mode remaps
vnoremap H ^
vnoremap L $

" Operator remaps
onoremap p i(

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
