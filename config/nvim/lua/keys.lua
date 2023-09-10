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

--
-- Language Server mappings
--

-- Basic diagnostic mappings, these will navigate to or display diagnostics
local diagnostic_options = { noremap=true, silent=true }
map('n', '<leader>d', vim.diagnostic.open_float, diagnostic_options)
map('n', '[d', vim.diagnostic.goto_prev, diagnostic_options)
map('n', ']d', vim.diagnostic.goto_next, diagnostic_options)
map('n', '<leader>q', vim.diagnostic.setloclist, diagnostic_options)

function set_up_local_lsp_mappings(buffer_number)
    local options = { noremap=true, silent=true, buffer=buffer_number }

    map('n', 'gD', vim.lsp.buf.declaration, options)
    map('n', 'gd', vim.lsp.buf.definition, options)
    map('n', 'gk', vim.lsp.buf.hover, options)
    map('n', 'gi', vim.lsp.buf.implementation, options)
    map('n', 'gK', vim.lsp.buf.signature_help, options)
    map('n', '<leader>D', vim.lsp.buf.type_definition, options)
    map('n', '<leader>rn', vim.lsp.buf.rename, options)
    map('n', '<leader>ca', vim.lsp.buf.code_action, options)
    map('n', 'gr', vim.lsp.buf.references, options)

    -- Replace <leader>W in .vimrc.common
    map('n', '<leader>W', function()
        vim.lsp.buf.format { async = true }
    end, options)
end
