return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        options = {
            theme = 'auto',
            italics = 'true'
        },
        config = function()
            require("lualine").setup({})
        end
    }
}
