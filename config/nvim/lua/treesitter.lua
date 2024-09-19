-- Treesitter configuration
-- Eryn Wells <eryn@erynwells.me>

local treesitter = require 'nvim-treesitter.configs'

-- For some reason the Lua linter complains about missing fields here even
-- though they're not requried. So, ignore the error.
---@diagnostic disable:missing-fields
treesitter.setup {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = { "c", "cpp", "javascript", "lua", "objc", "python", "rust", "vim" },
    auto_install = true,
}

vim.treesitter.language.register("objcpp", { "objc", "cpp" })
