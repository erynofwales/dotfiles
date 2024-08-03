-- Eryn Wells <eryn@erynwells.me>

local function _init_neovide()
    if not vim.g.neovide then
        return
    end

    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_position_animation_length = 0
    vim.g.neovide_scroll_animation_length = 0

    vim.o.guifont = "InputMonoCondensed:h16"

    vim.cmd [[ colorscheme dracula ]]
end

function init_gui()
    _init_neovide()
end

return {
    init = init_gui,
}
