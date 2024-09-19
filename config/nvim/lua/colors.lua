-- Eryn Wells <eryn@erynwells.me>

-- Allow using GUI style colors (#RRGGBB hex codes) in color terminals if we
-- know it can do it. This is required for most modern color themes. Apple's
-- Terminal.app doesn't have True Color support though, so make sure it's
-- off for that.
vim.g.termguicolors = not vim.env.TERM_PROGRAM == "Apple_Terminal"

local colorscheme_group = vim.api.nvim_create_augroup("ColorSchemeOverrides", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.cmd [[
            hi! ColorColumn cterm=NONE ctermbg=233
            hi! CursorColumn cterm=NONE ctermbg=233
            hi! CursorLine cterm=NONE ctermbg=233
            hi! CursorLineNr cterm=bold ctermfg=White ctermbg=233
            hi! LineNr ctermfg=DarkGray ctermbg=233
        ]]
    end,
    group = colorscheme_group,
})

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "default",
    callback = function()
        vim.cmd [[ hi! NormalFloat ctermfg=8 ]]
    end,
    group = colorscheme_group,
})

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "dracula",
    callback = function()
        vim.cmd [[ highlight CursorLineNr guibg=#44475a ]]
    end,
    group = colorscheme_group,
})

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "witchhazel",
    callback = function()
        vim.cmd [[
            hi! default link LineNr CursorLineNr
            hi! default link CursorLineNr CursorLine
        ]]
    end,
    group = colorscheme_group,
})

vim.cmd [[ color zaibatsu ]]
