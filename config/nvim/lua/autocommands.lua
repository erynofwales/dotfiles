-- Eryn Wells <eryn@erynwells.me>

vim.opt.updatetime = 300

-- Show diagnostic popup on cursor hover
local diagnostic_float_group = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float {
            border = "double",
            focusable = false,
        }
    end,
    group = diagnostic_float_group,
})
