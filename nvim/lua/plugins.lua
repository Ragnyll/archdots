vim.cmd([[
call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf.vim'

Plug 'ukyouz/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'kevinhwang91/rnvimr', { 'branch': 'main' }
Plug 'airblade/vim-gitgutter'
Plug 'kovetskiy/sxhkd-vim'
Plug 'pseewald/vim-anyfold'
Plug 'machakann/vim-highlightedyank'
Plug 'airblade/vim-rooter'
Plug 'RobertAudi/git-blame.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
Plug 'tmux-plugins/vim-tmux'
Plug 'simrat39/rust-tools.nvim'
Plug 'saecki/crates.nvim', { 'tag': 'v0.1.0' }
call plug#end()
]])


require('crates').setup()
