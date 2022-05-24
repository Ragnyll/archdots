require('function/mapping')
require('function/global_vars')

-- Enable persistent undo
vim.opt.undofile = true
vim.opt.undodir = HOME .. '/.vim/undo'

vim.opt.clipboard = unnamed
vim.g.mapleader = ','
vim.g.maplocalleader = '//'
vim.opt.syntax = 'on'
vim.opt.autoindent = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.encoding = 'utf-8'
vim.opt.relativenumber = true
vim.opt.number = true

-- Searching
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Search results centered please
nnoremap('n', 'nzz')
nnoremap('N', 'Nzz')

vim.cmd([[autocmd BufWritePre * %s/\s\+$//e]])
