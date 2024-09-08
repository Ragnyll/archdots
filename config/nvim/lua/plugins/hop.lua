function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, {noremap = true, silent = true})
end

return {
    { "smoka7/hop.nvim",
        version = "*",
        opts = {
            keys = 'etovxqpdygfblzhckisuran'
        },
        config = function()
            require("hop").setup({
                keys = 'etovxqpdygfblzhckisuran',
            })
            map('n', 'f', ':HopWord<cr>')
            map('n', 'F', ':HopAnywhere<cr>')
            vim.keymap.set("v", "f", require("hop").hint_words)
            vim.keymap.set("v", "F", require("hop").hint_anywhere)
            vim.keymap.set("n", "_", require("hop").hint_lines_skip_whitespace)
            vim.keymap.set("v", "_", require("hop").hint_lines_skip_whitespace)
        end
    }
}
