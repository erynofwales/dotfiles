-- Eryn Wells <eryn@erynwells.me>

local safariToolsPath = vim.env.sfi .. "/Tools/Scripts"

vim.opt_local.path = {
    ".",
    "",
    safariToolsPath,
    safariToolsPath .. "/safaripy",
}


