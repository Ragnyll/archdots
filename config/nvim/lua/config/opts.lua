HOME = os.getenv("HOME")

-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
-- shortmess: avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + { c = true}
-- updatetime: set updatetime for CursorHold
vim.api.nvim_set_option('updatetime', 300)

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
autocmd BufWritePre * %s/\s\+$//e
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

-- searching
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true


-- Markdown
vim.cmd([[
    autocmd FileType markdown nnoremap <leader>p :MarkdownPreviewToggle<cr>
    autocmd FileType markdown nnoremap Q gqq
    autocmd FileType markdown iabbrev NBSP &nbsp;&nbsp;&nbsp;
    autocmd Filetype markdown set spell spelllang=en_us
    let g:mkdp_browser = 'firefox'
]])

