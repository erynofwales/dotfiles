-- Eryn Wells <eryn@erynwells.me>

function reloadColorscheme(colorschemeName)
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
    -- know it can do it. This is required for most modern color themes.
    vim.g.termguicolors = vim.env.TERM_PROGRAM == "Apple_Terminal"

    if vim.g.colors_name == "witchhazel" then
        vim.cmd [[
            highlight! default link LineNr CursorLineNr
            highlight! default link CursorLineNr CursorLine
        ]]
    elseif vim.g.colors_name == "dracula" then
        vim.cmd [[
            highlight CursorLineNr guibg=#44475a
        ]]
    end
end

reloadColorscheme(nil)
