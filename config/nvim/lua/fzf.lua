require('function/mapping')

nnoremap('<leader>o', '<cmd>FZF<cr>')
vim.cmd([[let g:fzf_action = {'ctrl-t': 'tab split', 'ctrl-x': 'split', 'ctrl-v': 'vsplit' }]])

