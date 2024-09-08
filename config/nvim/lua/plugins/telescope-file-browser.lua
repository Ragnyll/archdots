return {
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        opts = {},
        config = function()
            require("telescope").setup({
                extensions = {
                    file_browswer = {
                        hijack_netrw = true
                    }
                }
            })
            require("telescope").load_extension("file_browser")
            vim.keymap.set("n", "<leader>t", function()
                require("telescope").extensions.file_browser.file_browser()
            end)
        end
    }

}
