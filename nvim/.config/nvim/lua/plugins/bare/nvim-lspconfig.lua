return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")

        lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
            capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                {
                    workspace = {
                        didChangeWatchedFiles = {
                            -- Enable file watching for LSP
                            --
                            -- It's disabled because the default implementation is considered slow.
                            -- I've tried using it but it straight up doesn't work for me.
                            --
                            -- Instead, use a custom backend.
                            -- Requires `watchman` to be installed https://github.com/facebook/watchman
                            dynamicRegistration = true,
                        },
                    },
                },
                -- Enable additional capabilities blink.cmp provides for completion
                require("blink.cmp").get_lsp_capabilities(),
                -- Enable additional capabilities for fileOperations just in case a server needs it
                require("lsp-file-operations").default_capabilities()
            ),
        })
        for _, lsp in ipairs({
            "basedpyright",
            "biome",
            "cssls",
            "dockerls",
            "dotls",
            "emmet_language_server",
            "html",
            "jsonls",
            "ruff",
            "tailwindcss",
            "taplo",
            "yamlls",
        }) do
            lspconfig[lsp].setup({})
        end

        require("plugins.lsp.lua_ls")
        require("plugins.lsp.svelte")
        require("plugins.lsp.tinymist")
        require("plugins.lsp.vtsls")
    end,
}
