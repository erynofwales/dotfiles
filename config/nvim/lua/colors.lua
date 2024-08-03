-- Eryn Wells <eryn@erynwells.me>

local function reloadColorscheme(colorschemeName)
    if colorschemeName == nil then
        vim.cmd [[
            highlight clear
        ]]
    else
        vim.cmd {
            cmd = "colorscheme",
            args = {colorschemeName},
        }
    end

    -- Make some bespoke adjustments for my cursor and line length highlights
    vim.cmd [[
        highlight ColorColumn cterm=NONE ctermbg=Black
        highlight CursorColumn cterm=NONE ctermbg=Black
        highlight CursorLine cterm=NONE ctermbg=Black
        highlight CursorLineNr cterm=bold ctermfg=White ctermbg=Black
        highlight LineNr ctermfg=DarkGray
    ]]

    -- Allow using GUI style colors (#RRGGBB hex codes) in color terminals if we
    -- know it can do it. This is required for most modern color themes. Apple's
    -- Terminal.app doesn't have True Color support though, so make sure it's
    -- off for that.
    vim.g.termguicolors = not vim.env.TERM_PROGRAM == "Apple_Terminal"

    local themeName = vim.g.colors_name
    if themeName == nil then
        vim.cmd [[
            highlight! NormalFloat ctermbg=8
        ]]
    elseif themeName == "witchhazel" then
        vim.cmd [[
            highlight! default link LineNr CursorLineNr
            highlight! default link CursorLineNr CursorLine
        ]]
    elseif themeName == "dracula" then
        vim.cmd [[
            highlight CursorLineNr guibg=#44475a
        ]]
    end
end

local function init()
    if vim.env.TERM_PROGRAM == "Apple_Terminal" then
        reloadColorscheme(nil)
    else
        reloadColorscheme("dracula")
    end
end

return {
    init = init,
    reloadColorscheme = reloadColorscheme
}
