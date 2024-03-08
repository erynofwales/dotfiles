-- Eryn Wells <eryn@erynwells.me>


local clangd_extensions = require 'clangd_extensions'
local cmp = require 'cmp'
local lspconfig = require 'lspconfig'

local keys = require 'keys'

cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- Accept currently selected item. Set `select` to `false` to only
        -- confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.recently_used,
            clangd_extensions.cmp_scores,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
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
    keys.init_lsp_key_mappings(buffer_number)
end

lspconfig.clangd.setup {
    on_attach = function(client, buffer_number)
        on_attach(client, buffer_number)

        local clangd_inlay_hints = require('clangd_extensions.inlay_hints')
        clangd_inlay_hints.setup_autocmd()
        clangd_inlay_hints.set_inlay_hints()
    end,
    capabilities = cmp_capabilities,
}

lspconfig.eslint.setup {
    on_attach = on_attach,
    capabilities = cmp_capabilities,
}

lspconfig.html.setup {
    on_attach = on_attach,
    capabilities = cmp_capabilities,
}

lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = cmp_capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
                disable = { "lowercase-global" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
        },
    },
}

lspconfig.pyright.setup {
    on_attach = on_attach,
    capabilities = cmp_capabilities,
}

lspconfig.rust_analyzer.setup {
    on_attach = function(client, buffer_number)
        print("rust-analyzer on attach")
        on_attach(client, buffer_number)
        vim.lsp.inlay_hint.enable(buffer_number)
    end,
    capabilities = cmp_capabilities,
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
        },
    },
}

lspconfig.tailwindcss.setup {
    on_attach = on_attach,
    capabilities = cmp_capabilities,
}

lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = cmp_capabilities,
}
