local servers = {
    "biome",
    "cssls",
    "emmet_language_server",
    "gdscript",
    "html",
    "ruff",
    "tailwindcss",
    "taplo",
    "typst_lsp",
    "yamlls",
}

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        -- Enable additional capabilities (i.e., autocompletion)
        "hrsh7th/cmp-nvim-lsp",
        -- Some servers (e.g., julials) would require additional configuration such as setting up the path
        -- mason-lspconfig bridges this gap and sets up everything to work perfectly with lspconfig
        { "williamboman/mason-lspconfig.nvim", config = true },
        -- Validate JSON files
        "b0o/schemastore.nvim",
    },
    config = function()
        -- Enable border for LspInfo
        require("lspconfig.ui.windows").default_options.border = "rounded"

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        -- Some servers complain if not provided (e.g., yamlls)
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        for _, lsp in ipairs(servers) do
            require("lspconfig")[lsp].setup({
                capabilities = capabilities,
            })
        end

        require("lspconfig").svelte.setup({
            capabilities = capabilities,
            settings = {
                svelte = {
                    plugin = {
                        svelte = {
                            compilerWarnings = {
                                ["a11y-click-events-have-key-events"] = "ignore",
                                ["a11y-no-static-element-interactions"] = "ignore",
                            },
                        },
                    },
                },
            },
        })

        require("lspconfig").pylance.setup({
            capabilities = capabilities,
        })

        require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            settings = { Lua = { hint = { enable = true } } },
        })

        require("lspconfig").clangd.setup({
            cmd = { "clangd", "--completion-style=detailed" },
            capabilities = capabilities,
            on_attach = function() vim.keymap.set("n", "<A-o>", "<CMD>ClangdSwitchSourceHeader<CR>", { buffer = 0 }) end,
        })

        require("lspconfig").jsonls.setup({
            capabilities = capabilities,
            settings = {
                json = {
                    schemas = require("schemastore").json.schemas(),
                    validate = { enable = true },
                },
            },
        })
    end,
}
