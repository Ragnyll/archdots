return {
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = false, -- set this if you want to always pull the latest change
        opts = {
            provider = "openai",
            openai = {
                endpoint = "https://api.openai.com/v1",
                model = "gpt-3.5-turbo",
                timeout = 30000, -- Timeout in milliseconds
                temperature = 0,
                max_tokens = 1024,
                ["local"] = false,
            },
        },
        build = "make",
        dependencies = {
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        },
    }
}
