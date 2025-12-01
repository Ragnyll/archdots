function diagnostics_setup()
  -- Modern diagnostic sign config — no sign_define() needed
  vim.diagnostic.config({
    virtual_text = false,

    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN]  = "",
        [vim.diagnostic.severity.HINT]  = "",
        [vim.diagnostic.severity.INFO]  = "",
      },
    },

    update_in_insert = true,
    underline = true,
    severity_sort = false,

    float = {
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  })

  -- Always show the sign column
  vim.opt.signcolumn = "yes"

  -- Show diagnostics on cursor hold
  vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
      vim.diagnostic.open_float(nil, { focusable = false })
    end,
  })
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
            vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
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

					local client = vim.lsp.get_client_by_id(ev.data.client_id)

					-- TODO: find some way to make this only apply to the current line.
					if client.server_capabilities.inlayHintProvider then
					    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
					end

					-- None of this semantics tokens business.
					-- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
					client.server_capabilities.semanticTokensProvider = nil

					-- format on save for Rust
					if client.server_capabilities.documentFormattingProvider then
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = vim.api.nvim_create_augroup("RustFormat", { clear = true }),
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
				end,
			})

            vim.lsp.enable('lua_ls')
            vim.lsp.enable('ts_ls')
            vim.lsp.enable('qmlls')
            vim.lsp.enable('rust_analyzer')
            vim.lsp.enable('gopls')
            diagnostics_setup()
            completion_keymap_setup()
        end
    }
}
