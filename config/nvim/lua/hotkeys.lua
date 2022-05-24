require('function/mapping')
require('function/global_vars')

nnoremap('<leader>ev', '<cmd>tabedit ' .. HOME .. '/.config/nvim/init.vim<cr>')

nnoremap('m', '%')
vnoremap('m', '%')

-- Movement
nnoremap('U', '<c-R>')

nnoremap('H', '^')
vnoremap('H', '^')

nnoremap('L', '$')
vnoremap('L', '$')
