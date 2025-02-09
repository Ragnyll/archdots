function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, {noremap = true, silent = true})
end

return {
    {
        "kevinhwang91/rnvimr",
        config = function()
            map('n', '<leader>t', ':RnvimrToggle<cr>')
            vim.g.rnvimr_enable_ex = 1
        end
    }
}
