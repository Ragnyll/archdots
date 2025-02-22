return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        numbers = function(opts)
          return string.format('%s|%s', opts.id, opts.raise(opts.ordinal))
        end,
    },
    config = function()
        require("bufferline").setup()
    end
}
