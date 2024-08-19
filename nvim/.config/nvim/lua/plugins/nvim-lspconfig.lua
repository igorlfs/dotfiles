local servers = {
    "biome",
    "cssls",
    "emmet_language_server",
    "html",
    "ruff",
    "tailwindcss",
    "taplo",
    "yamlls",
}

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        -- Some servers (e.g., julials) would require additional configuration such as setting up the path
        -- mason-lspconfig bridges this gap and sets up everything to work perfectly with lspconfig
        { "williamboman/mason-lspconfig.nvim", config = true },
        -- Validate JSON files
        "b0o/schemastore.nvim",
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        -- Some servers complain if not provided (e.g., yamlls)
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }
        -- Enable additional capabilities for fileOperations just in case a server needs it
        capabilities = vim.tbl_deep_extend("force", capabilities, require("lsp-file-operations").default_capabilities())
        -- (completely) Disable file watching for LSP
        --
        -- This makes the Svelte LSP use its own backend for file listening, which works nicely.
        -- Specifically, it handles file creation, and the workaround below, using `$/onDidChangeTsOrJsFile`, doesn't
        -- See this comment https://github.com/sveltejs/language-tools/issues/2008#issuecomment-2148860446
        --
        -- The main drawback of this approach is that it only works because the Svelte LSP has its own file watcher.
        -- An alternative would be to fully enable neovim's file watcher, using a custom backend (e.g., watchman).
        -- Steps
        -- (1) Installing watchman (i.e., yay -S watchman-bin)
        -- (2) Requiring this implementation https://github.com/neovim/neovim/issues/23291#issuecomment-1712422887
        -- (3) Change the line below to
        -- capabilities.workspace.didChangeWatchedFiles = { dynamicRegistration = true }
        capabilities.workspace.didChangeWatchedFiles = false

        for _, lsp in ipairs(servers) do
            require("lspconfig")[lsp].setup({
                capabilities = capabilities,
            })
        end

        require("lspconfig").tinymist.setup({
            capabilities = capabilities,
            settings = {
                formatterMode = "typstyle",
                exportPdf = "onSave",
            },
        })

        require("lspconfig").texlab.setup({
            capabilities = capabilities,
            settings = {
                texlab = {
                    build = {
                        executable = "tectonic",
                        args = { "-X", "compile", "%f", "--synctex", "--keep-intermediates" },
                        forwardSearchAfter = true,
                        onSave = true,
                    },
                    forwardSearch = {
                        executable = "zathura",
                        args = { "--synctex-forward", "%l:1:%f", "%p" },
                    },
                },
            },
        })

        require("lspconfig").svelte.setup({
            capabilities = capabilities,
            on_attach = function(client, _)
                -- Workaround to trigger reloading JS/TS files
                -- See https://github.com/sveltejs/language-tools/issues/2008
                vim.api.nvim_create_autocmd("BufWritePost", {
                    pattern = { "*.js", "*.ts" },
                    group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
                    callback = function(ctx) client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match }) end,
                })
            end,
            settings = {
                typescript = {
                    inlayHints = {
                        parameterNames = {
                            enabled = "literals",
                            suppressWhenArgumentMatchesName = true,
                        },
                        parameterTypes = { enabled = true },
                        variableTypes = { enabled = false },
                        propertyDeclarationTypes = { enabled = true },
                        functionLikeReturnTypes = { enabled = true },
                        enumMemberValues = { enabled = true },
                    },
                },
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
