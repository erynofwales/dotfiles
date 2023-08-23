local cmp = require 'cmp'
local lspconfig = require 'lspconfig'

cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end
    },
    window = {
        -- completion = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_signature_help" },
        { name = "ultisnips" },
        { name = "buffer" },
        { name = "path" },
    }, {
        { name = "buffer" },
    })
}

local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

-- local protocol = require('vim.lsp.protocol')

local on_attach = function(client, buffer_number)
    vim.api.nvim_buf_set_option(buffer_number, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = cmp_capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
        },
    },
}

lspconfig.html.setup {
    on_attach = on_attach,
    capabilities = cmp_capabilities,
}

lspconfig.tailwindcss.setup {
    on_attach = on_attach,
    capabilities = cmp_capabilities,
}

lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = cmp_capabilities,
}
