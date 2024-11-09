-- Eryn Wells <eryn@erynwells.me>

local map = vim.keymap.set

local function init_key_opts()
    vim.g.mapleader = ","
end

local function window_key_mappings()
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
end

--
-- Language Server mappings
--

local function diagnostic_mappings()
    local options = { noremap=true, silent=true }

    -- Basic diagnostic mappings, these will navigate to or display diagnostics
    map('n', '<leader>d', vim.diagnostic.open_float, options)
    map('n', '[d', vim.diagnostic.goto_prev, options)
    map('n', ']d', vim.diagnostic.goto_next, options)
    map('n', '<leader>q', vim.diagnostic.setloclist, options)
end

local function local_lsp_mappings(buffer_number)
    local options = { noremap=true, silent=true, buffer=buffer_number }

    map('n', 'ga', vim.lsp.buf.code_action, options)
    map('n', 'gD', vim.lsp.buf.declaration, options)
    map('n', 'gd', vim.lsp.buf.definition, options)
    map('n', 'gk', vim.lsp.buf.hover, options)
    map('n', 'gi', vim.lsp.buf.implementation, options)
    map('n', 'gK', vim.lsp.buf.signature_help, options)
    map('n', '<C-i>', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
    end, options)
    map('n', '<leader>D', vim.lsp.buf.type_definition, options)
    map('n', '<leader>rn', vim.lsp.buf.rename, options)
    map('n', '<leader>ca', vim.lsp.buf.code_action, options)
    map('n', 'gr', vim.lsp.buf.references, options)

    -- Replace <leader>W in .vimrc.common
    map('n', '<leader>W', function()
        vim.lsp.buf.format { async = true }
    end, options)
end

return {
    init_key_opts = init_key_opts,
    init_window_key_mappings = window_key_mappings,
    init_diagnostic_key_mappings = diagnostic_mappings,
    init_lsp_key_mappings = local_lsp_mappings,
}
