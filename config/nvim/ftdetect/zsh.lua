-- Eryn Wells <eryn@erynwells.me>

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*/zsh/*"},
    command = "setfiletype zsh",
})
