-- Eryn Wells <eryn@erynwells.me>

local dotfilesZshGroup = vim.api.nvim_create_augroup("DotfilesZSH", {clear = true})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*/zsh/*"},
    group = dotfilesZshGroup,
    command = "setfiletype zsh",
})
