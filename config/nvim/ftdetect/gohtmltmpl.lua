-- Eryn Wells <eryn@erynwells.me>

-- Detect layout templates in Hugo projects
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*/layouts/*.html"},
    command = "setfiletype gohtmltmpl"
})
