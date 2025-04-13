return {
    "neovim/nvim-lspconfig",
    config = function()
        -- Needs to be here, otherwise gets overriden somewhere
        vim.lsp.config("*", {
            capabilities = {
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
        })

        for _, language_server in ipairs({
            "basedpyright",
            "biome",
            "cssls",
            "dotls",
            "emmet_language_server",
            "html",
            "jsonls",
            "lua_ls",
            "ruff",
            "svelte",
            "taplo",
            "vtsls",
            "yamlls",
        }) do
            vim.lsp.enable(language_server)
        end

        -- Missing leacy configs
        -- See https://github.com/neovim/nvim-lspconfig/issues/3705
        require("lspconfig")["tailwindcss"].setup({})
    end,
}
