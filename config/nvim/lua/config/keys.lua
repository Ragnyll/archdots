function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, {noremap = true, silent = true})
end

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
