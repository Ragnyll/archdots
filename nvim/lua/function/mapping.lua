-- A collection of functions for remapping keybindings

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nnoremap(shortcut, command)
  map('n', shortcut, command)
end

function inoremap(shortcut, command)
  map('i', shortcut, command)
end

function vnoremap(shortcut, command)
  map('n', shortcut, command)
end
