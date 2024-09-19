-- Eryn Wells <eryn@erynwells.me>

-- Ensure there's always a gutter column so there's no stutter when changes cause it to appear.
vim.wo.signcolumn = "yes"

local gitgutter_colorscheme_group = vim.api.nvim_create_augroup("GitGutterColorSchemeOverrides", { clear = true })

local function update_gitgutter_colors()
    vim.cmd [[
        hi! SignColumn ctermbg=233
        hi! GitGutterAdd ctermbg=233
        hi! GitGutterRemove ctermbg=233
        hi! GitGutterChange ctermbg=233
        hi! GitGutterChangeDelete ctermbg=233
    ]]
end

vim.api.nvim_create_autocmd("User", {
    pattern = "GitGutter",
    callback = update_gitgutter_colors,
    group = gitgutter_colorscheme_group,
})

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = update_gitgutter_colors,
    group = gitgutter_colorscheme_group,
})
