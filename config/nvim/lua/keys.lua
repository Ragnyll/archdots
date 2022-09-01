-- Vimspector
function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, {noremap = true, silent = true})
end


vim.g.mapleader = ','
vim.g.maplocalleader = '//'

vim.cmd([[
nmap <F9> <cmd>call vimspector#Launch()<cr>
nmap <F5> <cmd>call vimspector#StepOver()<cr>
nmap <F8> <cmd>call vimspector#Reset()<cr>
nmap <F11> <cmd>call vimspector#StepOver()<cr>")
nmap <F12> <cmd>call vimspector#StepOut()<cr>")
nmap <F10> <cmd>call vimspector#StepInto()<cr>")
]])
map('n', "Db", ":call vimspector#ToggleBreakpoint()<cr>")
map('n', "Dw", ":call vimspector#AddWatch()<cr>")
map('n', "De", ":call vimspector#Evaluate()<cr>")
map('n', 'M', '%')
map('v', 'M', '%')
map('n', '<leader>ev', ':tabedit ~/.config/nvim/<cr>')
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map('n', 'U', '<c-R>')
map('n', 'H', '^')
map('n', 'L', '$')
map('v', 'H', '^')
map('v', 'L', '$')
map('n', '<F2>', ':set number! norelativenumber<cr>')
map('n', '<leader>o', ':Telescope find_files<cr>')
map('n', '<leader>f', ':Telescope live_grep<cr>')
map('n', '<leader>b', ':Telescope buffers<cr>')
map('n', '<leader>h', ':Telescope help_tags<cr>')
map('n', '<leader>r', ':Telescope file_browser<cr>')
map('n', 'f', ':HopWord<cr>')
map('n', 'F', ':HopAnywhere<cr>')
