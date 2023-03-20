-- Eryn Wells <eryn@erynwells.me>

-- Allow using GUI style colors (#RRGGBB hex codes) in color terminals. This is
-- required for most modern color themes.
vim.g.termguicolors = true

function reloadColorscheme(colorschemeName)
    vim.cmd {
        cmd = "colorscheme",
        args = {colorschemeName},
    }

    if vim.env.TERM_PROGRAM == "Apple_Terminal" then
        -- Add a correction for Apple's Terminal.app, which doesn't support
        -- 24-bit colors and needs some adjustment to cope.
        vim.cmd [[
            highlight default Folded cterm=bold term=bold ctermfg=NONE ctermbg=NONE
            highlight default CursorLine term=underline cterm=NONE ctermbg=0
            highlight default CursorLineNr term=underline cterm=NONE ctermfg=7 ctermbg=0
        ]]
    end

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

reloadColorscheme("dracula")
