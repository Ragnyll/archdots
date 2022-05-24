require('plugins')
require('global') -- global variables that are not related to any particular plugin
require('colors')
require('hotkeys')

-- plug in specific stuff
require('airline')
require('nerd_commenter')
require('ack')
require('fzf')
require('rnvimr')
require('markdown_preview')
require('coc')

-- lsp stuff
require('mylsp')
require('rust-tools').setup({})
require('nvim_cmp')
