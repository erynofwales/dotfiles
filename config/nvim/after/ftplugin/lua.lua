-- Eryn Wells <eryn@erynwells.me>

local expand = vim.fn.expand
local resolve = vim.fn.resolve
local stdpath = vim.fn.stdpath

local configPath = resolve(stdpath("config"))
local fullPath = resolve(expand("%:p"))

if string.find(fullPath, configPath) == 1 then
    vim.opt_local.path = {
        ".",
        "",
        configPath .. "/**",
    }

    vim.opt_local.suffixesadd:append(".lua")
end
