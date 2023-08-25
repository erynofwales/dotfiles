local treesitter_configs = require 'nvim-treesitter.configs'

treesitter_configs.setup {
    ensure_installed = { "lua", "vim", "javascript", "swift" },
    sync_install = true,
    auto_install = true,
    hightlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
