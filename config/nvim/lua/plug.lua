return require('packer').startup(function()
    -- go faster
    use 'lewis6991/impatient.nvim'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    use 'neovim/nvim-lspconfig'
    use 'simrat39/rust-tools.nvim'

    -- Completion framework:
    use 'hrsh7th/nvim-cmp'

    -- LSP completion source:
    use 'hrsh7th/cmp-nvim-lsp'

    -- Useful completion sources:
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/vim-vsnip'
    use 'windwp/nvim-autopairs'

    -- Parsing libraries
    use 'nvim-treesitter/nvim-treesitter'

    -- Debugging
    use 'puremourning/vimspector'

    -- navigation
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { {'nvim-lua/plenary.nvim'} } }
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'phaazon/hop.nvim', branch = 'v2'}
    use { 'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim' }
    use 'kevinhwang91/rnvimr'

    -- cool stuff
    use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
    use 'ukyouz/onedark.vim'
    vim.cmd.highlight({ "Normal", "guibg=none" })
    vim.cmd.highlight({ "NonText", "guibg=none" })
    vim.cmd.highlight({ "Normal", "ctermbg=none" })
    vim.cmd.highlight({ "NonText", "ctermbg=none" })

    use 'airblade/vim-gitgutter'
    use 'machakann/vim-highlightedyank'
    use 'scrooloose/nerdcommenter'
    use { 'saecki/crates.nvim', tag = 'v0.2.1', requires = { 'nvim-lua/plenary.nvim' }, }
    use({ "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end, })
    use 'airblade/vim-rooter'
    use 'lukas-reineke/indent-blankline.nvim'
end)
