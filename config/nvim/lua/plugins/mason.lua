function diagnostics_setup()
    -- LSP Diagnostics Options Setup
    local sign = function(opts)
      vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
      })
    end

    sign({name = 'DiagnosticSignError', text = ''})
    sign({name = 'DiagnosticSignWarn', text = ''})
    sign({name = 'DiagnosticSignHint', text = ''})
    sign({name = 'DiagnosticSignInfo', text = ''})

    vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        update_in_insert = true,
        underline = true,
        severity_sort = false,
        float = {
            border = 'rounded',
            source = 'always',
            header = '',
            prefix = '',
        },
    })

    vim.cmd([[
    set signcolumn=yes
    autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
    ]])
end

function completion_keymap_setup()
    local opts = { noremap=true, silent=true }
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
end


return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                rust_analyzer = {},
            }
        },
        setup = {
            rust_analyzer = function()
                return true
            end
        },
        config = function()
            local on_attach = function(_, bufnr)
              -- Enable completion triggered by <c-x><c-o>
              vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

              -- Mappings.
              -- See `:help vim.lsp.*` for documentation on any of the below functions
              local bufopts = { noremap=true, silent=true, buffer=bufnr }
              vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
              vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
              vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
              vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
              vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
              vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
              vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
              vim.keymap.set('n', '<space>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
              end, bufopts)
              vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
              vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
              vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
              vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
              vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
            end
            require('lspconfig')['lua_ls'].setup({ on_attach = on_attach})
            require('lspconfig')['ts_ls'].setup({ on_attach = on_attach})
            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer

            require('lspconfig')['rust_analyzer'].setup({ on_attach = on_attach })
            diagnostics_setup()
            completion_keymap_setup()
        end
    }
}
