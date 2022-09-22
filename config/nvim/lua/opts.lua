HOME = os.getenv("HOME")

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300)

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
autocmd BufWritePre * %s/\s\+$//e
]])

-- Treestter folding
-- I typically dont like this, but its usefult to toggle this in my vim conf
-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

vim.cmd([[
let g:vimspector_sidebar_width = 85
let g:vimspector_bottombar_height = 15
let g:vimspector_terminal_maxwidth = 70
]])

vim.cmd([[
colorscheme onedark
hi Normal ctermbg=none
]])

vim.opt.undofile = true
vim.opt.undodir = HOME .. '/.vim/undo'
vim.opt.clipboard = unnamed
vim.opt.syntax = 'on'
vim.opt.autoindent = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.encoding = 'utf-8'

--vim.opt.relativenumber = true

-- searching
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true

-- Python specific
vim.cmd([[
autocmd FileType python let b:coc_root_patterns = ['.git', '.env']
let g:pydocstring_doq_path = '~/.local/bin/doq'
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
]])

-- Markdown
vim.cmd([[
autocmd FileType markdown nnoremap <leader>p :MarkdownPreviewToggle<cr>
autocmd FileType markdown nnoremap Q gqq
autocmd FileType markdown iabbrev NBSP &nbsp;&nbsp;&nbsp;
" correct spelling
autocmd FileType markdown nnoremap <leader>s z=
autocmd Filetype markdown set spell spelllang=en_us
" preview markdown in surf (cuz its sexy without tabs)
let g:mkdp_browser = 'surf'
let g:rnvimr_enable_ex = 1
]])
