return {
    "neovim/nvim-lspconfig",
    config = function()
        vim.lsp.config("*", {
            capabilities = {
                workspace = {
                    didChangeWatchedFiles = {
                        -- Enable file watching for LSP
                        --
                        -- It's disabled because the default implementation is considered slow.
                        dynamicRegistration = true,
                    },
                },
            },
        })

        for _, language_server in ipairs({
            "basedpyright",
            "biome",
            "cssls",
            "dockerls",
            "dotls",
            "emmet_language_server",
            "html",
            "jsonls",
            "lua_ls",
            "ruff",
            "svelte",
            "tailwindcss",
            "taplo",
            "vtsls",
            "yamlls",
        }) do
            vim.lsp.enable(language_server)
        end
    end,
}
