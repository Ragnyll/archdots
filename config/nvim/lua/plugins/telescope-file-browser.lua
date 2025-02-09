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
                },
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
            })
            require("telescope").load_extension("file_browser")
            vim.keymap.set("n", "<leader><s-r>", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
            vim.keymap.set("n", "<leader>r", function()
                require("telescope").extensions.file_browser.file_browser()
            end)
        end
    }

}
