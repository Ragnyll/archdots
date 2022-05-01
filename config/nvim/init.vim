call plug#begin('~/.vim/plugged')

" language support
" supports rust coc-pyright
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovim/nvim-lspconfig'
" Semantic language support
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer', {'branch': 'main'}
Plug 'hrsh7th/cmp-path', {'branch': 'main'}
Plug 'hrsh7th/nvim-cmp', {'branch': 'main'}
Plug 'ray-x/lsp_signature.nvim'
" Rust
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'rhysd/rust-doc.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'saecki/crates.nvim', { 'tag': 'v0.1.0' }
" Lua
Plug 'wsdjeg/vim-lua'
" python
Plug 'tell-k/vim-autopep8'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
" tmux
Plug 'tmux-plugins/vim-tmux'
" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
" make it pretty
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ukyouz/onedark.vim'
" Plug 'dylanaraps/wal.vim'
Plug 'ukyouz/onedark.vim'
Plug 'airblade/vim-gitgutter'
Plug 'kovetskiy/sxhkd-vim'
Plug 'pseewald/vim-anyfold'
Plug 'machakann/vim-highlightedyank'
" file searching / exploring
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'kevinhwang91/rnvimr', { 'branch': 'main' }
Plug 'RobertAudi/git-blame.vim'
" konvenient keybinds
Plug 'scrooloose/nerdcommenter'

call plug#end()
set clipboard=unnamed

" Standard remaps
let mapleader=','
let maplocalleader='//'
nnoremap m %
vnoremap m %
nnoremap <leader>w :w<cr>
nnoremap <leader>ev :tabedit ~/.config/nvim/init.vim <cr>

" FZF
nnoremap <leader>o :FZF<cr>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Ack
nnoremap <leader>f :Ag<cr>


let g:airline_theme='deus'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

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

" rust-gdb
packadd termdebug
autocmd FileType rust let termdebugger="rust-gdb"

syntax on
" colorscheme wal
colorscheme onedark
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
" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz

" formatting
" <F1> is annoying so make it useful
autocmd FileType rust nnoremap <F1> :RustFmt<cr>
autocmd FileType python nnoremap <buffer> <F1> :Autopep8<CR>

" Normal Mode remaps
nnoremap <leader>w<space> viw
nnoremap <leader>W viW
nnoremap U <c-R>
nnoremap H ^
nnoremap L $

" Visual Mode remaps
vnoremap H ^
vnoremap L $

" markdown utility
let g:mkdp_auto_close = 0
autocmd FileType markdown nnoremap <leader>p :MarkdownPreviewToggle<cr>
autocmd FileType markdown nnoremap Q gqq
autocmd FileType markdown iabbrev NBSP &nbsp;&nbsp;&nbsp;
" correct spelling
autocmd FileType markdown nnoremap <leader>s z=
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
"
"" LSP configuration
lua << END
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require('crates').setup()
local cmp = require'cmp'

local lspconfig = require'lspconfig'
cmp.setup({
  snippet = {
    -- REQUIRED by nvim-cmp. get rid of it once we can
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    -- Tab immediately completes. C-n/C-p to select.
    ['<Tab>'] = cmp.mapping.confirm({ select = true })
  },
  sources = cmp.config.sources({
    -- TODO: currently snippets from lsp end up getting prioritized -- stop that!
    { name = 'nvim_lsp' },
  }, {
    { name = 'path' },
  }, {
      { name = 'crates' }
  }),
  experimental = {
    ghost_text = true,
  },
})

-- Enable completing paths in :
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  })
})

-- Setup lspconfig.
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- Get signatures (and _only_ signatures) when in argument lists.
  require "lsp_signature".on_attach({
    doc_lines = 0,
    handler_opts = {
      border = "none"
    },
  })
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      completion = {
	postfix = {
	  enable = false,
	},
      },
    },
  },
  capabilities = capabilities,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
END
