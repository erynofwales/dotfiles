-- Filetype detection for Makefiles
-- Eryn Wells <eryn@erynwells.me>

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.make",
    command = "setfiletype make",
})
