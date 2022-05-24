require('function/mapping')

vim.g.rnvimr_enable_ex = 1
vim.g.rnvimr_hide_gitignore = 1
nnoremap('<leader>r', '<cmd>RnvimrToggle<cr>')
vim.cmd([[ let g:rnvimr_action = { '<A-t>': 'NvimEdit tabedit', '<A-x>': 'NvimEdit split', '<A-v>': 'NvimEdit vsplit', 'gw': 'JumpNvimCwd', 'yw': 'EmitRangerCwd'}]])
