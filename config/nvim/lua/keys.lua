-- Eryn Wells <eryn@erynwells.me>

local map = vim.keymap.set

vim.g.mapleader = ","

local options = { silent = true }

-- Allow starting commands with ; instead of typing Shift-;. Save lots of keypresses!
map('n', ';', ':')

map('n', '<C-h>', '<C-w>h', options)
map('n', '<C-j>', '<C-w>j', options)
map('n', '<C-k>', '<C-w>k', options)
map('n', '<C-l>', '<C-w>l', options)

map('n', '<C-n>', ':bn<CR>', options)
map('n', '<C-p>', ':bp<CR>', options)

map('n', '<leader><space>', function()
    vim.cmd [[ setlocal invhlsearch ]]
end, options)
