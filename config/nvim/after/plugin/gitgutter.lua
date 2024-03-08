-- Eryn Wells <eryn@erynwells.me>

-- Ensure there's always a gutter column so there's no stutter when changes cause it to appear.
vim.wo.signcolumn = "yes"

vim.cmd [[
    highlight GitGutterAdd ctermfg=Green ctermbg=0
    highlight GitGutterChange ctermfg=DarkBlue ctermbg=0
    highlight GitGutterDelete ctermfg=Red ctermbg=0
]]
