-- Eryn Wells <eryn@erynwells.me>

local function _init_neovide()
    if not vim.g.neovide then
        return
    end

    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_position_animation_length = 0
    vim.g.neovide_scroll_animation_length = 0


    vim.cmd [[ colorscheme lunaperche ]]
end

function init_gui()
    vim.o.guifont = "Berkeley Mono,Input Mono Condensed,SF Mono,Courier New:h18"
    _init_neovide()
end

return {
    init = init_gui,
}
