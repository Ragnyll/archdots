vim.cmd('autocmd FileType markdown nnoremap <leader>p <cmd>MarkdownPreviewToggle<cr>')


-- markdown utility
vim.g.mkdp_auto_close = 0
vim.cmd('autocmd FileType markdown nnoremap Q gqq')
vim.cmd('autocmd FileType markdown iabbrev NBSP &nbsp;&nbsp;&nbsp;')
--  correct spelling
vim.cmd('autocmd FileType markdown nnoremap <leader>s z=')

-- preview markdown in surf (cuz its sexy without tabs)
vim.g.mkdp_browser = 'surf'
