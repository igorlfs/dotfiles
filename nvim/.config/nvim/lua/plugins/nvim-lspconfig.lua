return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lspconfig = require("lspconfig")

        lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
            capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                -- Enable additional capabilities nvim-cmp provides for completion
                require("cmp_nvim_lsp").default_capabilities(),
                -- Enable additional capabilities for fileOperations just in case a server needs it
                require("lsp-file-operations").default_capabilities(),
                {
                    textDocument = {
                        -- Some servers complain if not provided (i.e., yamlls)
                        foldingRange = {
                            dynamicRegistration = false,
                            lineFoldingOnly = true,
                        },
                    },
                    workspace = {
                        didChangeWatchedFiles = {
                            -- Enable file watching for LSP
                            --
                            -- By default, it's disabled because the default implementation is considered slow.
                            -- I've tried using it but it straight up doesn't work for me.
                            --
                            -- Instead, use a custom backend.
                            -- Requires `watchman` to be installed https://github.com/facebook/watchman
                            dynamicRegistration = true,
                        },
                    },
                }
            ),
        })

        for _, lsp in ipairs({
            "basedpyright",
            "biome",
            "cssls",
            "dockerls",
            "emmet_language_server",
            "html",
            "ruff",
            "tailwindcss",
            "taplo",
            "yamlls",
        }) do
            lspconfig[lsp].setup({})
        end

        require("plugins.lsp.clangd")
        require("plugins.lsp.jsonls")
        require("plugins.lsp.lua_ls")
        require("plugins.lsp.svelte")
        require("plugins.lsp.tinymist")
        require("plugins.lsp.vtsls")
    end,
}
