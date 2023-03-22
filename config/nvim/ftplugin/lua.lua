-- Eryn Wells <eryn@erynwells.me>

local configPath = vim.fn.stdpath("config")
local fullPath = vim.fn.expand("%:p")

if string.find(fullPath, "nvim/init.lua") then
    local dirname = vim.fn.expand("%:p:h")
    vim.opt.path:prepend(dirname)
    vim.opt.path:prepend(dirname .. "/lua")
end
