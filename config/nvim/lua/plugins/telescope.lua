function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, {noremap = true, silent = true})
end
return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        map('n', '<leader>o', ':Telescope find_files<cr>')
        map('n', '<leader>f', ':Telescope live_grep<cr>')
        map('n', '<leader>b', ':Telescope buffers<cr>')
        map('n', '<leader>h', ':Telescope help_tags<cr>')
        require('telescope').setup {
            defaults = {
                mappings = {
                    i = {
                      ["<C-n>"] = "move_selection_previous",
                      ["<C-p>"] = "move_selection_next",
                    },
                    n = {
                      ["<C-n>"] = "move_selection_previous",
                      ["<C-p>"] = "move_selection_next",
                    },

                }
            }
        }
    end
}
